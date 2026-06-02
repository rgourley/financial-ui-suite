# modern-pro-dark

**Reference products:** TradingView, Kraken Pro, Hyperliquid, dYdX v4, Polygon dashboard (the older dark variant), Linear (adjacent aesthetic).

**One-line:** dark slate with single accent, sans + tabular, 4-6px radius, hairline borders, no decoration. The default for serious pro consumer financial products.

## Token Set

```css
/* DARK (default) */
:root[data-theme="dark"] {
  /* Surfaces */
  --surface:           13 13 16;    /* page bg */
  --surface-elevated:  22 22 26;    /* cards */
  --surface-panel:     32 32 38;    /* nested panels */
  --surface-hover:     42 42 50;    /* row hover */

  /* Text */
  --text-primary:   240 240 245;
  --text-secondary: 180 180 192;
  --text-muted:     110 110 125;

  /* Signal */
  --positive: 34 197 94;
  --negative: 239 68 68;
  --warning:  251 191 36;
  --info:     0 143 250;

  /* Brand accent — single hue */
  --accent:   0 143 250;            /* Modern blue. Or 168 85 247 for purple. */

  --border:   255 255 255;          /* used with /alpha */
  --radius-md: 0.375rem;            /* 6px */
  --radius-lg: 0.5rem;              /* 8px */
}

/* LIGHT */
:root[data-theme="light"] {
  --surface:           248 249 251;
  --surface-elevated:  241 243 245;
  --surface-panel:     233 236 239;
  --surface-hover:     225 228 232;
  --text-primary:      28 32 36;
  --text-secondary:    96 105 117;
  --text-muted:        139 147 158;
  --positive: 22 163 74;
  --negative: 220 38 38;
  --accent:   0 143 250;
  --border:   0 0 0;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Display (hero numbers, portfolio total) | Sans (Geist, Inter) | 24-32px | 600 |
| Card titles | Sans | 14-16px | 600 |
| Body | Sans | 13px | 400-500 |
| Table cells | Sans + `tabular-nums` | 12-13px | 400-500 |
| Tickers / symbols / IDs | Mono (JetBrains Mono, IBM Plex Mono) | 12-14px | 500-600 |
| Section labels | Sans uppercase, `tracking-wider` | 10-11px | 500 |
| Code / API keys | Mono | 12px | 400 |

Mono is **only** for tickers, IDs, addresses, code. Prices use sans + `tabular-nums`. This is the TradingView/Kraken convention.

## Density

| Element | Pixel range |
|---|---|
| Table row | 28-32px |
| Order book row | 24-28px |
| Card padding | 16-20px |
| Cell horizontal padding | 8-12px |
| Section gap | 16-24px |
| Page padding | 24-32px |

## Visual Rules

- **Borders:** hairline `border-border/10` between rows, `border-border/15` between sections.
- **Radius:** 6-8px on cards, 6px on buttons/inputs, 0-4px on inline tags/pills.
- **Shadows:** essentially none. Elevation comes from `surface-elevated` background, not shadows.
- **Gradients:** none on UI surfaces. Permitted only in sparkline fill (8% opacity) and chart areas.
- **Hover:** background change to `surface-hover/30` at 120ms transition. Never border change.
- **Active state:** 2px solid line under tab (using `--accent`), never bg fill.
- **Focus ring:** 2px accent ring + 4px low-opacity halo.

## Components

### Header
- 56-64px tall
- Logo left, primary nav center or left, account/balance right
- Hairline border bottom
- No shadow

### Table
- Sticky header with `bg-surface-panel/40` (slightly translucent)
- Right-align numbers, left-align labels
- Hover row only (no zebra striping; zebra is Editorial Financial territory)
- Active row: `bg-surface-panel/60` with 2px accent left border

### Tabs
- Underline-style only (no pill tabs)
- 11-12px label, sans, sentence case
- 8-12px padding
- Active: `border-accent` 2px underline, primary text color
- Inactive: `text-text-muted`, transparent underline

### Buttons
- Primary: solid `bg-accent` with `text-white`, 6px radius, 8-12px vertical / 16-20px horizontal padding
- Secondary: `bg-surface-elevated` with `text-text-primary` and `border-border/15`
- Ghost: text-only with hover `bg-surface-hover/40`

### Status pills
- 11px text, 4-6px horizontal / 2-3px vertical padding
- Border + bg with 15% accent opacity + matching text color
- Tiny 6px circle indicator on streaming/status pills

## Anti-Patterns (Modern Pro Dark specific)

| Don't | Why |
|---|---|
| Use heavy drop shadows | Trading UI looks dated with shadows |
| Use multiple accent colors | Single hue identity; deltas use signal colors |
| Use rounded buttons (>10px) | Reads as retail, not pro |
| Use serif for any text | Modern Pro Dark is sans-only |
| Add decorative micro-illustrations | Pros want signal density, not delight |
| Use brand color for prices | Color = signal, not decoration. Prices stay `text-primary` |
| Animate transitions over 200ms | Traders watch for hours; slow motion fatigues |

## Example: Modern Pro Dark futures option chain header

```tsx
<header className="px-5 py-4 border-b border-border/10 bg-surface-elevated">
  <div className="flex items-baseline justify-between">
    <div className="flex items-baseline gap-3">
      <h1 className="font-mono text-lg font-semibold text-text-primary">/ES</h1>
      <span className="text-sm text-text-secondary">E-mini S&P 500</span>
      <span className="text-[11px] uppercase tracking-wider text-text-muted">·</span>
      <span className="font-mono text-xs text-text-secondary">Dec 2026</span>
    </div>
    <span className="inline-flex items-center gap-1 px-1.5 py-0.5 rounded text-[10px] font-medium border bg-positive/15 text-positive border-positive/30">
      <span aria-hidden className="size-1.5 rounded-full bg-current" />
      Live
    </span>
  </div>
  <dl className="mt-3 grid grid-cols-7 gap-x-6">
    {/* stats grid here */}
  </dl>
</header>
```

## Reference URLs

- TradingView — https://www.tradingview.com/chart/ (study chart toolbar, watchlist, depth panel)
- Kraken Pro — https://pro.kraken.com (study order book, trade form, history tabs)
- Hyperliquid — https://app.hyperliquid.xyz (perp DEX, dense pro feel)
- dYdX v4 — https://dydx.trade (modern pro perp DEX)
- Polygon dashboard — https://polygon.io/dashboard (older API-side variant)

## Verification (Modern Pro Dark specific)

- [ ] No `bg-zinc-*` or hex values — only semantic tokens
- [ ] Mono font used ONLY on tickers, IDs, addresses, code
- [ ] All numbers have `tabular-nums`
- [ ] Tabs use 2px underline, never pill backgrounds
- [ ] No gradients except sparkline fill (and at <10% opacity)
- [ ] No drop shadows on cards or panels
- [ ] Row hover is bg change only, never border
- [ ] Density: table rows are 28-32px, order book rows 24-28px
- [ ] Light theme renders correctly
- [ ] Accent color used sparingly (active tab, primary button, focus ring) — never on prices
