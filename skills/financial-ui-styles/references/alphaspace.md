# alphaspace

**Reference products:** Yahoo Finance AlphaSpace (the new Yahoo Gold terminal), TradingView desktop layout (panel arrangement), Bloomberg Terminal (the workspace metaphor — but consumer-accessible instead of institutional).

**One-line:** consumer-accessible multi-panel terminal. Slate-blue dark surfaces with a bright green primary accent. View-driven left sidebar of named, themed dashboards. Mixed panel canvas (chart + overview + news + fundamentals + holdings + watchlist all coexisting). First-class AI agent rail ("ask the dashboard a question, it builds you the view"). Bloomberg's workspace pattern reskinned for serious retail.

**Differs from `yahoo-prosumer`:** that style covers consumer Yahoo Finance — single-ticker quote pages, news, watchlists. `alphaspace` covers Yahoo's premium terminal product — multi-panel dashboards, embedded AI agent, dense ticker tape, custom workspace per theme. Same parent brand, very different layout DNA.

## Token Set

```css
/* DARK (default and primary) */
:root[data-theme="dark"] {
  /* Surfaces — slate-blue cast like yahoo-prosumer, slightly deeper */
  --surface:           10 14 22;
  --surface-elevated:  16 20 30;     /* panel cards */
  --surface-panel:     24 30 44;     /* panel chrome / table header */
  --surface-hover:     34 42 60;
  --surface-rail:      14 18 28;     /* sidebars (views + AI) */

  /* Text */
  --text-primary:    232 237 246;
  --text-secondary:  170 178 195;
  --text-muted:      108 118 138;

  /* Signal */
  --positive:        38 200 122;     /* slightly brighter than yahoo */
  --negative:        239 78 78;
  --warning:         255 184 36;

  /* Brand accent — the AlphaSpace bright green (this is the defining cue) */
  --accent:          82 224 119;
  --accent-soft:     20 60 40;

  /* Secondary accent — info blue for ticker tape & links */
  --info:            29 124 240;

  --border:          255 255 255;    /* used with /alpha */
  --radius-md: 0.375rem;
  --radius-lg: 0.5rem;
}

/* LIGHT — optional, less defining for this style */
:root[data-theme="light"] {
  --surface:           248 250 252;
  --surface-elevated:  255 255 255;
  --surface-panel:     240 244 250;
  --surface-hover:     232 238 246;
  --surface-rail:      244 247 252;
  --text-primary:    18 24 36;
  --text-secondary:  82 95 117;
  --text-muted:      140 152 172;
  --positive:        10 138 79;
  --negative:        200 38 50;
  --accent:          16 140 70;
  --info:            20 101 240;
  --border:          0 0 0;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Brand wordmark | Sans (Inter, Geist) | 18-22px | 700-800 |
| Panel title | Sans uppercase, `tracking-wider` | 10-11px | 700 |
| Panel-title ticker (e.g., `META`) | Sans bold | 11-12px | 700 |
| Hero quote price | Sans + `tabular-nums` | 28-44px | 700 |
| Quote delta | Sans + `tabular-nums` | 14-18px | 600 |
| Ticker tape symbol | Sans | 11-12px | 600 |
| Ticker tape price/delta | Sans + `tabular-nums` | 11-12px | 500-600 |
| Sidebar view label | Sans | 12-13px | 500-600 |
| Section labels (VIEWS, MY VIEWS, etc.) | Sans uppercase, `tracking-wider` | 9-10px | 700 |
| Table cell | Sans + `tabular-nums` | 11-12.5px | 400-500 |
| AI-agent message body | Sans | 12-13px | 400-500 |
| AI-agent suggested-prompt | Sans bold + accent color | 12.5-13px | 600 |
| Code / identifiers | Mono (JetBrains Mono) | 11-12px | 500 |

Mono is sparing — only for genuine identifiers (CUSIPs, contract codes, API IDs). Tickers stay sans-bold for legibility at small sizes in dense panel chrome.

## Density

| Element | Pixel range |
|---|---|
| Top ticker tape row | 32-40px |
| Secondary equities strip (if present) | 26-32px |
| Panel title bar | 28-32px |
| Sidebar view nav item | 28-32px |
| AI rail message line-height | 1.5-1.65 |
| Watchlist row | 28-32px |
| Holdings table row | 32-36px |
| Card padding | 12-16px |
| Section gap (between panels) | 8-12px |
| Page padding | 16-24px |

Denser than `yahoo-prosumer`, similar to `modern-pro-dark`. The whole point is "many panels at once," so individual cells stay tight.

## Visual Rules

- **Panel chrome:** every panel is a self-contained bordered card with a title bar that has `▦` (drag), title text, and controls (`⚙`, `⤢`, `×`). Title bar separated from body by hairline border.
- **Borders:** hairline `border-border/8` between rows, `border-border/12` between panels.
- **Radius:** 8-10px on panel cards, 6px on buttons, 4px on inline tags, 999px (full pill) on tape items + suggested-prompts in AI rail.
- **Shadows:** none on panels. Each panel earns its frame from `surface-elevated` bg + border, not shadow.
- **Hover:** background bump to `surface-hover/40` at 120ms.
- **Active sidebar view:** `bg-surface-hover` + left-border `--accent` 2px.
- **Tape tickers:** entire row scrolls horizontally; deltas use semantic color; no $ on tape (compact).
- **AI rail width:** 240-280px right-rail. Always present, never collapsed.
- **Chart accent color in panels:** `--accent` (green), not `--info` (blue). Single-line mountain charts are green-on-dark.

## Components

### Top ticker tape (signature, two rows)
**Row 1:** EQUITIES toggle + 6-8 major indices/futures (S&P, NASDAQ, DOW, GOLD, OIL, BITCOIN, etc.) with price + colored delta.
**Row 2:** Configurable theme list — for an `EQUITIES` selection, the user's most-active or watchlist tickers stream here.

Both rows are 32-40px tall, hairline-separated. Horizontal scroll. Compact: ticker symbol sans-bold, price tabular, delta semantic-colored with leading `+/−`.

### View sidebar (signature)
Left rail, 120-160px wide. Two stacked sections:
- **VIEWS** — preset thematic dashboards: Banks & Credit, Macro, Crypto, Sector Rotation, Earnings Season, Semiconductors, AI Software, Energy, Gold & Metals, Emerging Markets, Consumer Health, Consumer Staples, E-Commerce, Digital Media.
- **MY VIEWS** — user-cloned and custom dashboards: "Meta Technical", "Premium News", "Meta Analysis", etc. Each is one user-arranged panel set.

Active view: `bg-surface-hover` + 2px accent left border + bolder weight. Icons optional; the label-only Yahoo pattern is the truer reference.

### Panel
Each tile in the canvas is a panel. Structure:
- **Title bar (28-32px):** drag handle ▦, label (e.g., `META OVERVIEW` in uppercase tracked-wider), spacer, controls (`⤢` maximize, `⚙` settings, `×` close)
- **Body:** specific to panel type
- **No footer chrome.** Panels keep themselves quiet so the workspace stays scannable.

Panel-type variants:
| Type | Body |
|---|---|
| Overview | Hero price, OHLC stat list, Mkt Cap |
| Chart | Range toggle + mountain or candle + axis |
| News | Headline cards 2-4 deep, source/timestamp |
| Holdings | Sector-grouped table: ticker, market value, daily P&L %, sparkline |
| Watchlist | Same shape as Holdings but no market value |
| Fundamentals | Wide table: rows = metrics (EV, EV/EBITDA, P/E, EPS, Margin), cols = periods |
| Compare chart | Multi-ticker `%`-normalized lines + colored ticker tabs |

### AI agent rail ("Ask Yahoo Scout"-style) (signature)
Fixed right rail, 240-280px wide. Always visible. Conversational interface with:
- **Avatar/header strip** showing agent name and a "🟢 listening" or similar status dot
- **Conversation transcript** — alternating user prompts (right-aligned pill, accent background) and agent responses (left-aligned, body text with markdown)
- **Suggested actions list** — bold accent text rendered as inline prompts the user can click: `"Build me a dashboard for NVDA"`, `"Add RSI and MACD to the chart"`, `"Compare META vs GOOGL"`, `"Switch the ticker strip to crypto"`
- **Current view explainer** — collapsible "You're in Meta Analysis, which has..." block listing the active panels in this view

The agent is a peer to the panels, not an overlay. It doesn't pop in; it's part of the workspace permanently.

### Suggested-action pill
Used in the AI rail. Bold accent-colored phrase (NOT in a button shape — inline text that looks tappable via underline-on-hover). Each prompt should be specific and verb-led: "Build", "Show", "Compare", "Switch", "Add".

## Anti-Patterns (AlphaSpace specific)

| Don't | Why |
|---|---|
| Collapse the AI rail to a chat bubble icon | The agent is a first-class panel, not a chatbox; pinned visibility is the design statement |
| Drop the view sidebar | The view-driven workflow is the defining UX; without it, this is just `modern-pro-dark` |
| Mix decorative gradients into panel chrome | Panels stay flat slate; gradients only appear under chart lines (≤15% opacity) |
| Use the green accent on prices | Green is for the brand and chart line; price deltas use semantic positive/negative |
| Make panels resizable but not draggable, or vice versa | If a workspace promises customization, all panels need drag + resize + close |
| Use icon-only labels in the view sidebar | Labels are the affordance; Yahoo's reference is label-first with optional small icons |
| Hide the secondary ticker strip | The two-row ticker (broad market + your theme) is part of the dense feel; one row reads as `yahoo-prosumer` |
| Use rounded buttons over 8px | Prosumer-terminal hybrid sits between Modern Pro and Retail Polish; 6-8px radius keeps it pro-leaning |

## Example: AlphaSpace panel title bar + suggested AI prompt

```tsx
{/* Panel title bar */}
<header className="h-8 px-3 flex items-center gap-2 border-b border-border/10 bg-surface-panel">
  <span aria-hidden className="text-text-muted text-[11px] cursor-grab">▦</span>
  <span className="text-[10px] uppercase tracking-wider font-bold text-text-secondary">
    META <span className="text-text-muted">OVERVIEW</span>
  </span>
  <div className="ml-auto flex items-center gap-2 text-text-muted">
    <button aria-label="Settings" className="text-[12px] hover:text-text-primary">⚙</button>
    <button aria-label="Maximize" className="text-[12px] hover:text-text-primary">⤢</button>
    <button aria-label="Close" className="text-[14px] leading-none hover:text-text-primary">×</button>
  </div>
