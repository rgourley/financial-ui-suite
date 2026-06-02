# Component Patterns

Production-grade JSX for the most common financial UI components. Adapt to your token system.

## Holdings / Positions Table

Most common pattern. Five must-haves: tabular nums, semantic colors, right-aligned numbers, sticky header, decimal alignment.

```tsx
import { Asset, formatPrice, formatPct, formatUSD } from "@/lib/formatting";

interface Holding {
  symbol: string;
  name: string;
  price: number;
  change24h: number;
  qty: number;
  value: number;
  allocationPct: number;
}

export function HoldingsTable({ rows }: { rows: Holding[] }) {
  return (
    <div className="rounded-lg border border-border/10 bg-surface-elevated overflow-hidden">
      <table className="w-full text-sm">
        <thead className="bg-surface-panel/40 sticky top-0">
          <tr className="text-[11px] uppercase tracking-wider text-text-muted">
            <th className="px-4 py-2.5 text-left font-medium">Asset</th>
            <th className="px-4 py-2.5 text-right font-medium">Price</th>
            <th className="px-4 py-2.5 text-right font-medium">24h</th>
            <th className="px-4 py-2.5 text-right font-medium">Holdings</th>
            <th className="px-4 py-2.5 text-right font-medium">Value</th>
            <th className="px-4 py-2.5 text-right font-medium">Allocation</th>
          </tr>
        </thead>
        <tbody>
          {rows.map((r) => (
            <tr
              key={r.symbol}
              className="border-t border-border/5 hover:bg-surface-hover/30 transition-colors group"
            >
              <td className="px-4 py-3">
                <div className="flex items-center gap-2.5">
                  <AssetIcon symbol={r.symbol} />
                  <div>
                    <div className="font-mono font-medium text-text-primary">{r.symbol}</div>
                    <div className="text-xs text-text-muted leading-tight">{r.name}</div>
                  </div>
                </div>
              </td>
              <td className="px-4 py-3 text-right tabular-nums text-text-primary">
                {formatPrice(r.price)}
              </td>
              <td
                className={`px-4 py-3 text-right tabular-nums font-medium ${
                  r.change24h >= 0 ? "text-positive" : "text-negative"
                }`}
              >
                {r.change24h >= 0 ? "+" : ""}{r.change24h.toFixed(2)}%
              </td>
              <td className="px-4 py-3 text-right tabular-nums text-text-secondary">
                {r.qty.toLocaleString("en-US", { maximumFractionDigits: 6 })}
              </td>
              <td className="px-4 py-3 text-right tabular-nums font-medium text-text-primary">
                {formatUSD(r.value)}
              </td>
              <td className="px-4 py-3 text-right tabular-nums text-text-secondary relative">
                <div
                  className="absolute inset-y-2 right-4 bg-accent/10 rounded-sm"
                  style={{ width: `${Math.min(r.allocationPct, 100)}%`, maxWidth: "calc(100% - 32px)" }}
                  aria-hidden
                />
                <span className="relative">{r.allocationPct.toFixed(2)}%</span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
```

Key decisions:
- `font-mono` on ticker only, not on prices (Bloomberg pattern)
- Allocation bar behind the number, not beside it
- Hover changes background, not border (less visual noise)
- Sticky header with translucent panel background

## Order Book

Asks stack from spread upward (asks reverse-ordered), bids stack downward. Depth bars paint from the spread side toward the outer edge.

