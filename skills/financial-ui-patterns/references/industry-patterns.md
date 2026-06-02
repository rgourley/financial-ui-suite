# Industry Patterns

Specific patterns from leading financial platforms. Study these when designing equivalent surfaces.

## Bloomberg Terminal

The reference for serious financial UI. Forty years of refinement.

**Signature patterns:**
- All-caps tickers in mono font
- Hairline borders, almost no chrome
- Function-key-driven navigation (everything keyboard accessible)
- Yellow on black for amber CRT aesthetic (the famous "Bloomberg amber"); orange + green for the modern dark theme
- High information density: 20+ data points per screen
- Sparklines inline in tables
- Decimal alignment using fixed-width columns
- Time formatting in 24h, exchange-local timezone
- Hard-coded layouts that traders memorize

**Steal:**
- Mono ticker convention
- Density (40+ row tables are fine)
- Function-key shortcuts in tooltips
- Decimal alignment
- Status info in small dim labels rather than full sentences

**Don't steal:**
- The yellow-on-black palette outside specific use cases
- The exact information density unless your users are pros
- The full-keyboard-driven flow unless you have 1000+ hours of user training

## TradingView

The reference for charting and modern financial web UI.

**Signature patterns:**
- Right-side toolbar for indicator/drawing tools
- Floating "buy/sell" buttons over the chart for paper trading
- Symbol search overlay (cmd+K style)
- Watchlist on the left, chart center, depth/positions right
- Compact density toggle (Comfortable / Normal / Compact)
- Color picker per indicator with full HSL control
- Replay mode for backtesting

**Steal:**
- Density toggle in settings
- Symbol search overlay (cmd+K) as universal navigation
- Floating action buttons over data charts
- Three-pane layout (watchlist | chart | depth)
- Indicator color customization

## Kraken Pro

The reference for crypto exchange UI.

**Signature patterns:**
- Three-column layout: order book, chart, trade form
- Depth bars in order book (cumulative from spread outward)
- Order types collapsible (Market / Limit / Stop / Conditional / OCO)
- Order book heatmap mode (size as background intensity)
- Tabs for Open Orders / Trade History / Positions below the chart
- All numbers in tabular-nums, sans (not mono)
- Light + dark theme

**Steal:**
- Order book depth bar direction (asks fill right→left, bids left→right)
- Spread bar prominent between asks and bids
- Order form below current price prominently
- Order list tabs convention

## Coinbase Pro / Advanced

The reference for accessible crypto pro UI.

**Signature patterns:**
- Two-column layout (chart left, trade form right)
- Tab-based order types
- Order book with side-by-side bids and asks (not stacked)
- Significant-figure pricing for low-value tokens
- Tick-flash on order book and last-traded price
- Recent trades feed below order book
- Wallet balances always visible in trade form

**Steal:**
- Significant-figure pricing (essential for any altcoin support)
- Tick flash on book and last price
- Order book side-by-side layout option (better for wider screens)
- Always-visible balance in trade form

## Robinhood

The reference for retail/consumer finance UI. Polished, simplified, but with specific pro patterns underneath.

**Signature patterns:**
- Single-asset big price + sparkline as the hero
- Slide-up bottom sheet for order entry on mobile
- Confetti for first trade (controversial; pros hate it)
- Green/red palette throughout (single color = brand)
- Number-pad input for share quantity on mobile
- Realtime portfolio total updates with tick flash

**Steal:**
- Hero price treatment for single-asset pages
- Bottom-sheet order entry on mobile
- Realtime total flash

**Don't steal:**
- Confetti / gamification
- Hiding advanced order types
- The single-color signal palette (use semantic tokens instead)

## Binance

The reference for high-density crypto exchange UI.

**Signature patterns:**
- Customizable layout with draggable panels
- Multiple chart timeframes selectable inline
- Sub-account UI for advanced users
- Depth chart visualization (not just book)
- Funding rate, mark price, index price shown side-by-side for derivatives

**Steal:**
- Last / Mark / Index price split for derivatives
- Depth chart as alternative to order book
- Multiple timeframe inline switcher

## Interactive Brokers / TWS

The reference for institutional desktop trading UI.

**Signature patterns:**
- BookTrader (vertical ladder with price column, bids left, asks right)
- One-click trading from the ladder
- Order types: 50+ supported, organized by category
- "Strategy Builder" for multi-leg options
- Risk metrics visible at all times (Buying Power, Margin, Greeks)

**Steal:**
- Always-visible risk/account metrics
- Ladder layout for one-click trading
- Category-organized order type picker

## Massive (Polygon.io) Dashboard

Reference for API-driven financial dashboards (Polygon.io is now known as Massive.com).

**Signature patterns:**
- Clean data tables with right-aligned numbers
- Status pills for API key state, plan tier
- Usage metrics with sparklines per row
- Tab navigation for API sections (Stocks / Options / Crypto / FX)
- API key copy with masked display by default

**Steal:**
- Masked API key with reveal-on-click
- Usage sparklines per row
- Tab navigation for asset class

## Convention Reference Table

| Convention | Used by | Notes |
|---|---|---|
| Mono font for tickers/symbols | Bloomberg, TradingView, IBKR | Pro standard |
| Sans + `tabular-nums` for prices | Bloomberg, TradingView, Robinhood | Mono prices are heavier, reduce density |
| Green = up / Red = down | Universal in US/EU | Reversed in some Asian markets (red = up) |
| Red = up / Green = down (Asia) | Chinese, Japanese, Korean trading apps | Cultural convention; localize if needed |
| Bids stack downward / Asks stack upward | Kraken, Binance, Coinbase, dYdX | Industry standard |
| Asks reversed so best ask near spread | Kraken, Binance | Required for readability |
| Spread shown in basis points | Pro exchanges, FX platforms | Retail: % is OK |
| Compact notation (`1.2B`) | All platforms | For stats, never balances |
| Sig-fig pricing for sub-cent tokens | Coinbase, CoinGecko, DexScreener | Essential for memecoins |
| Status pills for orders | IBKR, Coinbase Pro, Bloomberg | Color + label |
| Live indicator dot | All streaming UIs | Green = live, amber = stale |
| Order book depth bars | Kraken, Binance, Coinbase Pro | Cumulative size, not raw |
| Tick flash on price changes | Robinhood, Coinbase, TradingView | 300-500ms direction-tinted bg |
| Cmd+K symbol search | TradingView, modern web platforms | Universal navigation |
| Density toggle in settings | TradingView, Bloomberg | Pro convention |
| Light + dark themes | All serious platforms | Dark-only signals retail |

## Cultural Notes

US/EU markets:
- Green = up, red = down
- 24h windows for crypto, regular hours for stocks
- Decimal separators: `.` decimal, `,` thousands

Asia markets (CN/JP/KR):
- Red = up, green = down (opposite!)
- Always localize colors for these markets

Some products (Binance, Bybit) let users flip the palette in settings to match local convention. If serving Asian users, expose this toggle.

## Open Source References

Study these codebases for production patterns:

- **Hyperliquid frontend** — modern derivatives DEX UI, open source
- **TradingView lightweight-charts** — official OSS chart library
- **dYdX v4 frontend** — open source perp DEX UI
- **Uniswap interface** — DEX swap UI patterns
- **lichess** — not finance, but reference for streaming UI at scale

## Bookmarks for the Skill

When in doubt about a pattern, check:

- **Massive (Polygon.io) dashboard** — clean API-product reference
- **Kraken Pro** — order book + trade form standard
- **TradingView** — charting and density standard
- **Robinhood** — consumer/retail polish standard
- **Bloomberg Terminal screenshots** — institutional standard
