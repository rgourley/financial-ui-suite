# Mobile & Responsive

Financial UIs have specific mobile constraints. The table that works at 1280px breaks at 375px. The order book ladder users love on desktop becomes useless on a phone. This reference covers the mobile-specific patterns leading financial apps actually ship.

## Breakpoints

Financial UIs typically follow this convention:

| Width | Tier | Layout |
|---|---|---|
| 320-374px | Mobile small (older iPhone SE, narrow Android) | Single column, condensed |
| 375-413px | Mobile standard (iPhone 12-15) | Single column, full density |
| 414-767px | Mobile large (iPhone Pro Max, large Android) | Single column, slightly looser |
| 768-1023px | Tablet | Two-column where it fits |
| 1024-1279px | Small desktop | Multi-pane begins |
| 1280px+ | Desktop | Full multi-pane pro layouts |

**Pro tools (TradingView, Kraken Pro, Bloomberg Web) typically have a hard cutoff at ~900-1024px:** below that, the experience either degrades to a "lite" version or shows a "best on desktop" message. Many financial UIs deliberately do not optimize for narrow widths because the data density isn't usable below ~768px.

**Consumer tools (Robinhood, Coinbase, Wise) are mobile-first:** they design at 375px and scale UP. Desktop is the secondary experience.

Pick a stance per product. Don't try to make pro-density UI work at 375px — collapse to a different view instead.

## Responsive Tables

The hardest part of mobile financial UI. A 10-column options chain or a 7-column holdings table cannot fit at 375px. Four strategies, in order of preference:

### Strategy 1: Column priority + horizontal scroll

Keep the most important columns (1-3) fixed/sticky, let secondary columns scroll horizontally. Standard for options chains and order books.

```tsx
<div className="overflow-x-auto -mx-4 px-4">
  <div className="min-w-[640px] grid grid-cols-[80px_60px_70px_70px_70px_70px_70px_70px]">
    <div className="sticky left-0 bg-surface-elevated">Strike</div>
    {/* scrollable columns */}
  </div>
</div>
```

### Strategy 2: Collapse to cards (card-per-row)

Each table row becomes a vertical card with labels. Works for holdings tables, watchlists.

```tsx
{rows.map((r) => (
  <div className="border-b border-border/10 px-4 py-3">
    {/* Top row: symbol + price (most important) */}
    <div className="flex items-baseline justify-between">
      <span className="font-mono font-semibold">{r.symbol}</span>
      <span className="tabular-nums text-base font-semibold">${r.price}</span>
    </div>
    {/* Bottom row: secondary stats */}
    <div className="mt-1 flex items-baseline justify-between text-xs text-text-muted">
      <span>{r.name}</span>
      <span className={r.changePct >= 0 ? "text-positive" : "text-negative"}>
        {r.changePct >= 0 ? "+" : ""}{r.changePct.toFixed(2)}%
      </span>
    </div>
  </div>
))}
```

### Strategy 3: Expandable rows

Show 2-3 columns by default; tap to expand for full data. Good for transaction history, order list.

### Strategy 4: View toggle

User picks "Compact" or "Detailed" or "Chart" view. Push the choice to the user when the data is too rich for one view. Common in Robinhood, Public.

### Anti-pattern

**Horizontal scroll with no sticky columns** — user loses context (which row am I on?) as soon as they scroll. Always sticky the first column or use a different strategy.

## Bottom Sheets

The mobile-native equivalent of a modal. Every consumer financial app uses them: Robinhood for order entry, Coinbase for asset detail, Public for trade preview.

### Pattern

- Slides up from bottom (300-350ms ease-out)
- Drag handle (4-32px pill) at top
- Rounded top corners (24-32px)
- Backdrop dims the underlying view
- Tap backdrop or drag down to dismiss
- Three optional snap points: peek (40%), half (60%), full (90%)

```tsx
<div className="fixed inset-0 z-50">
  <div className="absolute inset-0 bg-black/60" onClick={onClose} />
  <div className="absolute inset-x-0 bottom-0 rounded-t-3xl bg-surface-elevated pb-safe">
    <div className="flex justify-center pt-2 pb-1">
      <div className="h-1 w-9 rounded-full bg-text-muted/40" />
    </div>
    <div className="px-4 pb-4">{children}</div>
  </div>
</div>
```

