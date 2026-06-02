# Typography & Color

## Typography

### Font stack

**Sans for UI, mono for data identifiers.** Both fonts must be loaded with `font-display: swap` and self-hosted (no Google Fonts CDN — adds 200ms+ to LCP).

```ts
// Recommended pairings used by leading platforms:
// - Geist + JetBrains Mono (used by Vercel, Linear)
// - Inter + JetBrains Mono (used by many SaaS)
// - SF Pro + SF Mono (Apple, macOS)
// - IBM Plex Sans + IBM Plex Mono (IBM, Polygon)
// - Roboto + Roboto Mono (Material, older Google Finance)

fontFamily: {
  sans: ["var(--font-geist)", "system-ui", "sans-serif"],
  mono: ["var(--font-jetbrains)", "JetBrains Mono", "ui-monospace", "monospace"],
}
```

### When to use mono

| Use case | Font |
|---|---|
| Tickers, symbols | mono |
| Order IDs, transaction hashes | mono |
| Wallet addresses | mono |
| Timestamps in trade feeds | mono |
| Prices in tables | sans + `tabular-nums` (not mono) |
| P&L values | sans + `tabular-nums` |
| Body text, labels | sans |

**Common mistake:** using mono for all prices. Bloomberg and TradingView use sans with `tabular-nums` for prices because mono is heavier and reduces density. Reserve mono for identifiers, not magnitudes.

### Type scale for financial UIs

```css
/* Compact financial scale (denser than typical product UI) */
--text-xs:   11px;  /* axis labels, table headers, micro-labels */
--text-sm:   12px;  /* table cells, ticker rows, secondary text */
--text-base: 13px;  /* default body, primary table data */
--text-md:   14px;  /* card titles, prominent labels */
--text-lg:   18px;  /* current price in ticker cards */
--text-xl:   24px;  /* major price displays, P&L hero numbers */
--text-2xl:  32px;  /* portfolio total, dashboard hero */
```

Generic SaaS UIs use 14-16px body. Financial UIs run 12-13px because density matters. Match TradingView/Bloomberg density, not Notion.

### Numeric type

Always apply to any number that may change:

```css
.tabular-nums { font-variant-numeric: tabular-nums; }
```

For prices, also consider:
```css
.financial-num {
  font-variant-numeric: tabular-nums;
  letter-spacing: -0.01em;  /* slight tighten for dense displays */
  font-feature-settings: "ss01" on;  /* JetBrains alternate forms if available */
}
```

### Labels and headers

Table column headers and uppercase micro-labels:
- 10-11px
- `font-weight: 500` (medium, not bold)
- `letter-spacing: 0.05em` (tracking-wider)
- `text-transform: uppercase`
- Always `text-text-muted` color
- Right-align if column is numeric

```tsx
<th className="text-[11px] font-medium uppercase tracking-wider text-text-muted text-right">
  Price
</th>
```

## Color

### Semantic tokens only

Never write raw color values in components. Define tokens via CSS variables, expose via Tailwind. The complete token set:

```css
:root {
  /* Surfaces — progressively elevated */
  --surface:           13 13 16;    /* page background */
  --surface-elevated:  22 22 26;    /* cards, panels */
  --surface-panel:     32 32 38;    /* nested panels, inputs */
  --surface-hover:     42 42 50;    /* row hover, button hover */

  /* Text hierarchy */
  --text-primary:   240 240 245;    /* prices, titles, primary data */
  --text-secondary: 180 180 192;    /* secondary data, descriptions */
  --text-muted:     110 110 125;    /* labels, axis, low-priority */

  /* Semantic signal colors */
  --positive: 34 197 94;    /* gains, buy, success, up tick */
  --negative: 239 68 68;    /* losses, sell, error, down tick */
  --warning:  251 191 36;   /* partial fill, stale, caution */
  --info:     0 143 250;    /* working order, neutral signal, link */

  /* Structural */
  --border:    255 255 255; /* divider line — use with opacity */
  --accent:    0 143 250;   /* brand accent */
  --focus-ring: 0 143 250;
}

[data-theme="light"] {
  --surface:           248 249 251;
  --surface-elevated:  241 243 245;
  --surface-panel:     233 236 239;
  --text-primary:      28 32 36;
  --text-secondary:    96 105 117;
  --text-muted:        139 147 158;
  --positive: 22 163 74;    /* slightly darker green for light bg */
  --negative: 220 38 38;
  --border:   0 0 0;
}
```

