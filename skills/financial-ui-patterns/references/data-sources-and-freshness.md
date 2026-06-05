# Data Sources and Freshness

What data the user is looking at, where it came from, and how fresh it is. Traders make decisions based on these signals; ambiguity is dangerous.

## Freshness Chain

A streaming price moves through stages. Treat each one visually so the trader knows what they're looking at.

| Stage | Trigger | Visual |
|---|---|---|
| `real-time` | Live tick within heartbeat window | Normal text, last-tick flash |
| `delayed-15` | Vendor delay (free tier, retail) | Small `15m` chip next to symbol, normal text |
| `stale` | No tick for N seconds (heartbeat lost but socket open) | Amber dot + dim cell to 75% |
| `frozen` | No tick + connection re-established without data | Strikethrough or `text-muted` |
| `disconnected` | Socket closed | Last value dim to 50%, "Reconnecting…" pill |

`N` for stale depends on asset class: equities = 3-5s during RTH, crypto = 5-10s, FX = 2-3s, illiquid contracts = 30s+.

## Source Attribution

Every price needs a discoverable source. Don't hide it.

| Pattern | When |
|---|---|
| Inline chip on symbol header (`CBOE`, `IEX`, `NBBO`) | Pro/prosumer surfaces |
| Tooltip on hover only | Retail surfaces where chip would clutter |
| Settings → "Data feed" section showing all vendors | Always, regardless of persona |
| Per-row exchange code in T&S tape | Always |

Required labels: vendor (Massive, IEX, Coinbase), feed type (NBBO, last sale, mid), and delay indicator if not real-time.

## "As of" vs "Last Update" Semantics

Two different concepts. Don't confuse them.

| Label | Meaning |
|---|---|
| `As of HH:MM:SS TZ` | Snapshot taken at this moment. Static. |
| `Last update HH:MM:SS · 3s ago` | Streaming surface, this is the most recent tick. |
| `Updated daily at 16:00 ET` | EOD batch. No mid-day refresh. |
| `Fundamentals: Q4 2025` | Periodic data, the reporting period matters more than wall clock. |

## Multi-Account Context

When a user has multiple accounts (margin, cash, IRA, paper), the active account drives every price, every order, every balance.

- Account switcher in top-right, always visible.
- Active account name + last 4 of account ID shown in the switcher.
- Color-code account types: paper = amber tint, live = neutral, restricted = red dot.
- On switch: full data swap with 200ms dim transition. Don't blank.
- Cross-account aggregation only on a dedicated "All accounts" view, never silently merged.
- Order forms always show which account the order will hit, never inferred.

## Real-Time vs Delayed Banner

If the user is on a delayed feed in a UI that implies real-time:

- Persistent banner top of page: `Showing 15-minute delayed quotes. Upgrade for real-time.`
- Dismissible per session, never silently hidden.
- Order forms add inline note: `Quote is 15 min delayed. Live quote will be fetched at submit.`

## Anti-Patterns

| Don't | Why |
|---|---|
| Real-time UI with no source attribution | Trader can't tell if it's NBBO or one venue |
| Same visual for stale and disconnected | Pros need to know if the feed died vs paused |
| Silently switch accounts on tab change | Catastrophic if order hits the wrong one |
| Aggregate paper + live balances | Misleading; keep separate at all costs |
| Hide delay in fine print | Retail confusion = lawsuits |
| Use `Last update: 12s ago` with no absolute time | Relative time becomes useless past 60s |
| Show a "live" pill on delayed data | Trust-breaking |
| Connection-lost without showing last-known value | Pros need to see what they had, even stale |