```tsx
interface BookLevel {
  price: number;
  size: number;
  cumulative: number;
}

interface OrderBookProps {
  bids: BookLevel[];  // sorted desc by price (best bid first)
  asks: BookLevel[];  // sorted asc by price (best ask first)
  midPrice: number;
  spreadBps: number;
  pair: string;
}

export function OrderBook({ bids, asks, midPrice, spreadBps, pair }: OrderBookProps) {
  const maxCumulative = Math.max(
    bids[bids.length - 1]?.cumulative ?? 0,
    asks[asks.length - 1]?.cumulative ?? 0,
  );

  return (
    <div className="rounded-lg border border-border/10 bg-surface-elevated w-80">
      <header className="px-3 py-2.5 border-b border-border/10 flex items-center justify-between">
        <span className="text-[11px] uppercase tracking-wider text-text-muted">Order Book</span>
        <span className="text-[11px] font-mono text-text-secondary">{pair}</span>
      </header>

      <div className="grid grid-cols-3 px-3 py-1.5 text-[10px] uppercase tracking-wider text-text-muted border-b border-border/5">
        <div>Price</div>
        <div className="text-right">Size</div>
        <div className="text-right">Total</div>
      </div>

      {/* Asks: reverse order so best ask sits at the bottom (closest to spread) */}
      <div>
        {asks.slice().reverse().map((a) => (
          <BookRow
            key={`a-${a.price}`}
            level={a}
            maxCumulative={maxCumulative}
            side="ask"
          />
        ))}
      </div>

      {/* Spread bar */}
      <div className="px-3 h-9 flex items-center justify-between border-y border-border/10 bg-surface-panel/40">
        <span className="text-sm font-medium text-text-primary tabular-nums">
          ${midPrice.toLocaleString("en-US", { minimumFractionDigits: 2 })}
        </span>
        <span className="text-[11px] text-text-muted tabular-nums">
          spread {spreadBps.toFixed(1)} bps
        </span>
      </div>

      {/* Bids */}
      <div>
        {bids.map((b) => (
          <BookRow
            key={`b-${b.price}`}
            level={b}
            maxCumulative={maxCumulative}
            side="bid"
          />
        ))}
      </div>
    </div>
  );
}

function BookRow({
  level,
  maxCumulative,
  side,
}: {
  level: BookLevel;
  maxCumulative: number;
  side: "bid" | "ask";
}) {
  const depthPct = (level.cumulative / maxCumulative) * 100;
  // Static class maps — never use dynamic Tailwind class names
  const depthBg = side === "bid" ? "bg-positive/10" : "bg-negative/10";
  const priceColor = side === "bid" ? "text-positive" : "text-negative";
  const fillFrom = side === "bid" ? "left-0" : "right-0";

  return (
    <div className="relative grid grid-cols-3 px-3 h-7 items-center text-xs tabular-nums hover:bg-surface-hover/40">
      <div
        className={`absolute inset-y-0 ${fillFrom} ${depthBg}`}
        style={{ width: `${depthPct}%` }}
        aria-hidden
      />
      <div className={`relative ${priceColor}`}>{level.price.toLocaleString("en-US", { minimumFractionDigits: 2 })}</div>
      <div className="relative text-right text-text-secondary">{level.size.toFixed(4)}</div>
      <div className="relative text-right text-text-muted">{level.cumulative.toFixed(4)}</div>
    </div>
  );
}
```

Key decisions:
- Asks reversed so best ask is closest to spread (Kraken/Binance convention)
- Depth bars use **cumulative** size, not raw size at level (more useful)
- Bid depth bars fill left-to-right, ask depth bars fill right-to-left
- Static class strings for depth colors (Tailwind JIT compatible)
- Spread shown in bps (basis points) — pro convention

## Ticker Card

Compact single-asset card with current price, change, sparkline, key stats.

