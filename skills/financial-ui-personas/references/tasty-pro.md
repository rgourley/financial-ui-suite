# tasty-pro

**Reference products:** TastyTrade (tastytrade.com platform — web and desktop), TastyLive (educational brand).

**One-line:** options-trader-optimized pro UI. Black background, distinctive pink-magenta accent, sans + tabular nums. Designed for options chains, Greeks visibility, probability-of-profit metrics, and strategy building. Singular among financial UIs for its options-first opinionation.

## Token Set

```css
:root[data-theme="dark"] {
  --surface:           10 10 10;
  --surface-elevated:  22 22 24;
  --surface-panel:     32 32 36;
  --surface-hover:     44 44 50;

  --text-primary:   245 245 248;
  --text-secondary: 188 188 196;
  --text-muted:     128 128 138;

  /* Signature pink-magenta */
  --accent: 233 25 121;
  --accent-soft: 233 25 121 / 0.18;

  --positive: 12 220 100;
  --negative: 255 80 80;
  --warning:  255 190 30;

  --iv-low:  100 180 255;
  --iv-high: 255 100 200;

  --border: 255 255 255;
  --radius-md: 0.375rem;
  --radius-lg: 0.5rem;
}

:root[data-theme="light"] {
  --surface:           248 248 250;
  --surface-elevated:  240 240 245;
  --surface-panel:     230 230 236;
  --text-primary:      18 18 22;
  --text-secondary:    78 78 86;
  --text-muted:        140 140 150;
  --accent: 200 20 100;
  --positive: 0 140 60;
  --negative: 200 30 30;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Hero numbers (strategy P&L, IV rank) | Sans (Inter) | 28-36px | 600-700 |
| H1 section | Sans | 18-20px | 600 |
| Body | Sans | 13-14px | 400-500 |
| Table cells / option chain | Sans + `tabular-nums` | 12-13px | 500 |
| Tickers / strikes | Mono | 12-13px | 600 |
| Greek labels (Δ Γ Θ ν ρ) | Sans italic | 12-13px | 500 |
| Section labels | Sans UPPERCASE, `tracking-wider` | 10-11px | 600 |

Greeks always rendered as their Greek letters (Δ, Γ, Θ, ν / Vega, ρ), not "Delta" etc.

## Density

| Element | Pixel range |
|---|---|
| Option chain row | 30-34px |
| Standard table row | 32-36px |
| Strategy card | 80-120px tall |
| Cell horizontal padding | 8-12px |

Slightly more generous than Modern Pro Dark to accommodate Greeks and probability metrics inline.

## Visual Rules

- **Borders:** hairline `border-border/12` between rows; magenta accent border on active selection
- **Radius:** 4-8px, slightly more rounded than Modern Pro Dark
- **Shadows:** none
- **Gradients:** allowed on IV rank visualizations (blue→magenta gradient bar)
- **Hover:** bg change to `surface-hover/40`
- **Focus:** magenta ring + soft halo

## Persona-Specific Patterns

### Options chain (the centerpiece)
- Strike column down the middle (mono)
- Calls left, Puts right (standard layout)
- Greeks always visible — never hover-only:
  - Δ Delta (most important, always shown)
  - Γ Gamma (when expanded)
  - Θ Theta (decay)
  - ν Vega (vol sensitivity)
- POP (probability of profit) shown as percentage
- IV rank as background tint (intensity = IV percentile)
- Expected move bands as shaded zones around mark price

### IV rank visualizer
- Horizontal bar 0-100
- Gradient: cool blue at low end, magenta at high end
- Current IVR position marked
- Reads "IVR 42 · 30D"

### Expected move
- Shown on chain header
- Format: `Exp Move ±$58.40 (1σ)`
- Visualized as shaded band on price chart

### Strategy builder cards
- One card per leg (sell put, buy put, etc.)
- Color coding: pink for short, white for long
- Net premium shown at top
- Max profit / max loss / breakeven explicit
- Probability profile chart at bottom of each strategy

### Position P&L curve
- Used on open positions
- Plots P&L across underlying price range
- Current spot marked with vertical line
- Breakeven points marked with crosshatch
- Max profit and max loss shaded zones

### Trade ticket
- Buy/Sell buttons in pink (signature)
- Quantity stepper with large hit targets
- Order type selector (Limit / Market / Mid / Natural)
- "Send Order" button is large, pink, full-width

## Anti-Patterns (Tasty-style specific)

| Don't | Why |
|---|---|
| Hide Greeks behind hover | Persona's selling point is Greeks visibility |
| Use Modern Pro Dark's blue accent | The magenta IS the identity |
| Ship without IV rank | Table stakes for options trading |
| Ship without expected move | Same |
| Use sans for strikes | Strikes use mono for alignment |
| Use generic green/red on buttons | Tasty uses pink/magenta |
| Show only call OR put | Always show both sides symmetrically |
| Use small radii (<4px) | Reads too pro-terminal-ish |
| Skip strategy P&L graph | Defines the persona |

## Example: option chain row

```tsx
<div className="grid items-center px-2 h-8 text-xs hover:bg-surface-hover/40" style={{ gridTemplateColumns: "60px 60px 50px 56px 56px 80px 56px 56px 50px 60px 60px" }}>
  {/* Calls left */}
  <span className="text-right tabular-nums text-text-muted">2,103</span>
  <span className="text-right tabular-nums text-text-muted">8,247</span>
  <span className="text-right tabular-nums text-text-muted">15.4%</span>
  <span className="text-right tabular-nums text-text-secondary"><i>Δ</i> .82</span>
  <span className="text-right tabular-nums text-positive font-semibold">98.50</span>
  <span className="text-right tabular-nums text-negative font-semibold">99.25</span>

  {/* Strike center */}
  <span className="text-center tabular-nums font-mono font-semibold text-text-primary">5,750</span>

  {/* Puts right */}
  <span className="text-right tabular-nums text-positive font-semibold">1.25</span>
  <span className="text-right tabular-nums text-negative font-semibold">1.50</span>
  <span className="text-right tabular-nums text-text-secondary"><i>Δ</i> -.18</span>
  <span className="text-right tabular-nums text-text-muted">17.2%</span>
  <span className="text-right tabular-nums text-text-muted">6,234</span>
</div>
```

## Reference URLs

- TastyTrade — https://tastytrade.com (live platform requires account)
- TastyLive — https://www.tastylive.com (education brand, shares visual identity)

## Verification (Tasty Pro specific)

- [ ] Background is near-black (#0A0A0A)
- [ ] Pink-magenta accent `rgb(233, 25, 121)` is the brand color
- [ ] Greeks (Δ Γ Θ ν ρ) shown as Greek letters, not spelled out
- [ ] Delta visible in every option chain row (never hover-only)
- [ ] IV rank shown numerically AND as gradient visualization
- [ ] Expected move displayed prominently on options chain
- [ ] Strategy P&L curve included for active multi-leg positions
- [ ] Probability of profit (POP) shown as percentage
- [ ] Buy/Sell buttons use pink-magenta (not generic green/red)
- [ ] Calls left, Puts right, strike centered (industry standard)
- [ ] Mono only on strikes and IDs, sans on prices
