# retail-polish-light

**Reference products:** Wise (formerly TransferWise), Revolut, Cash App, Klarna, N26, Monzo, Chime, Stake.

**One-line:** white or near-white background, full brand palette, friendly typography, very generous whitespace, large radii. Mobile-first card-stack feel translated to web. Light-native consumer fintech.

## Token Set

```css
:root[data-theme="light"] {
  --surface:           255 255 255;
  --surface-elevated:  248 249 250;
  --surface-panel:     241 243 245;
  --surface-hover:     232 236 240;

  --text-primary:   20 24 30;
  --text-secondary: 85 95 110;
  --text-muted:     140 150 165;

  /* Brand color — Wise green default, swap per product */
  --brand:        0 178 122;
  --brand-soft:   0 178 122 / 0.10;
  --brand-strong: 0 152 100;
  /* Alternatives:
     --brand: 8 5 65;                     Revolut purple
     --brand: 0 217 65;                   Cash App green
     --brand: 255 79 119;                 Monzo coral
  */

  --accent: 0 178 122;
  --positive: 0 178 122;
  --negative: 220 50 70;
  --warning:  255 178 30;

  --border: 0 0 0;
  --radius-md: 1rem;                    /* 16px — large, friendly */
  --radius-lg: 1.5rem;                  /* 24px */
  --radius-pill: 999px;
}

:root[data-theme="dark"] {
  --surface:           18 18 20;
  --surface-elevated:  28 28 32;
  --surface-panel:     40 40 46;
  --text-primary:      245 246 248;
  --text-secondary:    180 188 198;
  --text-muted:        128 138 152;
  --brand:        0 196 134;
  --positive: 0 196 134;
  --negative: 240 70 90;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Hero display (balance, conversion total) | Sans (Inter, custom display sans) | 32-48px | 700 |
| H1 page title | Sans | 22-28px | 700 |
| H2 section | Sans | 16-18px | 600 |
| Body | Sans | 14-16px | 400-500 |
| Card title | Sans | 15-17px | 600 |
| Form field label | Sans | 13-14px | 500 |
| Numbers (balance, amount) | Sans + `tabular-nums` | matches context | 600-700 |
| Tickers (rare in this style) | Sans bold (NOT mono) | 14-15px | 700 |

Mono is **avoided** in this style — it reads as "developer tool" or "trading screen" and breaks the friendly consumer aesthetic.

## Density

| Element | Pixel range |
|---|---|
| Card row | 56-72px |
| Table row | 48-56px |
| Card padding | 20-28px |
| Section gap | 24-32px |
| Page padding | 16-24px (mobile-first) |
| Form field height | 48-56px |
| Tap target minimum | 48px |

The **most generous density of any style.** International consumer fintech ships with massive whitespace because users span all literacy levels and big targets reduce error.

## Visual Rules

- **Borders:** mostly absent. Cards float on elevation/background contrast.
- **Radius:** 16-24px on cards, 12-16px on inputs, 999px (pill) on buttons and tags
- **Shadows:** soft subtle shadows `0 1px 3px rgba(0,0,0,0.06)` on elevated cards
- **Gradients:** OK on hero areas (brand color gradient as decoration)
- **Hover:** subtle bg change + slight scale (0.99) for tactile feel
- **Active:** scale (0.97) on tap, brief pulse
- **Imagery:** illustrations welcome (hero illustrations, flag icons for currencies, mascots)
- **Icons:** rounded, friendly, brand-colored

## Style-Specific Patterns

### Hero balance card
- Large display number (32-48px sans bold)
- Currency switcher pill button next to amount
- Action buttons row below (Send, Receive, Convert, Add money)
- Subtle brand gradient background or solid white

### Card stack layout
- Vertical stack of self-contained cards
- Each card is one concept (account, transaction, alert)
- 16-24px card-to-card gap
- 20-28px padding inside each card
- Even on desktop, mimics mobile-app card stack

### Multi-currency display
- Flag icon + currency code (mono is fine HERE only, for currency code)
- Conversion preview: `1 USD = 0.85 EUR`
- Live rate ticker that updates without flash (smooth)

### Pill buttons (everywhere)
- 40-48px tall
- 999px radius (full pill)
- Primary: brand bg with white text
- Secondary: muted bg with primary text
- Tertiary: outline only

### Action button row
- Below balance hero
- 3-4 buttons typically (Send / Receive / Convert / More)
- Each button is round 56-64px circle with icon + label below

### Friendly imagery
- Illustrated hero scenes (people sending money, paying friends)
- Flag icons for international support
- Currency-specific iconography
- Mascots OK

### Empty states
- Illustration + reassuring copy
- "Looks like nothing here yet — let's get you started"
- CTA button to take action

### Notifications/alerts
- Pill-shaped at top of screen
- Soft brand color tints
- Emoji prefix OK (✅ ⚠️ 🎉)

## Anti-Patterns (Retail Polish Light specific)

| Don't | Why |
|---|---|
| Use mono on prices or any prominent number | Reads as developer tool, kills friendly feel |
| Use small radii (<8px) | Sharp corners feel cold/institutional |
| Use dense tables (<40px rows) | Style is generous; cramming destroys it |
| Skip illustrations/imagery | Style expects warmth |
| Use serif | Sans-only |
| Use only one brand color | Palette IS the brand — use multiple supportive colors |
| Use dark mode as default | Light-native style |
| Tiny tap targets | Mobile-first means 48px+ |
| Hide the hero number | Big balance display is the signature |

## Example: balance hero

```tsx
<div className="bg-white rounded-3xl p-7 shadow-sm">
  <div className="flex items-center justify-between mb-5">
    <div className="flex items-center gap-3">
      <div className="size-12 rounded-2xl bg-brand-soft flex items-center justify-center text-brand text-xl font-bold">
        🇺🇸
      </div>
      <div>
        <div className="text-sm font-semibold text-text-secondary">US Dollar account</div>
        <div className="text-xs text-text-muted">****1247 · Personal</div>
      </div>
    </div>
    <button className="size-10 rounded-full bg-surface-panel flex items-center justify-center text-text-secondary">
      ⋯
    </button>
  </div>

  <div>
    <div className="text-xs font-medium text-text-muted">Available balance</div>
    <div className="text-5xl font-bold tabular-nums tracking-tight text-text-primary mt-1">
      $24,847<span className="text-3xl text-text-secondary font-semibold">.32</span>
    </div>
    <div className="text-sm text-text-secondary mt-1">
      ≈ €22,953 · ≈ £19,718
    </div>
  </div>

  <div className="mt-6 grid grid-cols-4 gap-3">
    {[
      { icon: "↑", label: "Send" },
      { icon: "↓", label: "Receive" },
      { icon: "⇄", label: "Convert" },
      { icon: "+", label: "Add money" },
    ].map((a) => (
      <button key={a.label} className="flex flex-col items-center gap-2 py-2">
        <div className="size-14 rounded-full bg-brand-soft flex items-center justify-center text-brand text-xl font-bold">
          {a.icon}
        </div>
        <span className="text-xs font-semibold text-text-primary">{a.label}</span>
      </button>
    ))}
  </div>
</div>
```

## Reference URLs

- Wise — https://wise.com
- Revolut — https://www.revolut.com
- Cash App — https://cash.app
- Monzo — https://monzo.com
- N26 — https://n26.com
- Chime — https://www.chime.com
- Klarna — https://www.klarna.com
- Stake — https://hellostake.com

## Verification (Retail Polish Light specific)

- [ ] Background is white or near-white (#FFFFFF–#FAFAFA)
- [ ] Brand color used consistently
- [ ] Hero balance number is 32-48px sans bold
- [ ] Card radii are 16-24px (visibly rounded)
- [ ] Button radii are pill (999px)
- [ ] No mono on prices or prominent numbers
- [ ] Sans throughout (no serif, no mono on data)
- [ ] Row heights 48-56px (generous)
- [ ] Form fields 48-56px tall
- [ ] Tap targets ≥48px
- [ ] Action button row (Send/Receive/Convert/etc.) prominently displayed
- [ ] Light theme is default; dark theme is optional secondary
- [ ] Soft shadows on elevated cards (not flat borders)
- [ ] Tabular nums on numbers despite the friendly feel
