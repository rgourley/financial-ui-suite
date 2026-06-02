# retail-polish-light (stub)

**Reference products:** Wise, Revolut, Cash App, Klarna, N26, Monzo, Chime.

**One-line:** white or near-white background, full brand palette, friendly typography, generous whitespace, mobile-style cards on web. Mobile-first feel, light-native.

## Distinguishing characteristics

- **Surfaces:** white `255 255 255` or near-white `250 250 250`. Cards on slightly tinted backgrounds.
- **Accent:** full brand palette — Wise green `0 178 122`, Revolut purple `8 5 65`, Cash App green `0 217 65`, Monzo coral `255 79 119`.
- **Typography:** sans body (Inter, custom display sans like Wise's Inter Display). Friendly, slightly larger weights.
- **Density:** very generous. 48-56px rows. 16-24px card padding.
- **Radius:** 16-24px on cards, 12-16px on inputs, 999px on buttons (pill).
- **Imagery:** illustrations welcome, light photography on hero areas, brand mascots OK (Cash App, Monzo).
- **Card stacking:** vertical stack of cards is the dominant layout, even on desktop. Each card is one concept.

## Distinguishing from retail-polish-dark

- Light-native, not dark-native
- Color is more diverse (full brand palette vs single signal color)
- Illustrations and friendly imagery allowed (Robinhood doesn't use illustrations)
- Even more whitespace generous
- Multi-currency / international focus (Wise, Revolut are international-first)

## When to use

- Consumer fintech with international/multi-currency focus
- Neobanks (challenger banks)
- Mobile-first products with a web companion
- Onboarding-heavy products (where the user is new to finance)

## When NOT to use

- Active traders (use retail-polish-dark or modern-pro-dark)
- Anything dark-first
- B2B/developer products (use api-dashboard)

## Reference URLs

- Wise — https://wise.com (study the home, transfer flow, currency cards)
- Revolut — https://www.revolut.com (web companion is light-themed)
- Cash App — https://cash.app (mobile-first but the web mirrors)
- Monzo — https://monzo.com
- N26 — https://n26.com
- Chime — https://www.chime.com
- Klarna — https://www.klarna.com

## Anti-patterns specific

- Don't use mono anywhere visible (kills the friendly feel)
- Don't use small radii (<8px)
- Don't use dense tables (48+ px rows are mandatory)
- Don't use serif (sans only)
- Don't skip illustrations or imagery on hero areas (the persona expects warmth)
- Don't use a single brand color exclusively — the palette is diverse

## Deep-fill triggers

Promote when:
- Building a consumer fintech with international features
- Need canonical multi-currency card patterns
- Mobile-first product needs a web extension

For now, treat as retail-polish-dark inverted to light + accept brand color diversity + add illustration patterns.