### When to use

- **Yes:** order entry, asset detail, settings, filters, account switcher
- **No:** primary navigation (use tab bar), critical confirmations (use modal dialog for irrevocable actions)

## Mobile Order Entry

Specific UX patterns for buying/selling on a phone:

### Amount input
- **Use `inputmode="decimal"`** to show the decimal keyboard, not the full keyboard
- **Autofocus** the amount field when the sheet opens
- **Currency or shares toggle** as pill buttons above the field
- **Quick-amount chips** below the field: `$10` `$50` `$100` `Max`
- **Live conversion** below: "≈ 0.0024 BTC"

### Confirmation step
- Always require a second tap before submitting
- Show: side (buy/sell), symbol, amount, estimated total, estimated fees
- Buy buttons: green/brand color, full-width, 56px tall
- Sell buttons: red/negative, same size

### Order type selector
- Default to Market on mobile (Robinhood, Public)
- Limit/Stop options behind an "Order type" pill or section
- Don't expose 10+ order types on mobile by default — most users want one tap

## Mobile Chart Interaction

Touch-only chart patterns:

| Gesture | Action |
|---|---|
| Tap | Show crosshair + price tooltip at touch point |
| Long-press | Same as tap; some apps use it to pin the crosshair |
| Drag (one finger) | Move crosshair along time axis |
| Pinch | Zoom in/out on time axis |
| Two-finger drag | Pan time axis |
| Swipe (horizontal) | Move between timeframes or related symbols |

### Crosshair on touch
- Vertical line only (no horizontal — clutters mobile)
- Price label at the right edge in a pill
- Time label at the bottom in a pill
- Persists while finger is down; fades on release

### Period selector
- Segmented control at bottom of chart
- 5-7 ranges (1D, 1W, 1M, 3M, 1Y, 5Y, ALL)
- 36-44pt tall (HIG-compliant)

## Tab Bar Navigation

Mobile financial apps use bottom tab bars universally.

| Pattern | Used by |
|---|---|
| Home / Browse / Watchlist / News / Account | Robinhood, Webull |
| Home / Trade / Wallet / Earn / Settings | Coinbase consumer |
| Home / Send / Receive / Cards / Profile | Wise, Revolut |
| Watchlist / News / Discover / Browse / Search | iOS Stocks |

### Conventions
- 4-5 tabs (max 5, anything beyond goes in More)
- Active tab in accent color
- Inactive tabs in `text-muted`
- 49pt height + safe area inset
- SF Symbols or equivalent icons + label
- Selected state: filled icon; unselected: outline icon

## Pull-to-Refresh

Standard for any feed-like view (watchlist, news, transactions).

### Behavior
- Threshold: ~80-120px drag distance
- Show spinner during refresh
- Show "Last updated: 2 sec ago" relative timestamp after refresh
- Don't auto-refresh if app is backgrounded (battery)

### Staleness vs refresh
- If data is older than threshold (e.g., 5 sec for streaming, 1 min for stocks): show staleness indicator (dim or dot)
- Refresh should always show progress, even if instant — confirms user action

## Safe Areas

iOS and Android both have "safe area insets" (notch, home indicator, status bar). Respect them.

```css
.has-bottom-bar {
  padding-bottom: env(safe-area-inset-bottom);
}
.has-top-bar {
  padding-top: env(safe-area-inset-top);
}
```

For Tailwind:
```html
<div class="pb-[env(safe-area-inset-bottom)]">
```

Or with `pb-safe` plugin:
```html
<div class="pb-safe">
```

### Status bar tint
Match status bar color to your top nav:
```html
<meta name="theme-color" content="#0d0d10" media="(prefers-color-scheme: dark)">
<meta name="theme-color" content="#ffffff" media="(prefers-color-scheme: light)">
```

## Mobile Keyboard Handling

