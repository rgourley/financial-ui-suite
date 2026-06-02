# defi-native (stub)

**Reference products:** Uniswap, Jupiter (Solana), Aave, Curve, Raydium, Phantom Wallet, Rabby, Rainbow Wallet, GMX.

**One-line:** gradients permitted, glassy panels with backdrop-blur, saturated brand palette, playful and product-led rather than institutional. Often light or hybrid theme.

## Distinguishing characteristics

- **Surfaces:** highly variable. Often radial gradients on page background (`bg-[radial-gradient(...)]`), glassy panels with `backdrop-blur-xl` + low-opacity background.
- **Accent:** saturated brand colors — Uniswap pink `255 0 122`, Solana ecosystem purple+teal gradient, Aave purple `184 109 247`, Phantom purple `171 132 255`.
- **Typography:** sans (Inter, IBM Plex Sans, custom). Mono for wallet addresses, tx hashes, contract addresses.
- **Density:** moderate. 36-44px rows. Less dense than crypto-exchange because DeFi is often single-action focused (swap, lend, borrow) not chain-watching.
- **Radius:** 12-24px on cards, often pill (999px) on swap inputs.
- **Glass effects:** translucent panels (`bg-white/5`, `backdrop-blur-md`) are persona-standard.

## DeFi-specific patterns

- **Connect Wallet button:** prominent, always top-right. Pre-connect = limited UI.
- **Token swap card:** two-input format with reverse-arrow button between, common pattern (Uniswap-style)
- **Gas estimator:** show estimated gas cost in USD on every transaction
- **Slippage tolerance:** expose as setting
- **Wallet address truncation:** `0x1234...abcd` mono, with copy button
- **Chain switcher:** explicit network indicator (Ethereum / Solana / Base / Arbitrum)
- **APY/APR display:** prominent on lending/staking products
- **TVL (total value locked):** persona convention to show on protocol pages

## When to use

- DEX/AMM/swap products
- Lending and borrowing protocols
- Yield aggregators
- Wallet apps for crypto
- Anything onchain-first where the user is a self-custodial crypto user

## When NOT to use

- Custodial exchanges (use crypto-exchange)
- Traditional finance products that happen to add crypto
- Institutional crypto custody (use modern-pro-dark)

## Reference URLs

- Uniswap — https://app.uniswap.org (canonical swap interface)
- Jupiter — https://jup.ag (Solana DEX aggregator with iconic UI)
- Aave — https://app.aave.com (lending protocol)
- Curve — https://curve.fi
- Phantom Wallet — https://phantom.com
- Rabby Wallet — https://rabby.io
- Rainbow Wallet — https://rainbow.me
- GMX — https://app.gmx.io (perp DEX with strong identity)

## Anti-patterns specific

- Don't make it institutional-feeling (the persona's identity is playful)
- Don't use solid opaque cards everywhere (glass effects are part of the look)
- Don't hide gas costs (must be visible pre-transaction)
- Don't hide chain/network (users need to know which chain they're on)
- Don't use serif (DeFi is digital-native, not editorial)
- Don't ship without wallet connect button prominent

## Deep-fill triggers

Promote when:
- Building a swap/DEX product (Wallhunt might?)
- Building a wallet app
- Need canonical swap card, gas estimator, slippage patterns

For now, base on `crypto-exchange` and override:
- Add gradients and glass effects
- Saturate accent colors
- Add DeFi-specific components (swap card, gas, slippage, chain switcher, address display)
- Reduce density (DeFi is single-action focused)
