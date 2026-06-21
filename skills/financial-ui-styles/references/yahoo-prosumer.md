# yahoo-prosumer

**Reference products:** Yahoo Finance (current redesign), Yahoo Finance Plus, Seeking Alpha (Premium), Investing.com, MarketWatch.

**One-line:** light consumer market-data aesthetic. White surfaces with subtle gray-blue panels, single Yahoo-blue accent for action buttons, sans + tabular nums, sidebar nav of sections (Summary, Chart, Statistics, Financials...), trending-tickers rail on the right, and a single-ticker quote page with hero price + tab strip + intraday chart + 8-cell stats grid. Chart line uses signal color (green when up, red when down), not the brand accent. Dark variant exists for the paid tier, but consumer Yahoo Finance is light-default.

## Token Set

```css
/* LIGHT (default — matches finance.yahoo.com for non-logged-in viewers) */
:root[data-theme="light"] {
  /* Surfaces — white page with subtle gray-blue tile panels */
  --surface:           255 255 255;
  --surface-elevated:  255 255 255;
  --surface-panel:     247 248 250;   /* ticker tape tiles, sidebar rails */
  --surface-hover:     239 242 246;
  --surface-rail:      250 251 253;   /* trending rail */

  /* Text */
  --text-primary:    21 27 36;
  --text-secondary:  104 111 124;
  --text-muted:      143 152 165;

  /* Signal — Yahoo's exact green/red */
  --positive:  2 138 78;              /* #028A4E */
  --negative: 216 31 42;              /* #D81F2A */
  --warning:  201 138 16;

  /* Brand accent — Yahoo blue, used only on action UI (buttons, active tabs) */
  --accent:    15 105 255;            /* #0F69FF */
  --accent-bright: 0 196 76;          /* Robinhood-style trade CTA green */

  --border-soft:  232 235 240;
  --border-mid:   221 226 232;

  /* Compare-chart palette (secondary use — for multi-ticker compare view) */
  --compare-1: 15 105 255;            /* blue   — META */
  --compare-2: 217 110 0;             /* orange — AAPL */
  --compare-3: 2 138 78;              /* green  — GOOGL */
  --compare-4: 216 31 42;             /* red    — NVDA */
  --compare-5: 200 150 0;             /* yellow — TSLA */
  --compare-6: 132 71 226;            /* violet */
  --compare-7: 0 168 204;             /* cyan */
  --compare-8: 224 90 168;            /* pink */

  --radius-md: 0.375rem;
  --radius-lg: 0.5rem;
}

/* DARK (variant — Yahoo Finance Plus / paid users) */
:root[data-theme="dark"] {
  --surface:           14 17 26;      /* slate-blue, not neutral */
  --surface-elevated:  20 24 35;
  --surface-panel:     28 33 48;
  --surface-hover:     38 44 62;
  --surface-rail:      14 18 28;
  --text-primary:    232 237 246;
  --text-secondary:  170 178 195;
  --text-muted:      112 122 142;
  --positive:  29 191 113;
  --negative: 239 78 78;
  --accent:    29 124 240;
  --accent-bright: 38 200 122;
  --border-soft: 255 255 255;         /* use with /alpha */
  --border-mid:  255 255 255;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Hero price (quote header) | Sans (Inter, -apple-system) | 28-40px | 600-700 |
| Quote delta (+1.24 +0.18%) | Sans + `tabular-nums` | 14-16px | 500 |
| Card titles | Sans | 14-16px | 600 |
| Body | Sans | 13-14px | 400-500 |
| Table cells | Sans + `tabular-nums` | 13px | 400-500 |
| Tickers / symbols | Sans (bold) — NOT mono | 12-14px | 600-700 |
| Mini ticker tape symbol | Sans | 11-12px | 600 |
| Section labels (TICKERS, OVERVIEW) | Sans uppercase, `tracking-wider` | 10-11px | 600 |
| News headline | Sans | 14-16px | 600 |
| Time / timestamp | Sans | 11-12px | 400 |

**Mono rule for this style:** sparing. Use mono only for option contract IDs, CUSIPs, exchange MIC codes. Tickers themselves are bold sans (this is a Yahoo Finance convention — they prioritize symbol legibility at small sizes over the "tickers should be mono" tradition).

## Density

| Element | Pixel range |
|---|---|
| Top ticker tape row | 36-40px |
| Watchlist row (sidebar) | 32-36px |
| Data table row | 36-40px |
| Compare-chart ticker tab | 28-32px (pill with × close) |
| Card padding | 16-20px |
| News card | 88-112px (thumb + 3-line headline) |
| Section gap | 16-24px |
| Page padding | 16-24px |

Sits one step looser than `modern-pro-dark`, one step denser than `retail-polish-dark`. Built for a consumer who watches 20-50 symbols, not 200.

## Visual Rules

- **Borders:** hairline `border-border/10` between rows, `border-border/15` between cards. Stronger `border-border/20` only on the chart frame.
- **Radius:** 6-8px on cards, 4-6px on inputs, 999px (full pill) on ticker tabs and compare-chart legend chips.
- **Shadows:** subtle on hover overlays only (`0 4px 12px rgba(0,0,0,0.4)` in dark). Cards earn elevation through `surface-elevated` bg, not shadows.
- **Gradients:** thin gradient fill under the primary chart line at 12-18% accent opacity is OK and expected. No gradients on UI chrome.
- **Hover:** bg shift to `surface-hover/60` at 120ms. Ticker tabs grow border opacity from /10 to /30 on hover.
- **Active tab:** 2px solid `--accent` underline OR full pill bg at `accent/15` with `accent` text. Pick one per surface, do not mix.
- **Focus ring:** 2px accent + 4px low-opacity halo.

## Components

### Top ticker tape
Horizontally scrolling strip pinned to top of every page. Each cell shows: symbol (sans bold), last price (tabular), change % (semantic-colored, no $ sign). Optional 16-24px tall sparkline. 36-40px row, hairline divider between cells.

```tsx
<div className="flex items-center gap-6 h-10 px-4 border-b border-border/10 bg-surface-elevated overflow-x-auto">
  {tape.map(t => (
    <div key={t.symbol} className="flex items-center gap-2 shrink-0">
      <span className="font-semibold text-sm text-text-primary">{t.symbol}</span>
      <span className="tabular-nums text-sm text-text-secondary">{t.price}</span>
      <span className={cn(
        "tabular-nums text-xs font-medium",
        t.delta >= 0 ? "text-positive" : "text-negative"
      )}>
        {t.delta >= 0 ? "+" : ""}{t.deltaPct}%
      </span>
    </div>
  ))}
