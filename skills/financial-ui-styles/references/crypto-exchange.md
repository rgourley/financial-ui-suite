# crypto-exchange

**Reference products:** Coinbase Advanced Trade, Binance, Bybit, OKX, KuCoin, Bitstamp Pro, Gate.io.

**One-line:** higher information density than Modern Pro Dark, with brand-driven accent (Coinbase blue, Binance yellow), more aggressive cell-level color saturation, subtle gradients allowed on chart areas, and crypto-specific patterns (pair display, asset icons, funding rates, mark/index price split).

## Token Set

```css
:root[data-theme="dark"] {
  --surface:           15 17 22;        /* warmer than Modern Pro Dark slate */
  --surface-elevated:  22 25 32;
  --surface-panel:     30 33 41;
  --surface-hover:     40 44 54;

  --text-primary:   245 246 248;
  --text-secondary: 178 188 198;
  --text-muted:     124 134 148;

  /* Brand-driven accent — pick one per product */
  --accent: 0 82 255;                   /* Coinbase blue */
  /* Alternatives:
     --accent: 240 185 11;                Binance yellow
     --accent: 247 167 8;                 Bybit orange-amber
     --accent: 0 178 191;                 OKX teal
  */
  --accent-soft: 0 82 255 / 0.15;

  --positive: 0 200 130;
  --positive-soft: 0 200 130 / 0.15;
  --negative: 244 70 86;
  --negative-soft: 244 70 86 / 0.15;
  --warning: 240 185 11;

  --border: 255 255 255;
  --radius-md: 0.375rem;
  --radius-lg: 0.5rem;
}

:root[data-theme="light"] {
  --surface:           250 251 253;
  --surface-elevated:  244 246 250;
  --surface-panel:     236 240 246;
  --text-primary:      18 22 30;
  --text-secondary:    90 100 116;
  --text-muted:        140 150 165;
  --positive: 0 160 100;
  --negative: 220 50 60;
  --accent: 0 82 255;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Hero price | Sans (Inter) + `tabular-nums` | 28-36px | 700 |
| Card title | Sans | 14-16px | 600 |
| Body | Sans | 13-14px | 400-500 |
| Table cell | Sans + `tabular-nums` | 12-13px | 500 |
| Pair display | Mono `BTC/USDT` | 14-16px | 700 |
| Asset symbol | Mono | 11-13px | 600 |
| Address / TX hash | Mono | 11-12px | 400 |
| Section label | Sans UPPERCASE, `tracking-wider` | 10-11px | 500 |

Mono used for pairs, symbols, addresses, transaction hashes — NOT for prices (prices stay sans + tabular).

## Density

| Element | Pixel range |
|---|---|
| Trade table row | 28-32px |
| Order book row | 24-28px |
| Asset list row | 36-44px |
| Card padding | 14-20px |
| Cell horizontal padding | 8-10px |

Similar to Modern Pro Dark but with slightly more vertical padding on asset cells to accommodate the asset icon.

## Visual Rules

- **Borders:** hairline `border-border/8`; status pills get colored borders
- **Radius:** 6-8px on cards, 6px on buttons, 4px on inline tags
- **Shadows:** none on UI
- **Gradients:** **allowed** on chart fills (subtle, <15% opacity), depth visualizations, asset-icon backgrounds. Modern Pro Dark forbids them; crypto exchange permits.
- **Hover:** bg change to `surface-hover/40`
- **Cell-level color:** more aggressive than Modern Pro Dark. Gain/loss cells get tinted backgrounds (`bg-positive/10` etc.), not just colored text.

## Style-Specific Patterns

### Pair display
- Format: `BTC/USDT`, `ETH/USDC` — slash-separated
- Mono font, bold
- Asset icon on left (32px circle, brand color)
- Pair direction matters: BASE/QUOTE convention

### Asset class tabs
- Spot · Margin · Futures · Options · Earn
- Underline-style active state in brand accent
- Show across the top of trading view

### Last / Mark / Index price (derivatives)
- Critical for liquidation awareness
- All three shown simultaneously
- **Last:** actual most-recent trade price
- **Mark:** synthetic fair value used for liquidation
- **Index:** spot index value (basis = mark - index)
- Funding rate shown next to mark (perpetuals)

### Funding rate
- Shown as percentage with countdown to next funding
- Format: `+0.0142% in 04:23:18`
- Color: yellow/amber if neutral, green if positive longs, red if negative longs
- Critical for perpetual contract UIs

### Depth chart
- Alternative to order book
- Cumulative bid + ask volume curves
- Bids fill from left, asks fill from right, meet at spread
- Subtle gradient fills under curves

### Significant-figure pricing
- Essential for sub-cent tokens
- $0.00001234 readable, $0.00 broken
- See `financial-ui-patterns/references/number-formatting.md`

### Withdrawal address validation
- Chain-specific input (ETH address ≠ BTC address)
- Visible warning if chain/address mismatch
- Mono input field with character counter

### 24h change cells
- Background tint per direction: `bg-positive/10` for gains, `bg-negative/10` for losses
- Text colored to match
- More aggressive coloring than Modern Pro Dark (which keeps cells transparent)

## Anti-Patterns (Crypto Exchange specific)

| Don't | Why |
|---|---|
| Use Modern Pro Dark's minimal aesthetic | Crypto users expect more visual energy |
| Skip the asset icon next to tickers | Industry standard; readability anchor |
| Hide funding rate on perpetuals | Critical for liquidation awareness |
| Use yellow accent for non-Binance products | Strongly associated with Binance |
| Ship without Last/Mark/Index split on derivatives | Industry standard for futures/perps |
| Use 8-decimal display for stablecoins | USDC always shows 2dp |
| Forget the chain switcher | Multi-chain is standard now |
| Use mono for prices | Mono is for pairs/symbols/addresses, not magnitudes |

## Example: pair header

```tsx
<div className="px-4 py-3 border-b border-border/8 flex items-center gap-6">
  <div className="flex items-center gap-3">
    <div className="size-8 rounded-full bg-gradient-to-br from-[#F7931A] to-[#E8870E] flex items-center justify-center text-white text-xs font-bold">
      BTC
    </div>
    <div>
      <div className="font-mono text-base font-bold text-text-primary">BTC/USDT</div>
      <div className="text-[11px] text-text-muted">Bitcoin · Spot</div>
    </div>
  </div>

  <div className="flex gap-1">
    {["Spot", "Margin", "Futures", "Options"].map((t) => (
      <button key={t} className={`px-3 py-1.5 text-xs font-medium rounded-md ${t === "Spot" ? "bg-surface-panel text-text-primary" : "text-text-muted hover:text-text-secondary"}`}>
        {t}
      </button>
    ))}
  </div>

  <div className="flex gap-8 ml-auto items-baseline">
    <div>
      <div className="text-2xl font-bold tabular-nums">$67,432.18</div>
      <div className="text-xs tabular-nums text-positive">▲ +1.42% ($945)</div>
    </div>
    <div>
      <div className="text-[10px] uppercase tracking-wider text-text-muted">Mark price</div>
      <div className="text-sm tabular-nums">$67,432.50</div>
    </div>
    <div>
      <div className="text-[10px] uppercase tracking-wider text-text-muted">Index</div>
      <div className="text-sm tabular-nums">$67,431.20</div>
    </div>
    <div>
      <div className="text-[10px] uppercase tracking-wider text-text-muted">Funding</div>
      <div className="text-sm tabular-nums text-warning">+0.0142% · 04:23</div>
    </div>
  </div>