### Color rules

| Rule | Why |
|---|---|
| Color = signal, not decoration | Reserve color for things that change or matter |
| Prices are neutral (`text-primary`) | Coloring prices makes deltas harder to spot |
| Deltas are colored (`text-positive` / `text-negative`) | They're the actionable signal |
| Order status uses status colors | Working = info, partial = warning, filled = positive, etc. |
| Charts use signal colors | Up candles positive, down candles negative |
| Backgrounds stay neutral | Surface tokens only; never `bg-emerald-*` for cards |
| Never red/green together without secondary cue | 8% of men cannot distinguish — see `accessibility.md` |

### Surface elevation pattern

Three to four levels max:

```
page bg            → surface
card               → surface-elevated
nested panel/input → surface-panel
hover state        → surface-hover
```

More layers and the interface looks like a cake.

### Light theme is mandatory

Bloomberg Terminal, Interactive Brokers, TradingView, and Polygon Dashboard all ship light themes. Pros often prefer light during the day. Building dark-only signals retail-app aesthetic.

Use CSS variables from day one. Add `[data-theme="light"]` overrides. Test every screen in both.

### Color-coded vs color-only

Always pair color with a non-color cue. The rule: imagine the screen in grayscale — can a user still parse it?

```tsx
// ❌ BAD: color is the only signal
<span className={value >= 0 ? "text-positive" : "text-negative"}>
  {value.toFixed(2)}%
</span>

// ✅ GOOD: color + sign prefix
<span className={value >= 0 ? "text-positive" : "text-negative"}>
  {value >= 0 ? "+" : ""}{value.toFixed(2)}%
</span>

// ✅ GOOD: color + arrow icon
<span className={`flex items-center gap-1 ${value >= 0 ? "text-positive" : "text-negative"}`}>
  {value >= 0 ? "▲" : "▼"} {Math.abs(value).toFixed(2)}%
</span>
```

### Alternative palette for color-blind mode

Some pro platforms ship blue/orange as a red/green alternative:
- Positive: `#2563eb` (blue)
- Negative: `#ea580c` (orange)

Bloomberg has a setting for this. If your product is accessibility-serious, expose it.

## Spacing and density

Financial tables are denser than typical SaaS:

| Element | Compact | Comfortable |
|---|---|---|
| Table row height | 32-36px | 40-48px |
| Order book row | 24-28px | 32px |
| Card padding | 12-16px | 20-24px |
| Cell horizontal padding | 8-12px | 16px |
| Inline label-to-value gap | 4-8px | 8-12px |

Default to compact for any data-dense screen. Offer a density toggle in settings for retail/comfort modes.

## Borders

Use border for structure, not decoration. Two patterns:

```css
/* Hairline borders (Bloomberg / TradingView style) */
.border-hairline {
  border: 1px solid rgb(var(--border) / 0.08);
}

/* No border, just background contrast (Robinhood style) */
.no-border {
  background: rgb(var(--surface-elevated));
  /* relies on elevation, not lines */
}
```

For dense data tables: hairline borders between rows (`border-b border-border/5`). For card-based UIs: no inner borders, just elevation.

## Radius

Financial UIs run smaller radii than playful SaaS:
- `--radius-md: 0.375rem` (6px) for buttons, inputs
- `--radius-lg: 0.5rem` (8px) for cards, panels

Robinhood and Coinbase consumer apps use larger radii (12-16px) for retail friendliness. Pro tools (TradingView, Bloomberg, Kraken Pro) use 0-4px for serious aesthetic.

## Motion

Keep motion subtle and fast. Traders watching screens for hours hate motion.

```css
:root {
  --transition-fast: 120ms cubic-bezier(0.25, 0.1, 0.25, 1);
  --transition-base: 180ms cubic-bezier(0.25, 0.1, 0.25, 1);
}
```

- Hover transitions: 120ms
- Theme/density transitions: 180ms
- Tick flash: 300-400ms
- Never spring animations on data
- Never auto-scroll, parallax, or anything decorative
