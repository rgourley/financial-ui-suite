# Order Entry and Lifecycle

Trading apps live or die on order entry. Most AI output ships a form with no preview, no slippage, no lifecycle states.

## Order Form Layout

| Element | Placement | Rule |
|---|---|---|
| Side toggle (Buy / Sell) | Top | Pill or segmented control, never dropdown. Buy = positive color, Sell = negative |
| Order type | Below side | Dropdown: Market, Limit, Stop, Stop-limit, Trailing, Bracket, OCO |
| Qty | Always shown | Stepper + raw input. Show `Max` shortcut. |
| Price (limit/stop) | Conditional on type | Stepper at tick size. Show last/mid/mark anchors. |
| TIF (Time-in-force) | Advanced section | DAY, GTC, IOC, FOK. Default DAY. |
| Preview | Bottom, always visible | Est. cost, fees, buying power impact |
| Submit | Bottom, full-width | Color matches side. Disabled until valid. |

## Order Types Cheat Sheet

| Type | When | UI specific to type |
|---|---|---|
| Market | Immediate fill | Slippage tolerance % field |
| Limit | Cap entry/exit price | Price field, "Post-only" toggle for crypto |
| Stop | Trigger on price | Trigger price + (optional) market/limit |
| Trailing stop | Dynamic trigger | Trail amount in $ or % |
| Bracket | Entry + take-profit + stop | Three price fields, P&L preview |
| OCO | Either-or | Two limit/stop fields, mutually cancelling |

## Preview-Then-Submit

Never go directly from form to live order. Two-step:

1. **Preview** — show estimated total, fees, current bid/ask, slippage from mid, buying power before/after.
2. **Confirm** — second button. Show countdown if quote will refresh ("Quote refreshes in 4s").

Skip preview only for: paper trading, simulator, replay mode.

## Lifecycle States

```
pending → working → partial → filled → settled
                  ↘ cancelled
                  ↘ rejected
                  ↘ expired
```

| State | Pill color | Detail |
|---|---|---|
| `pending` | `info` blue | Submitted but not yet acknowledged by broker |
| `working` | `info` blue with dot | Live in the market, no fills yet |
| `partial` | `warning` amber | Some qty filled, rest still working |
| `filled` | `positive` green | Fully filled |
| `cancelled` | `text-muted` grey | User-cancelled |
| `rejected` | `negative` red | Broker rejected with reason code |
| `expired` | `text-muted` grey | Hit TIF expiry without filling |
| `settled` | not usually shown | Filled + cleared, T+1/T+2 |

State transitions show a 200ms pill color fade. Status pill always pairs with text label, never just color.

## Optimistic UI

On submit:
- Form goes to `submitting` (button spinner, fields locked).
- Order row appears in the orders table immediately with `pending` state.
- On broker ack → `working`. On rejection → `rejected` + toast + reason.
- Roll back optimistic row only on hard timeout (>5s no ack).

## Time-and-Sales Tape

Append-only stream of trade prints. Specific patterns:

- New trades append at **top**, not bottom. Reverse-prepend.
- Cap retained rows at 2000-5000 (circular buffer).
- Aggression marker: trade at or above ask = positive tint; at or below bid = negative tint. Mid-trade = neutral.
- Show: time (ms), price, size, side (aggression-inferred), exchange code.
- Auto-scroll only when user is at top. If scrolled down, accumulate and show "N new" pill.

## Anti-Patterns

| Don't | Why |
|---|---|
| Submit without preview | One typo wipes the account |
| Use color alone for Buy/Sell | Accessibility miss; pair with label and position |
| Hide fees behind a tooltip | Pros want them inline before confirm |
| Skip the `pending` state | Submit button "succeeds" but no row appears — feels broken |
| Auto-scroll T&S when user has scrolled away | Loses their reading context |
| Pop new trades into T&S | Slide-in 80ms; pop reads as jank at high rates |
| Reject without reason code | Pros need to know what failed and how to retry |
| Block UI during preview countdown | Should be cancellable any time |
