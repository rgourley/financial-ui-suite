# research-terminal

**Reference products:** AlphaSense, Visible Alpha, FactSet Research Workstation (web), Sentieo (acquired by AlphaSense), Tegus, Stream by AlphaSense, Bloomberg Intelligence (the research panel, not the terminal).

**One-line:** light, document-first institutional research aesthetic. Near-white surfaces, single saturated blue accent, sans throughout, yellow keyword highlights inside excerpt cards, source-type pills, sentiment scoring, and a generative-AI summary block as a first-class component. Built for buy-side analysts who scan documents and transcripts, not charts.

## Token Set

```css
/* LIGHT (default for research products) */
:root[data-theme="light"] {
  /* Surfaces — clean off-white, not flat #FFF */
  --surface:           252 252 253;     /* page bg */
  --surface-elevated:  255 255 255;     /* result cards, document viewer */
  --surface-panel:     245 247 250;     /* sidebar, filter rails */
  --surface-hover:     237 240 245;     /* row + tab hover */

  /* Text */
  --text-primary:    21 26 38;
  --text-secondary:  88 100 122;
  --text-muted:     145 155 175;

  /* Signal — sentiment, not price */
  --positive:  10 138 79;               /* bullish / hawkish sentiment */
  --negative: 200 38 50;                /* bearish / dovish sentiment */
  --warning:  201 138 16;
  --info:      20 101 240;

  /* Brand accent — institutional deep blue */
  --accent:     8 60 140;               /* AlphaSense-ish deep navy-blue */

  /* Highlight — signature yellow for keyword matches inside excerpts */
  --highlight:       255 232 130;
  --highlight-strong: 255 213 64;

  /* Source-type pill backgrounds (semantic, by document class) */
  --source-filing:      230 240 252;    /* 10-K, 10-Q, 8-K */
  --source-transcript:  236 246 240;    /* earnings call, expert call */
  --source-news:        248 240 235;    /* press release, news wire */
  --source-broker:      245 238 252;    /* sell-side note */

  --border:    0 0 0;                   /* used with /alpha */
  --radius-md: 0.375rem;                /* 6px */
  --radius-lg: 0.5rem;                  /* 8px */
}

/* DARK — optional, less common for this style */
:root[data-theme="dark"] {
  --surface:           18 22 32;
  --surface-elevated:  24 30 44;
  --surface-panel:     32 40 58;
  --surface-hover:     42 52 72;
  --text-primary:    232 237 246;
  --text-secondary:  170 180 198;
  --text-muted:     115 125 145;
  --positive:  29 191 113;
  --negative: 239 78 78;
  --accent:    78 144 255;
  --highlight: 200 165 50;
  --highlight-strong: 230 195 70;
  --border:    255 255 255;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Page title | Sans (Inter, Aktiv Grotesk) | 22-28px | 600 |
| Section / company name | Sans | 16-18px | 600 |
| Result card headline | Sans | 14-15px | 600 |
| Excerpt body (highlighted) | Sans | 13-14px | 400 |
| Body | Sans | 13-14px | 400 |
| Filter chip / source pill | Sans | 11-12px | 500 |
| Metadata (company · date · source) | Sans | 11-12px | 400 |
| Numeric: sentiment score, revenue $ | Sans + `tabular-nums` | 13-16px | 500-600 |
| Ticker / CUSIP / contract ID | Mono (JetBrains Mono, GeistMono) | 11-12px | 500 |
| Section labels | Sans uppercase, `tracking-wider` | 10-11px | 600 |
| AI summary heading | Sans | 12-13px | 600 |
| Highlighted match keyword | Sans (inherits) | inherits | 600 (bolded) |

**Mono rule for this style:** narrow. Mono is for tickers, CUSIPs, ISINs, contract identifiers. Document IDs and analyst names use sans. AI summaries are sans (research narrative, not code).

## Density

| Element | Pixel range |
|---|---|
| Search-result excerpt card | 96-128px (header strip + 2-3 lines of highlighted excerpt) |
| Document table row | 44-52px |
| Sidebar nav item | 36-40px |
| Filter chip | 28-32px |
| Source-type pill | 22-26px |
| Card padding | 16-20px |
| Document viewer line-height | 1.55-1.7 |
| Section gap | 24-32px |
| Page padding | 24-40px |

Looser than trading UIs. Analysts read for hours; legibility and scan structure beat data density.

## Visual Rules

- **Borders:** hairline `border-border/8` between sections, `border-border/12` on cards. Document viewer body has no border, just generous padding.
- **Radius:** 6px on cards, 4-6px on inputs, 4px on source-type pills, 999px (full pill) on filter chips and saved-search tabs.
- **Shadows:** allowed and subtle: `0 1px 2px rgba(0,0,0,0.04)` on cards in light mode, slightly more on the active document viewer. Skip in dark mode.
- **Highlights:** keyword matches inside excerpts get `bg-highlight` with normal text color — the signature pattern. Search-term matches in the active document viewer get `bg-highlight-strong` with a thin underline.
- **Hover:** bg shift to `surface-hover` at 100-120ms. Active row gets `bg-accent/10` with no border.
- **Active tab:** 2px solid `--accent` underline OR `bg-accent/15` + `text-accent` pill. Pick one per surface.
- **Focus:** 2px accent ring + 3px low-opacity halo. Keyboard nav is heavy here (analysts use j/k to move through results).

## Components

### Search bar (always-present top of canvas)
Wide, 40-48px tall, prominent at top of every results view. Placeholder: `Search filings, transcripts, news, broker research...`. Cmd+K toggles focus. Past queries surface as a dropdown below. Smart-token chips (`company:META`, `source:transcript`, `sentiment:bearish`) appear inside the field after parsing.

### Source-type pill (signature)
Tiny pill identifying document class. Always paired with the result.

```tsx
<span className="inline-flex items-center h-5 px-1.5 rounded text-[11px] font-medium border bg-source-filing text-[rgb(20_60_140)] border-[rgb(20_60_140)]/15">
  10-K
