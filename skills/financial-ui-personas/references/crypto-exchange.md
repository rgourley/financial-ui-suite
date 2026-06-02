# crypto-exchange (stub)

**Reference products:** Coinbase Advanced Trade, Binance, Bybit, OKX, KuCoin, Bitstamp Pro.

**One-line:** higher information density than Modern Pro Dark, with brand-accent (Coinbase blue, Binance yellow), more colored cell-level highlighting, and subtle gradients allowed on chart areas.

## Distinguishing characteristics

- **Surfaces:** dark slate `15 17 22` or near-black `12 12 12`. Slightly warmer than Modern Pro Dark.
- **Accent:** brand-driven — Coinbase `0 82 255` (blue), Binance `240 185 11` (yellow), Bybit `247 167 8`, OKX brand-dependent.
- **Cell-level color:** more aggressive than Modern Pro Dark. Order book bids/asks may have stronger background tints, gain/loss cells may have light tint backgrounds.
- **Gradients:** permitted subtly on chart areas, hero banners, and depth visualizations. Modern Pro Dark forbids them; crypto exchanges allow them.
- **Typography:** sans + tabular nums. Mono on tickers, addresses, transaction hashes. Symbols often capitalized.
- **Density:** 28-32px rows. Similar to Modern Pro Dark.

## Crypto-specific patterns

- **Pair display:** `BTC/USDT`, `ETH/USDC` — slash-separated, mono.
- **Significant-figure pricing:** essential for sub-cent tokens (covered in base `financial-ui-patterns`)
- **Depth chart:** alternative to order book — bid/ask volume cumulative curves
- **Funding rate / mark price / index price** for derivatives — show all three for perps and futures
- **Asset icon:** small circular icon next to ticker (32px), uses the project's brand
- **Withdrawal address validation:** chain-specific input with visible warning if address-chain mismatch
- **24h change cells:** often have a tinted background, not just colored text

## When to use

- Centralized crypto exchanges
- Custodial wallets with trading
- Crypto-first products targeting active traders
- Any product where users hold > 5 crypto assets and trade frequently

## When NOT to use

- Stocks-only platforms
- Beginner crypto wallets (use `retail-polish-dark` or `defi-native` instead)
- DEX/onchain products (use `defi-native` instead)

## Reference URLs

- Coinbase Advanced — https://www.coinbase.com/advanced-trade (the new pro UI; cleaner than original Coinbase Pro)
- Binance — https://www.binance.com/en/trade/BTC_USDT (study spot trade view, futures view, depth chart)
- Bybit — https://www.bybit.com/en/trade/spot/BTC/USDT
- OKX — https://www.okx.com/trade-spot/btc-usdt
- KuCoin — https://www.kucoin.com/trade/BTC-USDT

## Anti-patterns specific

- Don't use Modern Pro Dark's minimal aesthetic (crypto users expect more visual energy)
- Don't skip the asset icon next to tickers (industry standard)
- Don't hide funding rate on perps (critical for liquidation awareness)
- Don't use yellow accent for non-Binance-flavored products (it's strongly associated)

## Deep-fill triggers

Promote when:
- Building a centralized exchange or crypto trading product
- Need canonical depth chart, funding rate, mark/index split patterns
- Significant figure formatting needs more detail than base skill covers

For now, follow `modern-pro-dark` and override:
- Brand accent per product
- Allow subtle gradients on chart areas
- More aggressive cell-level tint
- Add crypto-specific components (pair display, asset icons, funding metrics)
