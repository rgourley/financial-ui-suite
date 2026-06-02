# Streaming & State

Live data is the defining challenge of financial UIs. Users need to know: is this fresh? when did it last update? is the connection healthy? did this number just change?

## Connection States

Every streaming UI should expose four states explicitly:

| State | When | Visual |
|---|---|---|
| `connecting` | Initial handshake, reconnecting | Pulsing dot, "Connecting..." |
| `live` | Stream healthy, updates flowing | Green dot, possibly pulse |
| `stale` | No updates for N seconds (heartbeat lost but socket open) | Amber dot, last-update timestamp visible |
| `disconnected` | Socket closed, no recovery in progress | Red dot, "Reconnect" button |

```tsx
type ConnectionStatus = "connecting" | "live" | "stale" | "disconnected";

const STATUS_DOT: Record<ConnectionStatus, string> = {
  connecting:   "bg-text-muted animate-pulse-subtle",
  live:         "bg-positive",
  stale:        "bg-warning",
  disconnected: "bg-negative",
};

const STATUS_LABEL: Record<ConnectionStatus, string> = {
  connecting:   "Connecting",
  live:         "Live",
  stale:        "Stale",
  disconnected: "Disconnected",
};

export function ConnectionPill({ status, lastUpdate }: { status: ConnectionStatus; lastUpdate?: Date }) {
  return (
    <span className="inline-flex items-center gap-1.5 text-[11px] text-text-muted">
      <span className={`w-1.5 h-1.5 rounded-full ${STATUS_DOT[status]}`} aria-hidden />
      <span>{STATUS_LABEL[status]}</span>
      {lastUpdate && status !== "live" && (
        <span className="tabular-nums">
          · {formatRelative(lastUpdate)}
        </span>
      )}
    </span>
  );
}
```

## Tick Flash

Brief background tint on price update. Direction-aware: green if up, red if down. 300-500ms duration.

The CSS-only approach scales to hundreds of streaming cells without GPU thrash:

```tsx
import { useEffect, useRef, useState } from "react";

export function PriceCell({
  value,
  format = (n: number) => n.toLocaleString("en-US", { minimumFractionDigits: 2 }),
}: {
  value: number;
  format?: (n: number) => string;
}) {
  const prev = useRef(value);
  const [flash, setFlash] = useState<"up" | "down" | null>(null);

  useEffect(() => {
    if (value === prev.current) return;
    setFlash(value > prev.current ? "up" : "down");
    prev.current = value;
    const t = setTimeout(() => setFlash(null), 400);
    return () => clearTimeout(t);
  }, [value]);

  return (
    <span
      data-flash={flash ?? undefined}
      className="
        tabular-nums px-1 rounded-sm transition-colors duration-300
        data-[flash=up]:bg-positive/15 data-[flash=down]:bg-negative/15
      "
    >
      {format(value)}
    </span>
  );
}
```

### Tick flash anti-patterns

| Anti-pattern | Why bad |
|---|---|
| Flashing on every WebSocket message even if value unchanged | Constant flickering, ignores "no-op" updates |
| Flashing the text color (not background) | Disrupts reading; bad for accessibility |
| Long flash (1s+) | Bleeds into next update on active symbols |
| Using a JS animation library | Bundle bloat; CSS transitions are sufficient |
| Animating border or shadow | Layout shift / paint cost |
| Flashing only the number, not a clear region | Hard to spot on dense tables |
| No flash for non-price columns that update | Misses opportunity (volume, P&L should flash too) |

### When NOT to flash

