# editorial-financial

**Reference products:** Financial Times (ft.com), Bloomberg.com, Wall Street Journal (wsj.com), Reuters, The Economist, Stratechery.

**One-line:** newspaper sensibility for financial data. Cream/beige or off-white background, serif headlines, sans body, mono for data tables. Longer-form analysis blocks interleaved with structured data.

## Token Set

```css
/* LIGHT (default for editorial) */
:root[data-theme="light"] {
  /* Surfaces — FT's signature pinkish-beige and warm cream variants */
  --surface:           255 247 234;    /* FT salmon-cream #FFF1E5 */
  --surface-elevated:  255 244 227;    /* slightly warmer */
  --surface-panel:     252 240 220;    /* nested panels */
  --surface-hover:     248 234 213;

  /* Text — high contrast on cream */
  --text-primary:   28 22 16;          /* near-black with warm hint */
  --text-secondary: 80 70 60;
  --text-muted:     145 130 115;

  /* Signal — slightly desaturated for newspaper feel */
  --positive: 22 122 64;               /* deeper green */
  --negative: 184 36 36;               /* deeper red */
  --warning:  201 142 36;
  --info:     30 86 144;               /* navy */

  --accent:   199 60 70;               /* FT salmon-red. Or use brand accent. */
  --border:   28 22 16;                /* used with /alpha */
  --radius-md: 0.125rem;               /* 2px — sharp */
  --radius-lg: 0.25rem;                /* 4px — slightly rounded only */
}

/* DARK */
:root[data-theme="dark"] {
  --surface:           20 17 14;        /* near-black with warm hint */
  --surface-elevated:  28 24 20;
  --surface-panel:     38 32 26;
  --surface-hover:     48 40 32;
  --text-primary:      240 230 218;     /* cream */
  --text-secondary:    195 180 165;
  --text-muted:        130 115 100;
  --positive: 67 178 89;
  --negative: 234 64 64;
  --accent:   232 100 110;
  --border:   255 245 230;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Display / article headline | Serif (Mercury, Tiempos Headline, Source Serif 4, Lyon Display) | 32-48px | 600-700 |
| H2 section | Serif | 22-28px | 600 |
| Lead paragraph | Sans (Inter, source sans) | 17-18px | 400, 1.55 leading |
| Body / article | Sans or serif body (FT uses Financier sans + serif blend) | 15-16px | 400, 1.6 leading |
| Data table cells | Mono + `tabular-nums` (IBM Plex Mono, Roboto Mono) | 13-14px | 400 |
| Table headers | Sans uppercase, `tracking-wider` | 11-12px | 600 |
| Bylines / metadata | Sans | 12-13px | 500, italics OK |
| Pull quote | Serif italic | 22-32px | 400 |

**Editorial Financial is the one persona where data tables use mono.** Newspapers print data tables in mono; reproduce that on screen.

## Density

| Element | Pixel range |
|---|---|
| Table row | 36-44px |
| Card padding | 20-28px |
| Article body line-height | 1.55-1.65 |
| Section gap | 32-48px |
| Page gutters | 32-64px |
| Article max-width | 680-720px |

Slower pace than Modern Pro Dark. Editorial assumes the user reads, not just scans.

## Visual Rules

- **Borders:** solid hairlines `border-border/15` between sections; thicker `border-border/30` between major article blocks
- **Radius:** 0-4px. Sharp corners on cards, panels, buttons. Newspaper-like.
- **Shadows:** none on UI. Print-like aesthetic.
- **Drop caps:** allowed for article body opening paragraphs
- **Pull quotes:** styled with serif italic, larger size, accent color border-left
- **Section separators:** sometimes a horizontal hairline + accent-colored 1ch wide dot or icon, FT-style
- **Image treatment:** flat, no shadows, no rounding
- **Zebra striping:** OK on data tables (alternating very-subtle row tint). Newspapers do this; Modern Pro Dark does not.

## Components

### Article header
- Section label (`MARKETS`, `EQUITIES`) ALL CAPS sans, 11px, accent color, above headline
- Headline in display serif
- Byline + timestamp in sans, italic OK
- Featured image flat, no rounding
- Lead paragraph 17-18px with generous leading

### Data table
- Mono numbers, sans labels
- Zebra striping subtle: `surface-elevated/40` on even rows
- Column headers: sans uppercase, accent-colored 2px bottom border
- No hover row background (newspaper feel, not interactive)
- Sortable indicators are small triangles in accent color

### Inline market data
- Inline price tickers within article body use mono, `text-positive`/`text-negative`, sign prefix
- Format: `S&P 500 5,847.25 +12.75 (+0.22%)`

### Charts
- Single brand accent line color
- Hairline grid
- Axes labels in sans uppercase 10px
- No fill below line by default (FT style)
- Annotations as serif italic for editorial notes

### Buttons
- Solid `bg-accent` text-white, 2-4px radius, 8-12px padding
- Secondary: text + bottom border (link-like)
- "Read more" / "View full table" pattern instead of generic CTAs

## Anti-Patterns (Editorial specific)

| Don't | Why |
|---|---|
| Use 16+ px radius | Reads as retail product, not newspaper |
| Use heavy drop shadows | Print aesthetic — no shadows |
| Use bright neon accents | Editorial reads quietly; saturated colors disrupt |
| Skip serif for headlines | Headlines define the aesthetic |
| Use only mono | Body must be sans/serif for readability |
| Animate transitions | Newspaper feel is static |
| Hide bylines/timestamps | Editorial trust requires attribution |
| Replace table mono with sans | Newspaper tables are mono — keep it |

## Example: Editorial Financial market summary card

```tsx
<article className="bg-surface-elevated border border-border/15 p-6">
  <div className="flex items-baseline justify-between border-b border-border/15 pb-3">
    <span className="text-[11px] uppercase tracking-wider text-accent font-semibold">
      US Equities · Closing Bell
    </span>
    <time className="text-xs italic text-text-muted">June 1, 2026, 4:00pm ET</time>
  </div>

  <h2 className="mt-4 font-serif text-2xl font-semibold leading-tight text-text-primary">
    S&P 500 closes at record high as tech rally extends
  </h2>

  <p className="mt-3 text-base leading-relaxed text-text-secondary">
    The S&P 500 added <span className="font-mono tabular-nums text-positive">+12.75</span>{" "}
    (<span className="font-mono tabular-nums text-positive">+0.22%</span>) to close at{" "}
    <span className="font-mono tabular-nums">5,847.25</span>, a fresh all-time high.
  </p>

  <table className="mt-5 w-full text-sm">
    <thead>
      <tr className="border-b-2 border-accent text-text-muted uppercase tracking-wider text-[10px]">
        <th className="text-left py-2">Index</th>
        <th className="text-right py-2">Close</th>
        <th className="text-right py-2">Change</th>
        <th className="text-right py-2">%</th>
      </tr>
    </thead>
    <tbody className="font-mono">
      <tr className="border-b border-border/10 odd:bg-surface-elevated/40">
        <td className="font-sans py-2.5">S&P 500</td>
        <td className="text-right tabular-nums py-2.5">5,847.25</td>
        <td className="text-right tabular-nums text-positive py-2.5">+12.75</td>
        <td className="text-right tabular-nums text-positive py-2.5">+0.22%</td>
      </tr>
      {/* more rows */}
    </tbody>
  </table>
</article>
```

## Reference URLs

- Financial Times — https://www.ft.com/markets (study color, typography, density)
- Bloomberg.com — https://www.bloomberg.com/markets (cleaner, slightly more modern than print)
- WSJ — https://www.wsj.com/news/markets (red accent, news-first treatment)
- Reuters — https://www.reuters.com/markets/ (utilitarian editorial)
- The Economist — https://www.economist.com/finance-and-economics (sparser, illustration-heavy)
- Stratechery — https://stratechery.com (web-native editorial reference)

## Verification (Editorial specific)

- [ ] Background is cream/beige in light mode, warm-near-black in dark
- [ ] Headlines use a display serif font
- [ ] Body uses sans or serif body font with 1.55+ leading
- [ ] **Data tables use mono font** (this is the persona's distinguishing rule)
- [ ] Numbers still have `tabular-nums`
- [ ] Radius is 0-4px throughout
- [ ] Section labels are accent-colored, ALL CAPS, sans, 11px
- [ ] Bylines and timestamps present on article-style content
- [ ] No drop shadows on any UI surface
- [ ] Article max-width is 680-720px for readable measure
- [ ] Light + dark themes both render