</div>
```

### Multi-ticker compare chart (signature component)
The single most defining piece of this style. Renders 2-8 tickers overlaid on the same time axis, normalized to % change so different price scales coexist. Each ticker gets one color from `--compare-1..8` in pick order. Above the chart sits a row of pill-shaped ticker tabs, each with a colored dot + symbol + × close button. A "+" pill appends a new ticker via search.

- Chart frame: `border border-border/10 rounded-lg bg-surface-elevated`
- Pill tabs: 28-32px tall, `rounded-full`, `bg-surface-panel`, colored 6px dot, 12-13px symbol, × on hover
- Range toggle (1D 5D 1M 3M 6M 1Y 5Y MAX): underline-tab style
- Scale toggle (Lin / Log / %): three-way pill segmented control, % active by default for compare mode
- Y-axis labels right-aligned, `text-muted`, 10-11px
- Volume histogram below price (optional): 60-80px tall, red/green bars matching candle direction
- Crosshair on hover with floating OHLCV chip in top-right of frame

### Quote header
Symbol + name on one line, hero price + delta below, supplementary stats grid (Open/High/Low/Close/Volume/Mkt Cap) in a 6-7 column row beneath.

### Watchlist sidebar
Left-rail, 240-280px wide. Each row: symbol (bold), last price (tabular right-aligned), delta % (semantic-colored right-aligned). No icons. Drag-to-reorder handle on hover. Header has a + button and a search-this-list field.

### News card
Thumbnail left (16:9 or 1:1, 72-96px wide), 2-3 line headline right, source + age below in `text-muted`. Card has hairline border, hover lifts bg to `surface-hover/40`. No body preview — Yahoo's redesign prioritizes scan density.

### Status pills
Used for: market status (Open / Closed / Pre-Market / After-Hours), realtime indicator, earnings-this-week chip. 11px sans, 4px radius, `accent/15` bg + `accent` text + matching border.

## Anti-Patterns (Yahoo Finance specific)

| Don't | Why |
|---|---|
| Render compare-chart legend chips as rectangles | The pill shape with colored dot + × is the signature affordance |
| Use the same color for two compare lines | Each ticker MUST get its own hue from the 8-color palette |
| Use mono for ticker symbols in headers | This style breaks the "tickers are mono" rule — Yahoo uses bold sans |
| Pure black (#000) background | Background is slate-blue (#0E111A), never neutral black |
| Drop the volume histogram on the price chart | Volume is part of the prosumer expectation; only omit on tiny embeds |
| Use sentence-case section labels | `OVERVIEW`, `TICKERS`, `STATISTICS` are uppercase tracked-wider |
| Style positive deltas as plain text | Every delta is semantic-colored, with a leading `+` sign |
| Add brand color to price text | Color = signal; prices stay `text-primary`, accent stays on UI chrome |

## Example: Yahoo-flavored quote header with compare-chart frame

```tsx
<section className="rounded-lg bg-surface-elevated border border-border/10 p-5">
  <header className="flex items-center gap-2 mb-4 flex-wrap">
    <span className="text-[10px] uppercase tracking-wider text-text-muted">Tickers</span>
    {compareSet.map((t, i) => (
      <button
        key={t.symbol}
        className="group flex items-center gap-1.5 h-7 pl-2 pr-1.5 rounded-full bg-surface-panel hover:bg-surface-hover border border-border/10"
      >
        <span
          aria-hidden
          className="size-1.5 rounded-full"
          style={{ backgroundColor: `rgb(var(--compare-${i + 1}))` }}
        />
        <span className="text-xs font-semibold text-text-primary">{t.symbol}</span>
        <span className="opacity-0 group-hover:opacity-100 text-text-muted hover:text-text-primary">×</span>
      </button>
    ))}
    <button className="size-7 rounded-full bg-surface-panel hover:bg-surface-hover border border-border/10 text-text-muted">+</button>
  </header>

  <div className="flex items-baseline gap-4">
    <h1 className="text-3xl font-bold tabular-nums text-text-primary">$674.72</h1>
    <span className="text-sm tabular-nums font-medium text-positive">+$2.18 +0.32%</span>
    <span className="text-xs text-text-muted">At close · 4:00 PM EDT</span>
  </div>

  <dl className="mt-4 grid grid-cols-7 gap-x-6 text-xs">
    {[
      ["Open", "$672.50"], ["High", "$678.38"], ["Low", "$669.75"],
      ["Close", "$674.72"], ["Volume", "9.2M"], ["Mkt Cap", "$1.72T"], ["P/E", "28.4"],
    ].map(([k, v]) => (
      <div key={k} className="flex flex-col gap-0.5">
        <dt className="text-text-muted">{k}</dt>
        <dd className="tabular-nums text-text-primary font-medium">{v}</dd>
      </div>
    ))}
  </dl>