- Pages where data updates less than once per minute (use a "last updated" timestamp instead)
- Long lists where 50+ cells could flash simultaneously (visual overload)
- Initial render (only flash on actual change)
- Calculated cells (don't flash a row total because a child changed)

## Staleness

Mark data stale if it hasn't updated within an expected window. Different windows for different sources:

| Source | Expected interval | Stale threshold |
|---|---|---|
| Crypto exchange WebSocket | < 1s typical | 5s |
| Stock real-time (paid) | < 1s | 5s |
| Stock delayed (free, 15min) | 15min | 16min |
| Forex | < 1s | 3s |
| ETF NAV | end of day | next day |

```tsx
const STALE_MS = 5000;

export function useStaleness(lastUpdate: Date | null) {
  const [stale, setStale] = useState(false);
  useEffect(() => {
    if (!lastUpdate) return;
    const check = () => setStale(Date.now() - lastUpdate.getTime() > STALE_MS);
    check();
    const interval = setInterval(check, 1000);
    return () => clearInterval(interval);
  }, [lastUpdate]);
  return stale;
}
```

Stale visual: dim the value (`opacity: 0.5`) or add a small "•" indicator. Don't blank the value — last known is better than nothing.

## WebSocket UI Lifecycle

```tsx
import { useEffect, useRef, useState } from "react";

type Status = "connecting" | "live" | "stale" | "disconnected";

interface UseLiveStreamOpts<T> {
  url: string;
  parser: (raw: string) => T | null;
  staleMs?: number;
}

export function useLiveStream<T>({ url, parser, staleMs = 5000 }: UseLiveStreamOpts<T>) {
  const [data, setData] = useState<T | null>(null);
  const [status, setStatus] = useState<Status>("connecting");
  const [lastUpdate, setLastUpdate] = useState<Date | null>(null);
  const wsRef = useRef<WebSocket | null>(null);
  const reconnectRef = useRef<number>(0);

  useEffect(() => {
    let cancelled = false;

    function connect() {
      const ws = new WebSocket(url);
      wsRef.current = ws;
      setStatus("connecting");

      ws.onopen = () => {
        if (cancelled) return;
        setStatus("live");
        reconnectRef.current = 0;
      };

      ws.onmessage = (e) => {
        if (cancelled) return;
        const parsed = parser(e.data);
        if (parsed === null) return;
        setData(parsed);
        setLastUpdate(new Date());
        setStatus("live");
      };

      ws.onclose = () => {
        if (cancelled) return;
        setStatus("disconnected");
        // Exponential backoff: 1s, 2s, 4s, 8s, max 30s
        const delay = Math.min(30_000, 1000 * Math.pow(2, reconnectRef.current));
        reconnectRef.current += 1;
        setTimeout(connect, delay);
      };

      ws.onerror = () => {
        ws.close();
      };
    }

    connect();
    return () => {
      cancelled = true;
      wsRef.current?.close();
    };
  }, [url, parser]);

  // Detect stale stream (socket open but no messages)
  useEffect(() => {
    if (status !== "live" || !lastUpdate) return;
    const interval = setInterval(() => {
      if (Date.now() - lastUpdate.getTime() > staleMs) {
        setStatus("stale");
      }
    }, 1000);
    return () => clearInterval(interval);
  }, [status, lastUpdate, staleMs]);

  return { data, status, lastUpdate };
}
```

## High-Frequency Update Throttling

If a symbol updates 50+ times per second, render every tick = dropped frames. Throttle to render rate (60fps = 16ms minimum interval).

Two strategies:

**Batch + flush:** accumulate ticks, flush on `requestAnimationFrame`:

```ts
function createTickBatcher<T>(onFlush: (latest: T) => void) {
  let pending: T | null = null;
  let scheduled = false;
  return (tick: T) => {
    pending = tick;
    if (scheduled) return;
    scheduled = true;
    requestAnimationFrame(() => {
      if (pending !== null) onFlush(pending);
      pending = null;
      scheduled = false;
    });
  };
}
```

**Drop stale ticks:** if the next tick arrives before render, drop the old one. Prevents tick queue growth.

```ts
let renderInFlight = false;
function onTick(tick: Tick) {
  if (renderInFlight) return;  // drop
  renderInFlight = true;
  requestAnimationFrame(() => {
    render(tick);
    renderInFlight = false;
  });
}
```

## Reconciliation: How To Update Without Layout Shift

When rows reorder (e.g., leaderboard re-sorts on tick), use a stable `key` and CSS transitions for movement:

```tsx
import { FlipMove } from "react-flip-move";  // or framer-motion's <Reorder>

<FlipMove duration={180} easing="cubic-bezier(0.25, 0.1, 0.25, 1)">
  {rows.map((r) => (
    <Row key={r.id} {...r} />
  ))}
</FlipMove>
```

Without movement animation, watching a leaderboard re-sort feels like a glitch. With it, the user can track which row moved where.

**Performance ceiling:** FlipMove and Framer Reorder handle 50-100 rows. Beyond that, freeze layout and only animate values, not positions.

## Optimistic Updates for Orders

When user submits an order, show it in the order list immediately with `status: "working"`. Reconcile when the server responds.

```tsx
function submitOrder(order: OrderInput) {
  const optimisticId = `pending-${crypto.randomUUID()}`;
  addOrder({ ...order, id: optimisticId, status: "working", createdAt: new Date() });
  api.submitOrder(order).then(
    (real) => replaceOrder(optimisticId, real),
    (err) => updateOrder(optimisticId, { status: "rejected", error: err.message }),
  );
}
```

## Don't Over-Animate

Pro traders watch screens for hours. Every animation has a tax. Strict rules:

- Tick flash: yes (signals freshness)
- Row reorder: yes when sort changes (helps tracking)
- Spinners on data tables: no (use skeleton)
- Hover background fade: yes (120ms)
- Loading shimmer on skeletons: yes, subtle
- Spring physics on anything: no
- Auto-scroll: no
- Confetti / celebration: no (this isn't Robinhood for retail; pro tools never do this)
- Parallax / page transitions: no
