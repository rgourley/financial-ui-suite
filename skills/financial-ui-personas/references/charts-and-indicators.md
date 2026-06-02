# Charts & Indicators by Persona

Each persona has distinct chart conventions. Use the right chart type for the right audience. Base chart correctness is in `financial-ui-patterns/references/charts-and-candles.md` — load it first.

## Quick Matrix

| Persona | Default chart | Indicators | Volume | Layout |
|---|---|---|---|---|
| `modern-pro-dark` | Candlesticks | 2-3 overlays + 1 panel | Yes, 1/3 height | Multi-panel stacking |
| `pro-terminal` | OHLC bars | 4-5 indicators stacked | Yes, in amber | 4-panel grid |
| `editorial-financial` | Line, single color | 0-1 overlay (SMA) | No | Single panel |
| `api-dashboard` | Line / sparkline | None | No | Inline tile |
| `retail-polish-dark` | Smooth area | None default | Optional | Single panel hero |
| `retail-polish-light` | Smooth area, brand fill | None | No | Single panel hero |
| `tasty-pro` | Candlesticks | Greeks overlays, IV rank | Yes | Multi-panel + risk graph |
| `crypto-exchange` | Candlesticks | TradingView indicator set | Yes, amber/yellow | Multi-panel |
| `defi-native` | Smooth line, gradient fill | None | Optional | Single panel |
| `apple-native` | Smooth area filled | None | No | Single panel + period selector |

## Per-Persona Detail

### modern-pro-dark
- **Chart:** TradingView-style candlesticks
- **Candle colors:** `--positive` body for up (hollow OK), `--negative` body for down (filled)
- **Wicks:** match body color
- **Grid:** hairline `--border / 0.08`, only major lines
- **Crosshair:** thin solid line in `--accent`, tooltip in `surface-elevated` with hairline border
- **Indicators:**
  - Overlays: 1-3 moving averages, Bollinger Bands optional
  - Panel indicators (stacked below): Volume + RSI by default; user can add MACD, Stochastic
  - Indicator colors: distinct, NOT from semantic palette (use orange, yellow, purple, cyan)
- **Volume bars:** 1/3 height, colored by candle direction at 70% opacity
- **Period selector:** below chart, mono font, underline-style active
- **Annotations:** small flags for earnings, dividends, splits

### pro-terminal
- **Chart:** OHLC bars (not candles) for maximum density
- **OHLC color:** `--positive` for up bars, `--negative` for down bars
- **Grid:** dotted/dashed amber `rgba(255, 176, 0, 0.15)`
- **Crosshair:** amber, with bracket-style price/time tooltip `[5,847.25 @ 16:00:00]`
- **Indicators:**
  - Always 4-5 indicators stacked: Price + Volume + RSI + MACD + (custom)
  - All indicator colors in amber/cyan/white spectrum (no rainbow palettes)
  - Indicator labels: ALL CAPS mono, e.g. `RSI(14) 58.4`
  - Labels at top of each panel
- **Volume bars:** match candle direction but use amber for "neutral" volume
- **Period selector:** function-key shortcuts visible (1D = F1-1, etc.)
- **Multi-pane:** every chart can be tiled with depth, T&S, news