</span>
```

Standard set: `10-K`, `10-Q`, `8-K`, `Proxy`, `Earnings Call`, `Expert Call`, `Press Release`, `News`, `Broker Note`, `Initiating Coverage`, `Industry Report`.

### Search-result excerpt card (signature)
The unit of work in this style. Structure:

1. Top strip: company logo (24px) + company name + ticker (mono, muted) + source-type pill + date (right-aligned, muted)
2. Headline row: document title (`text-primary`, semibold, 14-15px)
3. Excerpt body: 2-3 lines from the document with keyword matches wrapped in `<mark class="bg-highlight">...</mark>`
4. Bottom strip (optional): sentiment chip, page reference, "view in document" link

Hover: bg shift to `surface-hover`. Click opens the document viewer at the matched location.

### Document viewer
Full-height left pane (60-70% of canvas). Renders the source document (PDF transcript, filing) with active search terms highlighted via `bg-highlight-strong`. Right rail: AI summary, related-document list, sentiment timeline, notes. Top toolbar: page navigation, jump-to-next-match, share, save, export.

### AI summary block (modern signature)
Distinct card at the top of any company page or document view. Pattern: `border-l-2` accent left rail, `bg-surface-elevated`, small uppercase label (`AI SUMMARY · GENERATED MMM D`), 4-6 bullet-point summary, "regenerate" + "show sources" actions at bottom. Citations after each claim link back to the source document.

### Sentiment indicator
Numeric (`+0.42`) or bar (small horizontal bar centered on zero, fills right-positive / left-negative). Always paired with a label (`Bullish` / `Hawkish` / `Neutral` / `Bearish`). Used per-document and aggregated per-company over time.

### Filter chip rail
Above results. Chips toggle filters: source type, date range, sentiment, region, sector, watchlist membership. Active chips get `bg-accent/15` + `text-accent`. Clear-all link at the right end of the rail.

### Watchlist / saved-search sidebar
Left rail, 240-280px. Section headers: `WATCHLISTS`, `SAVED SEARCHES`, `ALERTS`. Each row is a 36-40px clickable label with a small count badge on the right (number of new matches since last visit).

## Anti-Patterns (Research Terminal specific)

| Don't | Why |
|---|---|
| Use a chart-forward layout as the landing page | This style is document-first; charts are secondary panels, not the canvas |
| Drop the keyword highlights in excerpts | Highlighted matches are the entire scan affordance — without them, results read as a wall |
| Use mono for excerpt body | Document text is sans; mono breaks reading rhythm and signals "code" |
| Use bright color saturation in chrome | Surface palette stays restrained; saturation is reserved for the accent and the sentiment signal |
| Treat the AI summary as a generic card | It must visually announce itself: distinct accent rail + `AI SUMMARY` label + citation links |
| Pack tables to trading density (24-28px rows) | Analysts read paragraphs; tables relax to 44-52px |
| Replace source pills with a column of icons | The text label IS the source-type identity; icons alone fail scan |
| Use red/green for non-sentiment numbers | Color = sentiment signal here, not price delta; revenue figures stay `text-primary` |
| Hide the search bar inside a menu | Search is always-on, top of canvas, cmd+K |

## Example: research-terminal search-result excerpt card

```tsx
<article className="rounded-md bg-surface-elevated border border-border/10 shadow-[0_1px_2px_rgba(0,0,0,0.04)] hover:bg-surface-hover transition-colors">
  <header className="flex items-center gap-3 px-4 pt-3">
    <img src={logo} alt="" className="size-6 rounded" />
    <div className="flex items-baseline gap-2 min-w-0">
      <span className="text-sm font-semibold text-text-primary truncate">NVIDIA Corporation</span>
      <span className="font-mono text-xs text-text-muted">NVDA</span>
    </div>
    <span className="ml-auto inline-flex items-center h-5 px-1.5 rounded text-[11px] font-medium border bg-source-transcript text-[rgb(20_100_60)] border-[rgb(20_100_60)]/20">
      Earnings Call
    </span>
    <time className="text-[11px] text-text-muted shrink-0">May 22, 2026</time>
  </header>

  <div className="px-4 py-2">
    <h3 className="text-sm font-semibold text-text-primary mb-1.5">
      Q1 FY27 Earnings Call — Prepared Remarks
    </h3>
    <p className="text-sm text-text-secondary leading-relaxed">
      &ldquo;We saw <mark className="bg-highlight text-text-primary font-semibold rounded-sm px-0.5">data center revenue</mark> grow to a record $39.1 billion, up 73% year-over-year, driven by accelerating demand for our <mark className="bg-highlight text-text-primary font-semibold rounded-sm px-0.5">Blackwell</mark> platform across hyperscale customers...&rdquo;
    </p>
  </div>

  <footer className="flex items-center gap-3 px-4 pb-3 pt-1">
    <span className="inline-flex items-center gap-1 text-[11px] text-positive font-medium">
      <span aria-hidden className="size-1.5 rounded-full bg-current" />
      Bullish · +0.68
    </span>
    <span className="text-[11px] text-text-muted">p. 4 of 28</span>
    <button className="ml-auto text-[11px] text-accent hover:underline">View in document →</button>
  </footer>