</header>

{/* Suggested AI prompt (in agent rail) */}
<button className="block text-left w-full px-0 py-1 group">
  <span className="font-semibold text-[13px] text-accent group-hover:underline">
    "Build me a dashboard for NVDA"
  </span>
  <span className="block text-[11.5px] text-text-secondary mt-0.5">
    → I'll compose a full view with chart, stats, and news
  </span>
</button>
```

## Reference URLs

- Yahoo Finance AlphaSpace landing — https://finance.yahoo.com/about/promos/gold/alphaspace/
- Yahoo Finance Gold (parent product) — https://finance.yahoo.com/about/promos/gold/
- TradingView desktop — https://www.tradingview.com/desktop/ (panel arrangement reference)
- Bloomberg Terminal — institutional reference for the workspace metaphor

## Verification (AlphaSpace specific)

- [ ] Background is slate-blue near-black (~`10 14 22`), not neutral / not pure
- [ ] Primary accent is bright green (`82 224 119`-ish), not blue — distinguishes from `yahoo-prosumer`
- [ ] Two-row ticker tape present: broad market row + theme row
- [ ] View sidebar present with `VIEWS` + `MY VIEWS` sections, labels not icons
- [ ] Active sidebar view has 2px accent left border
- [ ] Multiple panel types coexist on the canvas (chart + overview + news + holdings)
- [ ] Every panel has a title bar with drag handle ▦ and `⚙ ⤢ ×` controls
- [ ] AI agent rail pinned to right edge (240-280px), always visible, never collapsed
- [ ] AI rail has suggested-prompt list rendered as bold accent inline text (not buttons)
- [ ] Panel title labels are uppercase + `tracking-wider`
- [ ] Tickers in bold sans, not mono
- [ ] Price deltas semantic-colored with leading `+/−`
- [ ] Chart lines use `--accent` green, not `--info` blue
- [ ] No drop shadows on panels — borders + bg elevation only
- [ ] Light theme renders (even though dark is the primary)