- **Amounts/prices:** `inputmode="decimal"`
- **Integers (shares, quantity):** `inputmode="numeric"`
- **Search:** `inputmode="search"`
- **Email:** `inputmode="email"`
- **URLs:** `inputmode="url"`
- **Autocapitalize:** `autocapitalize="off"` for tickers, addresses, codes
- **Autocomplete:** disable for sensitive fields (API keys, addresses) with `autocomplete="off"`

### Keyboard avoidance
- When keyboard opens, scroll the focused input into view above the keyboard
- Modal/sheet contents should resize to avoid being covered
- Submit button stays visible above the keyboard (sticky bottom or appears in the iOS toolbar)

## Gestures

Conventions in financial apps:

| Gesture | Common use |
|---|---|
| Swipe-left on transaction | Show "delete" / "report" actions |
| Swipe-right on watchlist row | Quick buy/sell action |
| Long-press on chart | Pin crosshair |
| Long-press on row | Context menu (favorite, share, view details) |
| Double-tap on chart | Reset zoom to default |
| Shake | Undo last order (Robinhood used this; controversial) |

Don't invent gestures. Stick to platform conventions.

## Mobile Tick Flash

The desktop tick-flash pattern (400ms colored background on price update) works on mobile but with caveats:

- **Battery cost:** every flash triggers a paint/composite. On a watchlist with 30 symbols streaming, this drains battery fast.
- **Smaller, briefer flash:** 250ms instead of 400ms, lower opacity (8% instead of 15%)
- **Disable on cellular:** offer a setting to throttle updates on cellular data
- **Throttle to 1Hz:** at most one update per second per cell, even if data arrives faster

```tsx
const FLASH_MS = window.navigator.connection?.type === "cellular" ? 0 : 250;
```

## Mobile Density

Mobile financial UIs use larger row heights and fonts than desktop:

| Element | Desktop | Mobile |
|---|---|---|
| Body text | 12-13px | 15-17px |
| Row height (data table) | 28-36px | 44-56px |
| Tap targets | 24-32px OK | 44pt minimum |
| Hero number | 24-32px | 32-48px |
| Section padding | 16-20px | 16-24px |

Don't try to fit desktop density into a phone. Users will mis-tap or squint.

## Anti-Patterns (mobile-specific)

| Don't | Why |
|---|---|
| Force pro-density tables on mobile | Reading 10 columns at 375px is impossible |
| Use desktop-style tooltips on touch | No hover on touch; tooltips need tap-to-show |
| Skip safe area handling | Content under the notch or home indicator |
| Use modal dialogs for non-critical confirmations | Bottom sheets are the mobile-native pattern |
| Use `inputmode="text"` for amounts | Wastes user time finding the decimal |
| Disable pull-to-refresh on feeds | Universally expected pattern |
| Auto-submit orders without confirmation | Critical UX for trading |
| Place primary action mid-screen | Bottom-anchored buttons (thumb-reach) |
| Use hover states for important info | Touch has no hover |
| Make tap targets <44pt | HIG violation, fails accessibility |
| Tab bar with 6+ tabs | Max 5; overflow goes into "More" |
| Charts with desktop-only crosshair | Need tap-and-hold for touch |

## Verification (mobile-specific)

Before shipping a financial UI to mobile:

- [ ] Test at 375px width (iPhone 12-15 standard)
- [ ] Test at 320px width (iPhone SE)
- [ ] All tap targets ≥ 44pt
- [ ] Amount inputs use `inputmode="decimal"`
- [ ] Bottom sheet pattern used for non-critical modal flows
- [ ] Safe area insets respected (notch, home indicator)
- [ ] Tables use one of: horizontal scroll w/ sticky first col, card-per-row, expandable, or view toggle
- [ ] Charts respond to tap-and-hold for crosshair
- [ ] Pull-to-refresh on feed views
- [ ] Tab bar at bottom, 4-5 tabs max
- [ ] Confirmation step before submitting any order
- [ ] Mobile-specific tick flash throttling
- [ ] Status bar tint matches top nav per theme
- [ ] Keyboard avoidance: focused inputs stay visible
- [ ] No hover-dependent UI (everything works on touch)
- [ ] Tested on iOS Safari + Chrome Android (Safari is stricter)