```tsx
interface TickerCardProps {
  symbol: string;
  name: string;
  price: number;
  change24h: number;
  changePct24h: number;
  sparkline: number[];
  volume24h: number;
  marketCap: number;
}

export function TickerCard(props: TickerCardProps) {
  const up = props.changePct24h >= 0;
  const stroke = up ? "rgb(var(--positive))" : "rgb(var(--negative))";

  return (
    <article className="rounded-lg border border-border/10 bg-surface-elevated p-4 w-72 hover:border-border/20 transition-colors">
      <header className="flex items-baseline justify-between">
        <div>
          <h3 className="font-mono text-sm font-semibold text-text-primary">{props.symbol}</h3>
          <p className="text-[11px] text-text-muted leading-tight">{props.name}</p>
        </div>
        <span
          className={`text-xs tabular-nums font-medium ${up ? "text-positive" : "text-negative"}`}
        >
          {up ? "▲" : "▼"} {Math.abs(props.changePct24h).toFixed(2)}%
        </span>
      </header>

      <div className="mt-3 text-2xl font-semibold text-text-primary tabular-nums tracking-tight leading-none">
        ${props.price.toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
      </div>
      <div className={`mt-1 text-xs tabular-nums ${up ? "text-positive" : "text-negative"}`}>
        {up ? "+" : ""}${Math.abs(props.change24h).toFixed(2)}
      </div>

      <Sparkline values={props.sparkline} stroke={stroke} className="mt-3 h-12 w-full" />

      <dl className="mt-3 pt-3 border-t border-border/10 grid grid-cols-2 gap-3">
        <div>
          <dt className="text-[10px] uppercase tracking-wider text-text-muted">Volume 24h</dt>
          <dd className="text-sm text-text-secondary tabular-nums mt-0.5">
            ${formatCompact(props.volume24h)}
          </dd>
        </div>
        <div>
          <dt className="text-[10px] uppercase tracking-wider text-text-muted">Market Cap</dt>
          <dd className="text-sm text-text-secondary tabular-nums mt-0.5">
            ${formatCompact(props.marketCap)}
          </dd>
        </div>
      </dl>
    </article>
  );
}
```

## Sparkline

44x20px is the standard inline size. 200x60 for ticker cards. Always isPositive-driven color, never per-segment.

```tsx
interface SparklineProps {
  values: number[];
  stroke: string;
  width?: number;
  height?: number;
  className?: string;
  filled?: boolean;
}

export function Sparkline({
  values,
  stroke,
  width = 200,
  height = 60,
  className,
  filled = true,
}: SparklineProps) {
  if (values.length < 2) return <div className={className} />;
  const min = Math.min(...values);
  const max = Math.max(...values);
  const range = max - min || 1;
  const path = values
    .map((v, i) => {
      const x = (i / (values.length - 1)) * width;
      const y = height - ((v - min) / range) * height;
      return `${i === 0 ? "M" : "L"}${x.toFixed(1)},${y.toFixed(1)}`;
    })
    .join(" ");

  return (
    <svg viewBox={`0 0 ${width} ${height}`} className={className} aria-hidden>
      {filled && (
        <path
          d={`${path} L${width},${height} L0,${height} Z`}
          fill={stroke}
          fillOpacity="0.08"
        />
      )}
      <path
        d={path}
        fill="none"
        stroke={stroke}
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}
```

## Order Status Pill

Every pro trading UI uses status pills for orders. Filled = positive (green), Working = info (blue), Partial = warning (amber), Cancelled = muted, Rejected = negative.

```tsx
type OrderStatus = "filled" | "partial" | "working" | "cancelled" | "rejected" | "expired";

const STATUS_CLASSES: Record<OrderStatus, string> = {
  filled:    "bg-positive/10 text-positive border-positive/20",
  partial:   "bg-warning/10 text-warning border-warning/20",
  working:   "bg-info/10 text-info border-info/20",
  cancelled: "bg-surface-panel text-text-muted border-border/10",
  rejected:  "bg-negative/10 text-negative border-negative/20",
  expired:   "bg-surface-panel text-text-muted border-border/10",
};

const STATUS_LABELS: Record<OrderStatus, string> = {
  filled: "Filled",
  partial: "Partial",
  working: "Working",
  cancelled: "Cancelled",
  rejected: "Rejected",
  expired: "Expired",
};

export function OrderStatusPill({ status }: { status: OrderStatus }) {
  return (
    <span
      className={`inline-flex items-center px-1.5 py-0.5 rounded text-[11px] font-medium border ${STATUS_CLASSES[status]}`}
    >
      {STATUS_LABELS[status]}
    </span>
  );
}
```

## Watchlist Row

Compact, dense, hover-clickable. Each row should be 28-36px tall max.

