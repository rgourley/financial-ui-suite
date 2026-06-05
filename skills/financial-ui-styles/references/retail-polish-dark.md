# retail-polish-dark

**Reference products:** Robinhood, Public, Webull (some screens), Stake.

**One-line:** pure black background, single signal color, very large display numbers, generous whitespace, large radii. Mobile-first feel translated to web. Retail-friendly polish.

## Token Set

```css
/* DARK (default — this style is dark-native) */
:root[data-theme="dark"] {
  /* Surfaces — true black or near-true-black */
  --surface:           0 0 0;          /* pure black, Robinhood style */
  --surface-elevated:  18 18 18;       /* cards */
  --surface-panel:     28 28 28;       /* nested */
  --surface-hover:     38 38 38;

  /* Text */
  --text-primary:   255 255 255;
  --text-secondary: 200 200 200;
  --text-muted:     130 130 130;

  /* Signal — single saturated color often is the brand */
  --positive: 0 200 5;                  /* Robinhood green */
  --negative: 255 80 80;
  --warning:  255 180 0;
  --info:     90 145 255;

  --accent:   0 200 5;                  /* often same as positive (brand) */

  --border:   255 255 255;
  --radius-md: 0.75rem;                 /* 12px — larger, friendly */
  --radius-lg: 1rem;                    /* 16px */
  --radius-xl: 1.25rem;                 /* 20px — used on hero cards */
}

/* LIGHT (retail apps usually skip light, but for completeness) */
:root[data-theme="light"] {
  --surface:           255 255 255;
  --surface-elevated:  248 248 248;
  --surface-panel:     240 240 240;
  --surface-hover:     232 232 232;
  --text-primary:      0 0 0;
  --text-secondary:    80 80 80;
  --text-muted:        140 140 140;
  --positive: 0 170 5;
  --negative: 220 30 50;
  --accent:   0 170 5;
  --border:   0 0 0;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Hero display (portfolio total, current price) | Sans (Capsule Sans, Inter, custom) | 32-56px | 600-700 |
| H1 page title | Sans | 20-24px | 600 |
| H2 section | Sans | 16-18px | 600 |
| Body | Sans | 14-16px | 400-500 |
| Card title | Sans | 15-16px | 600 |
| Cell text | Sans + `tabular-nums` | 14-15px | 400-500 |
| Tickers | Mono is **minimal** — usually sans bold | 14px | 600 |
| Section labels | Sans, sometimes UPPERCASE, `tracking-wide` | 11-12px | 500 |

Mono usage here is **light**. Retail apps avoid mono because it reads "engineer-coded" not "polished consumer." Tickers stay sans bold. Only timestamps and order IDs in mono.

## Density

| Element | Pixel range |
|---|---|
| Table row | 48-56px (very generous) |
| Card padding | 20-28px |
| Section gap | 24-32px |
| Page padding | 16-24px (mobile-first) |
| Tap target minimum | 44px |
| Hero number block | 80-120px tall |

Density is **the most generous** of all styles. Robinhood ships with massive whitespace. Don't fight it.

## Visual Rules

- **Borders:** mostly absent. Cards separate via elevation/background, not lines
- **Radius:** 12-20px on cards (large, friendly), 24-32px on buttons, 999px (pill) on small interactive elements
- **Shadows:** none. Pure flat black with elevation via background
- **Gradients:** permitted on hero areas (sparkline fill, charts), subtle
- **Hover:** background change to `surface-hover` at 150ms
- **Active:** bg tint on click, sometimes scale transform (0.98) for tactile feel
- **Tick flash:** present but slightly longer (500ms) and more saturated to make celebration visible

## Components

### Hero price display
- 40-56px display number, sans, weight 600-700
- Below: sign-prefixed change in 14-16px (`+$24.50 (+1.42%) Today`)
- Period selector below as pill buttons (1D / 1W / 1M / 3M / 1Y / All)
- Often a sparkline below taking full width

### Bottom sheet / card stack
- Even on web, the layout mimics mobile bottom sheets
- Order entry, asset detail open as bottom-anchored cards
- Slide-up transition (250ms)

### Pill buttons
- 32-40px tall
- 999px radius
- `bg-surface-panel` inactive, `bg-text-primary text-surface` active (inverted) or `bg-accent text-surface`
- Used for: period selectors, asset class filters, time ranges

### Action buttons (Buy/Sell)
- Large, prominent
- 48-56px tall
- 24-32px radius
- `bg-positive` for Buy, `bg-negative` for Sell, white text
- Often full-width at bottom of card

### Asset row
- 56px tall row
- Asset icon (32px) + symbol + name on left
- Sparkline + price + change on right
- No border between rows, just generous padding

### Watchlist
- Often horizontal scrolling cards on home page
- Each card ~120-160px wide
- Symbol, mini-sparkline, price, change

## Anti-Patterns (Retail Polish Dark specific)

| Don't | Why |
|---|---|
| Use mono for tickers and prices | Reads as "developer tool" not "consumer app" |
| Use small radii (<8px) | Sharp corners feel cold/institutional |
| Use hairline borders | Retail polish uses elevation, not lines |
| Add dense tables (24-32px rows) | This style is generous; cramming destroys the feel |
| Use multiple accent colors | One color is the brand identity |
| Skip the hero number | Every retail app has a giant portfolio total |
| Use serif anywhere | Retail polish is sans-only |
| Hide the sign on positive returns | Always show `+` to celebrate gains |
| Confetti / gamification on errors | Celebration only on gains/milestones |

## Example: Retail Polish Dark portfolio hero

```tsx
<section className="p-6">
  <div className="mb-1 text-sm text-text-muted">Total balance</div>
  <h1 className="text-5xl font-semibold tabular-nums tracking-tight text-text-primary">
    $24,847<span className="text-2xl text-text-secondary">.32</span>
  </h1>
  <div className="mt-2 flex items-center gap-2">
    <span className="text-base font-medium tabular-nums text-positive">
      <span aria-hidden>▲</span> +$248.50
    </span>
    <span className="text-sm tabular-nums text-positive">+1.01%</span>
    <span className="text-sm text-text-muted">Today</span>
  </div>

  <div className="mt-4 flex gap-2">
    {["1D", "1W", "1M", "3M", "1Y", "All"].map((p) => (
      <button
        key={p}
        className={`px-3 py-1.5 text-xs font-semibold rounded-full transition-colors ${
          p === "1D"
            ? "bg-text-primary text-surface"
            : "bg-surface-panel text-text-secondary hover:bg-surface-hover"
        }`}
      >
        {p}
      </button>
    ))}
  </div>

  <div className="mt-4 flex gap-3">
    <button className="flex-1 h-12 rounded-3xl bg-positive text-white font-semibold text-base">
      Buy
    </button>
    <button className="flex-1 h-12 rounded-3xl bg-surface-panel text-text-primary font-semibold text-base">
      Sell
    </button>
  </div>
</section>
```

## Reference URLs

- Robinhood — https://robinhood.com (study home, asset detail, order entry)
- Public — https://public.com (social-feed approach, similar density)
- Stake — https://hellostake.com (Australian retail broker, very polished)
- M1 Finance — https://m1.com (pie-chart focus, retail polish)

## Verification (Retail Polish Dark specific)

- [ ] Background is pure or near-pure black (#000000-#0A0A0A)
- [ ] Hero number is 32-56px and dominant on screen
- [ ] Card radii are 12-20px (visibly rounded)
- [ ] Button radii are 24-32px (very rounded, often pill)
- [ ] No hairline borders between table rows; elevation only
- [ ] Single signal color (often green) is the brand accent
- [ ] Sans throughout (no mono on tickers, no mono on prices)
- [ ] Generous row heights (48-56px)
- [ ] Period selector uses pill buttons (999px radius)
- [ ] Action buttons (Buy/Sell) are full-width, large, prominent
- [ ] Tabular nums on every number despite the friendly feel