</div>
```

## Reference URLs

- Coinbase Advanced Trade — https://www.coinbase.com/advanced-trade/spot/BTC-USD
- Binance Spot — https://www.binance.com/en/trade/BTC_USDT
- Binance Futures — https://www.binance.com/en/futures/BTCUSDT
- Bybit — https://www.bybit.com/en/trade/spot/BTC/USDT
- OKX — https://www.okx.com/trade-spot/btc-usdt
- KuCoin — https://www.kucoin.com/trade/BTC-USDT
- Gate.io — https://www.gate.io/trade/BTC_USDT

## Verification (Crypto Exchange specific)

- [ ] Background is dark slate (#0F1116) or near-black, slightly warmer than Modern Pro Dark
- [ ] Brand-driven accent (Coinbase blue, Binance yellow, etc.) used consistently
- [ ] Pair display in mono with `BASE/QUOTE` format
- [ ] Asset icon (32px circle) next to ticker
- [ ] Asset class tabs (Spot/Margin/Futures/Options) at top of trading view
- [ ] Last / Mark / Index price all shown for derivatives
- [ ] Funding rate visible with countdown for perpetuals
- [ ] Significant-figure pricing handles sub-cent tokens correctly
- [ ] Cell-level background tints for gain/loss (more saturated than Modern Pro)
- [ ] Subtle gradients permitted on chart fills and depth visualizations
- [ ] Mono for pairs/symbols/addresses, sans for prices
- [ ] Withdrawal flow validates chain/address match