```tsx
interface WatchlistRowProps {
  symbol: string;
  price: number;
  changePct: number;
  sparkline: number[];
  onClick?: () => void;
}

export function WatchlistRow({ symbol, price, changePct, sparkline, onClick }: WatchlistRowProps) {
  const up = changePct >= 0;
  return (
    <button
      onClick={onClick}
      className="w-full grid grid-cols-[1fr_auto_56px_auto] items-center gap-3 px-3 h-8 text-sm hover:bg-surface-hover/40 transition-colors"
    >
      <span className="font-mono font-medium text-text-primary text-left">{symbol}</span>
      <span className="tabular-nums text-text-secondary">
        ${price.toLocaleString("en-US", { minimumFractionDigits: 2 })}
      </span>
      <Sparkline
        values={sparkline}
        stroke={up ? "rgb(var(--positive))" : "rgb(var(--negative))"}
        width={48}
        height={16}
        filled={false}
        className="h-4"
      />
      <span
        className={`tabular-nums text-xs font-medium w-14 text-right ${
          up ? "text-positive" : "text-negative"
        }`}
      >
        {up ? "+" : ""}{changePct.toFixed(2)}%
      </span>
    </button>
  );
}
```

## Trade Feed / Time & Sales

Streaming feed of fills. Used by every pro trading UI.

```tsx
interface Trade {
  id: string;
  symbol: string;
  side: "buy" | "sell";
  price: number;
  size: number;
  timestamp: Date;
}

export function TradeFeed({ trades }: { trades: Trade[] }) {
  return (
    <div className="rounded-lg border border-border/10 bg-surface-elevated">
      <div className="grid grid-cols-4 px-3 py-1.5 text-[10px] uppercase tracking-wider text-text-muted border-b border-border/10">
        <div>Time</div>
        <div>Side</div>
        <div className="text-right">Price</div>
        <div className="text-right">Size</div>
      </div>
      <div className="max-h-96 overflow-y-auto">
        {trades.map((t) => (
          <div
            key={t.id}
            className="grid grid-cols-4 px-3 h-6 items-center text-xs tabular-nums hover:bg-surface-hover/30"
          >
            <div className="font-mono text-text-muted">
              {t.timestamp.toLocaleTimeString("en-US", { hour12: false })}
            </div>
            <div className={t.side === "buy" ? "text-positive" : "text-negative"}>
              {t.side === "buy" ? "BUY" : "SELL"}
            </div>
            <div
              className={`text-right ${t.side === "buy" ? "text-positive" : "text-negative"}`}
            >
              {t.price.toLocaleString("en-US", { minimumFractionDigits: 2 })}
            </div>
            <div className="text-right text-text-secondary">{t.size.toFixed(4)}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
```

## Candle Chart Color Convention

TradingView industry standard:
- **Up candle:** body green or hollow (border-positive, transparent fill)
- **Down candle:** body red filled (border-negative, fill-negative)
- **Doji (open == close):** thin horizontal line, no body
- **Wicks:** match body color

Heikin-Ashi and Renko use solid bodies for both directions but keep the green/red convention.

## Loading and Empty States

**Loading:** skeleton rows that match exact row dimensions. No spinners on data tables — they shift layout.

```tsx
<div className="grid grid-cols-4 px-3 h-7 items-center text-xs animate-pulse">
  <div className="h-3 w-16 bg-surface-panel rounded" />
  <div className="h-3 w-12 bg-surface-panel rounded" />
  <div className="h-3 w-20 bg-surface-panel rounded justify-self-end" />
  <div className="h-3 w-16 bg-surface-panel rounded justify-self-end" />
</div>
```

**Empty:** distinct from "no data yet" loading. Use a short label and an action.

```tsx
<div className="text-center py-12">
  <p className="text-sm text-text-muted">No positions yet</p>
  <button className="mt-2 text-xs text-accent hover:underline">Place your first order</button>
</div>
```

**Error:** never blank a table. Show last known state with a stale indicator, plus a retry.