### editorial-financial
- **Chart:** simple line, single accent color
- **Line color:** `--accent` (FT salmon-red, or similar editorial accent)
- **Line weight:** 1.5-2px
- **Area fill:** optional, very subtle (5-8% opacity below line)
- **Grid:** very minimal, 2-3 horizontal hairlines `--border / 0.1`
- **Indicators:** none by default. If one moving average shown, dashed muted line.
- **Crosshair:** none by default (read, don't analyze)
- **Period selector:** serif numerals, italic for inactive states
- **Annotations:** editorial-style — labeled with serif italic notes pointing to peaks/troughs
- **Volume:** never shown (data-narrative, not technical analysis)

### api-dashboard
- **Chart:** line or area, single color (brand accent)
- **Use cases:** API call rate, latency, error rate, request count over time
- **Sparklines:** common in stat tiles
- **Grid:** hairline, 3-4 horizontal lines
- **Indicators:** none (not technical analysis)
- **Tooltip:** hover shows value + timestamp
- **Time axis:** hour/day granularity, not tick-level
- **Multi-series:** distinct brand-adjacent colors (purple primary, orange/teal secondary for Stripe; blue/green for Massive)

### retail-polish-dark
- **Chart:** smooth filled area chart, single accent color
- **Line color:** `--positive` if period is up, `--negative` if down (Robinhood pattern)
- **Area fill:** matches line at 15-25% opacity gradient (fades to transparent at bottom)
- **Grid:** none or 1 horizontal line at the period's start price (dotted, muted)
- **Indicators:** none default
- **Crosshair:** vertical line + price dot on touch/hover, no horizontal line
- **Period selector:** pill buttons below chart (1D, 1W, 1M, 3M, 1Y, ALL)
- **Annotations:** none default. Open/close markers for after-hours trading shown subtly.

### retail-polish-light
- **Chart:** smooth filled area, brand color gradient fill
- **Line color:** brand color (Wise green, Revolut purple, etc.)
- **Fill:** gradient brand-to-transparent
- **Grid:** essentially none, or 1 dashed midline
- **Indicators:** none
- **Period selector:** pill buttons or segmented control
- **Friendly touches:** emoji or icon markers for major events ("📰 Earnings call")

### tasty-pro
- **Chart:** candlesticks + options-specific overlays
- **Candle colors:** Tasty pink+black palette (pink/magenta for ITM, white for OTM strikes overlaid)
- **Indicators:**
  - IV rank overlay (background tint by IV percentile)
  - Expected move bands (price ± expected move shaded)
  - Greeks overlays (Delta strip below price chart)
- **Risk graph:** P&L curve for active option strategies (vertical spreads, condors)
- **Volume:** yes, with put/call volume split
- **Period selector:** standard pro, plus expiration date selector

### crypto-exchange
- **Chart:** candlesticks (TradingView convention)
- **Candle colors:** semantic positive/negative; some platforms (Binance) allow yellow accent for "no change"
- **Indicators:** TradingView library set — VWAP, BB, RSI, MACD, MA, EMA
- **Volume bars:** vivid color (more saturated than modern-pro-dark)
- **Period selector:** very granular (1m, 5m, 15m, 30m, 1h, 4h, 1d, 1w)
- **Multi-timeframe:** mini timeframe selector embedded
- **Funding rate** overlay for perpetual contracts (yellow strip)
- **Mark price** dashed line distinct from last price

### defi-native
- **Chart:** smooth line with gradient brand fill
- **Line:** saturated brand color (Uniswap pink, Solana purple)
- **Fill:** strong gradient with brand color
- **Grid:** minimal or none
- **Indicators:** rarely — just price chart for swap context
- **Time axis:** 1h / 1d / 1w / 1m typically
- **Glassy effects:** translucent panel for chart container

### apple-native
- **Chart:** smooth filled line (iOS Stocks style)
- **Line color:** iOS green (#34C759) or red (#FF3B30) by period direction
- **Fill:** matches line at 15% opacity gradient
- **Grid:** none — pure clean look
- **Indicators:** none
- **Period selector:** segmented control at bottom (1D 1W 1M 3M 6M YTD 1Y 2Y 5Y 10Y)
- **Crosshair:** vertical line + price label on touch
- **After-hours:** dashed continuation if applicable, marked clearly

## Indicator Color Conventions

When showing multiple indicators, use a distinct palette that doesn't conflict with positive/negative:

| Indicator | Color (modern-pro-dark) | Color (pro-terminal) |
|---|---|---|
| SMA 20 | Cyan `rgb(0, 195, 255)` | Cyan `rgb(0, 195, 255)` |
| EMA 50 | Orange `rgb(255, 165, 0)` | Amber `rgb(255, 176, 0)` |
| SMA 200 | Purple `rgb(168, 85, 247)` | White |
| BB upper/lower | Yellow `rgb(255, 220, 0)` semi-transparent | Cyan dashed |
| VWAP | Magenta `rgb(225, 80, 200)` | Cyan |
| RSI line | Yellow / amber | Amber |
| MACD line | Cyan | Cyan |
| MACD signal | Orange | Amber |
| MACD histogram | Positive/negative tinted | Positive/negative tinted |

Never use semantic positive/negative for indicators themselves — those colors mean "price went up/down," not "indicator value." Reserved for candle bodies and delta cells only.

## Anti-Patterns

| Anti-pattern | Why bad |
|---|---|
| Bézier-smoothed line on tick data | Misrepresents actual prices |
| Rainbow palette for indicators | Hard to scan, doesn't scale |
| Volume same height as price | Wrong hierarchy |
| Candles in retail-polish personas | Reads as too technical |
| Line chart for active trader pro UI | Loses OHLC information |
| No timezone on time axis | Global users confused |
| Animated indicator updates | Trader fatigue |
| Multiple Y-axes without color coding | Cognitive overload |
| Indicators in semantic colors | Conflates signal with data |

## When to Use Which Chart Type

- **Single asset / portfolio overview:** line or area
- **Active trading decisions:** candlesticks (modern) or OHLC bars (pro terminal)
- **Long-term holdings retail view:** smooth area, single color
- **Article / editorial:** line, one color
- **API metrics / system dashboards:** line or sparkline
- **Options strategies:** candles + risk graph
- **DeFi swap pages:** smooth line for context only
- **Mobile compact:** sparkline or smooth area