</section>
```

## Reference URLs

- Yahoo Finance — https://finance.yahoo.com (study quote pages, compare chart, watchlists, top tape)
- Yahoo Finance Plus — https://finance.yahoo.com/plus (premium features overlay)
- Seeking Alpha — https://seekingalpha.com (adjacent dark prosumer aesthetic, more editorial)
- Investing.com — https://www.investing.com (dense prosumer market data, similar layout DNA)
- MarketWatch — https://www.marketwatch.com (news-forward prosumer cousin)

## Verification (Yahoo Finance specific)

- [ ] Background is slate-blue near-black (RGB roughly `14 17 26`), not neutral / not pure
- [ ] Multi-ticker compare chart present with one distinct color per ticker
- [ ] Compare-legend tabs are pill-shaped with colored dot + symbol + × close
- [ ] Top ticker tape pinned, scrollable, 36-40px tall
- [ ] Tickers rendered in bold sans, not mono
- [ ] Every delta is semantic-colored with leading `+` sign
- [ ] Quote header has hero price 28-40px + supplementary stats grid below
- [ ] Watchlist sidebar present on multi-symbol pages
- [ ] News cards: thumbnail + 2-3 line headline only, no body preview
- [ ] Section labels (TICKERS, OVERVIEW, STATISTICS) uppercase + `tracking-wider`
- [ ] Volume histogram visible on full-size charts
- [ ] Light theme renders correctly
