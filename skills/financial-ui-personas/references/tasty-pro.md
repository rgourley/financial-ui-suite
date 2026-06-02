# tasty-pro (stub)

**Reference products:** TastyTrade (web and desktop platform).

**One-line:** options-trader-optimized pro UI. Black background, distinctive pink-magenta accent, green/red signals. Sans + tabular. Designed for options chains, Greeks readability, and probability-of-profit metrics that other platforms hide.

## Distinguishing characteristics

- **Surfaces:** pure black `0 0 0` or near-black `10 10 10`. Elevated `22 22 24`.
- **Accent:** Tasty pink-magenta `233 25 121` (or similar saturated magenta). Distinctive enough to identify Tasty at a glance.
- **Signals:** brighter than Modern Pro Dark — `var(--positive)` more saturated green, `var(--negative)` slightly orange-red.
- **Typography:** sans body + tabular nums + mono on tickers/strikes. No mono on prices.
- **Density:** 30-36px table rows. Slightly more generous than Modern Pro Dark to accommodate options data density.
- **Radius:** 4-8px. Slightly rounded buttons and cards.

## Options-specific patterns

- **Greeks prominent:** Delta, Gamma, Theta, Vega visible in chains, not hidden behind hover
- **Probability-of-profit (PoP) metric:** always shown alongside option prices when available
- **Strategy-builder cards:** vertical spreads, iron condors, strangles get card treatments
- **IV (implied vol):** visualized as IV rank, not just percentage. Tasty's IVR metric is distinctive.
- **Expected move:** shown on every chain (the expected range of the underlying over expiration window)

## When to use

- Options-focused trading UIs
- Anything where the user thinks in terms of strategies (spreads, condors, butterflies)
- Products targeting active retail options traders
- Education-adjacent trading interfaces

## When NOT to use

- Stock-only or crypto-only products (overkill)
- Beginner retail (use `retail-polish-dark` instead)

## Reference URLs

- TastyTrade — https://tastytrade.com/ (live platform requires account; screenshots and the marketing site capture the aesthetic)
- TastyLive — https://www.tastylive.com/ (their education brand, shares the visual identity)

## Anti-patterns specific

- Don't use sans-only without mono for tickers/strikes (Tasty mono-stamps tickers)
- Don't hide Greeks behind hover (the persona's selling point is visibility)
- Don't use Modern Pro Dark's blue accent (the magenta is the identity)
- Don't ship without IV rank or expected move on chains (table stakes for this persona)

## Deep-fill triggers

Promote this from stub to deep when:
- Building an options-focused product
- Need canonical strategy-builder card patterns
- Specifically replicating Tasty as a competitive reference

For now, follow `modern-pro-dark` and override:
- Accent to magenta
- Add Greeks/IVR/PoP/Expected Move patterns
- Add strategy-builder card components
