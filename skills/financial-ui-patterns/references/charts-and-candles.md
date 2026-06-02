# Charts & Candles

Base correctness rules for any financial chart. Persona-specific aesthetic choices live in `financial-ui-personas/references/charts-and-indicators.md`.

## Chart Type Conventions

| Type | When to use | Persona-typical |
|---|---|---|
| **Line** | Single-series trend (portfolio, single price over time) | Retail, editorial, API dashboard, sparklines |
| **Area** | Same as line but with fill below for retail polish | Retail dark/light, Apple native |
| **Candlestick** | Technical analysis, OHLC visibility | Modern pro dark, crypto exchange, tasty pro |
| **OHLC bars** | Pure technical, max density (no body fills) | Pro terminal, institutional |
| **Heikin-Ashi** | Smoothed trend detection | Optional indicator overlay, not default |
| **Renko** / **Point & Figure** | Price-only, ignore time | Niche; advanced trader UIs only |
| **Volume bars** | Always paired below price chart | Most pro and crypto personas |
| **Depth chart** | Order book aggregated view | Crypto exchange, modern pro dark |

## Candlestick Correctness

US/EU convention:
- **Up candle (close > open):** green or hollow green, bullish
- **Down candle (close < open):** red or solid red, bearish
- **Doji (close == open):** horizontal line, neutral
- **Wick (high to low):** thin vertical line through body, matches body color

Asian convention (China, Japan, Korea):
- Red = up, Green = down
- Localize when serving Asian users

OHLC bar (alternative to candles):
- Vertical line from low to high
- Left notch = open
- Right notch = close
- No body fill
- Pure technical, denser than candles

```
Candle              OHLC bar
  │ high              │ high
  ┃                   │
  ┃ close              ┤ close
  ┃                   │
  ┃ open              ├ open
  │ low                │ low
```

## Axis Conventions

**Y-axis (price):**
- Right side by default (industry standard)
- Crosshair shows price at hover
- Major gridlines at round numbers
- 4-6 grid lines max for readability

**X-axis (time):**
- Bottom
- Major ticks at: hour boundaries (intraday), day boundaries (daily), month boundaries (longer term)
- Show timezone explicitly for global instruments
- Compress weekends/non-trading hours (standard pro convention)

**Period selector position:**
- Top-right or below chart
- Standard ranges: 1D, 5D, 1M, 3M, 6M, YTD, 1Y, 5Y, MAX

## Volume Bars

Always paired with price chart, never standalone (except dedicated volume profile).
- Height: 1/3 of price chart by default
- Same x-axis as price chart
- Bar color matches the candle direction: green if close > open, red otherwise
- Average volume line overlay (semi-transparent)

```
Price chart      ┌────────────────────┐
                 │      candles       │
                 │                    │
                 └────────────────────┘
Volume chart     ┌────────────────────┐
                 │  ▌  ▌▌  ▌  ▌▌▌    │
                 └────────────────────┘
```

## Indicator Panel Layout

Pro charts stack panels vertically:

```
┌──────────────────────────┐
│  Price + overlays         │  60%
├──────────────────────────┤
│  Volume                   │  15%
├──────────────────────────┤
│  RSI (0-100)              │  12%
├──────────────────────────┤
│  MACD                     │  13%
└──────────────────────────┘
```

## Indicator Types

### Price overlays (drawn on price chart)
- **Moving averages** (SMA, EMA): single color line per MA. Often SMA20 + EMA50 + SMA200
- **Bollinger Bands**: upper / middle / lower lines + semi-transparent fill between
- **VWAP**: single line, usually purple/orange
- **Pivot Points**: horizontal levels with labels P / R1 / R2 / S1 / S2
- **Ichimoku Cloud**: 5 lines + cloud fill, very complex
- **Support/Resistance**: manual horizontal lines, dashed
- **Fibonacci retracements**: 38.2% / 50% / 61.8% horizontal levels

### Separate panel indicators
- **RSI**: 0-100 scale, line, with 30/70 horizontal lines and shaded zones
- **MACD**: signal line + histogram bars
- **Stochastic**: %K and %D lines, 20/80 thresholds
- **ATR**: single line in separate panel
- **OBV**: cumulative volume line
- **Money Flow Index**: 0-100 line like RSI

### Visual rules across all indicators
- Each indicator has a distinct color, not pulled from semantic positive/negative palette
- Labels shown in small text at top-left of each panel: `RSI(14) 58.4`
- Hover tooltip shows current values across all indicators

## Tick Convention

For streaming price updates on chart:
- Last candle/bar is incomplete, redraws on each tick
- Use distinct visual treatment for incomplete candle (slightly transparent, dashed border)
- "Real-time" badge or pulsing dot indicates live updates

## Common Mistakes

| Mistake | Why bad | Fix |
|---|---|---|
| Same color for up and down candles | Direction unreadable | Use semantic positive/negative |
| Hollow up + hollow down | Direction unreadable | One must be filled (down = filled by convention) |
| Volume bars in same color as price | Cluttered | Match volume color to candle direction |
| No timezone on x-axis | Global instrument ambiguous | Show timezone (ET, UTC) |
| Indicator colors from the semantic palette | Confuses signal/decoration | Indicators use their own palette |
| RSI without 30/70 lines | Misses overbought/oversold context | Always show threshold zones |
| Smoothing line charts with Bézier curves | Misrepresents data points | Use straight lines between data points |
| Volume bars same height as price | Wrong hierarchy | Volume is secondary; ~1/3 height |
| Logarithmic scale by default | Beginners get confused | Linear by default; offer log toggle |

## Accessibility

- Color-blind safe: never rely on red/green alone. Show open/close with body shape or icons
- Crosshair tooltip is always readable (high contrast)
- Indicator legend at top of each panel with current value
- Don't animate chart updates aggressively (motion sickness for traders watching for hours)

## Performance

- For 1000+ data points, downsample using LTTB (Largest Triangle Three Buckets) algorithm
- For 10,000+ tick-level data, use Canvas instead of SVG
- For 100,000+ historical bars, use WebGL via TradingView Lightweight Charts or similar
- Only redraw the last incomplete candle on each tick, not the full chart

## Libraries

| Library | Use case | Notes |
|---|---|---|
| **TradingView Lightweight Charts** | Production financial charts | Open source, fast, used by major exchanges |
| **D3.js** | Custom / unique visualizations | More work but unlimited flexibility |
| **Recharts** | Simple line/area charts | Good for retail or dashboards, not pro |
| **uPlot** | Ultra-fast time series | Best when you need 100k+ points and minimal features |
| **TradingView Charting Library** | Full TradingView feature set | Commercial license required |
| **Apex Charts** | General-purpose | OK for dashboards, weak for trading |

For real-time price charts with candles, OHLC, and overlays: **TradingView Lightweight Charts** is the right default.