</article>
```

## Reference URLs

- AlphaSense — https://www.alpha-sense.com (study search results, document viewer, AI summary)
- Visible Alpha — https://visiblealpha.com (consensus estimates + research views)
- Tegus by AlphaSense — https://www.tegus.com (expert call transcripts UI)
- FactSet Workstation — https://www.factset.com (institutional research UX, older but defining)
- Bloomberg Intelligence — https://www.bloomberg.com/professional/products/bloomberg-intelligence/ (research panel pattern)
- Sentieo — https://sentieo.com (now AlphaSense, archived UI patterns)

## Verification (Research Terminal specific)

- [ ] Default theme is light; dark is optional / secondary
- [ ] Search bar is always-on at top of canvas, cmd+K focuses it
- [ ] Source-type pills present on every result (10-K, Earnings Call, etc.)
- [ ] Keyword matches inside excerpts use `bg-highlight` (yellow)
- [ ] Active document viewer matches use stronger `bg-highlight-strong`
- [ ] AI summary block has distinct accent left rail + `AI SUMMARY` label + citation links
- [ ] Sentiment is presented as numeric + label (`Bullish · +0.42`), not color-only
- [ ] Excerpt body is sans, NOT mono
- [ ] Mono reserved for tickers, CUSIPs, ISINs only
- [ ] Watchlist + saved-search sidebar present on left rail
- [ ] Filter chips above results, `accent/15` background when active
- [ ] Table rows are 44-52px, NOT trading density
- [ ] Page padding generous (24-40px), analyst reading comfort
- [ ] Section labels uppercase + tracking-wider
- [ ] No red/green on non-sentiment numbers
