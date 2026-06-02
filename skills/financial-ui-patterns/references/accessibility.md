# Accessibility for Financial UIs

Financial UIs have specific accessibility constraints. The big one: ~8% of men have red-green color blindness. If your only signal for gain/loss is red/green, those users cannot trade.

## Color Blindness

### The numbers
- Deuteranomaly (mild green deficiency): ~5% of men
- Protanomaly (mild red deficiency): ~1%
- Deuteranopia / Protanopia (complete red-green): ~2%
- Tritanopia (blue-yellow): rare, < 0.01%

For a US trading product with 100,000 users (50/50 split): roughly 4,000 cannot reliably distinguish standard red/green.

### Rule: never rely on color alone

Every red/green signal must have a second non-color cue:

| Signal | Color | Second cue |
|---|---|---|
| Gain/loss % | green/red | `+` / `-` sign prefix |
| Buy/sell side | green/red | `BUY` / `SELL` label (uppercase) |
| Candle direction | green/red | hollow vs filled body |
| Order book bid/ask | green/red | position (bids below, asks above) |
| Up/down tick | green/red | ▲ / ▼ arrow icon |
| Order status (filled/rejected) | green/red | label text in pill |

### Color-blind safe palette

For products that take accessibility seriously, expose an alternate palette setting:

```css
[data-cb-mode="protanopia"] {
  --positive: 37 99 235;     /* blue */
  --negative: 234 88 12;     /* orange */
}
```

Blue/orange is distinguishable for all common color blindness types. Bloomberg has this setting.

### Test in grayscale

In Chrome DevTools → Rendering → Emulate vision deficiencies, switch to "achromatopsia" (total grayscale). Walk through your UI:
- Can you tell gains from losses?
- Can you tell buy from sell orders?
- Can you tell up candles from down?

If anything is unclear, the cue is too color-dependent.

## Contrast

### WCAG ratios

- Normal text (< 18px): 4.5:1 minimum
- Large text (≥ 18px or bold): 3:1 minimum
- UI components and graphical objects: 3:1 minimum

### Common violations in financial UIs

| Issue | Fix |
|---|---|
| `text-text-muted` (e.g., #6e6e7d) on `surface-elevated` (#16161a) | Usually 4.0:1 — fails for body text. Bump muted lighter. |
| Light grey labels on white | Need ≥ 4.5:1. Test in light theme. |
| Red text on dark red flash background | Briefly fails during tick flash. OK because brief; not OK if permanent. |
| Color-coded only chart legends | Add patterns (dashed/dotted/solid) or shape markers |

### Test tools

```bash
# Install pa11y for CLI WCAG checks
npm i -D pa11y
npx pa11y http://localhost:3000/portfolio
```

Or use Chrome DevTools → Lighthouse → Accessibility.

## Keyboard Navigation

Pro traders use keyboard heavily. Especially:

- **Arrow keys** to navigate watchlist / order book rows
- **Enter** to trigger trade form for selected row
- **Esc** to cancel modal / blur input
- **Tab order** must follow visual order
- **Skip links** for keyboard users to bypass header nav

### Focus visible

Default browser focus rings are often invisible on dark themes. Define an explicit, high-contrast ring:

```css
:root {
  --focus-ring: 0 0 0 2px rgba(0, 143, 250, 0.5), 0 0 0 4px rgba(0, 143, 250, 0.15);
}

*:focus-visible {
  outline: none;
  box-shadow: var(--focus-ring);
  border-radius: var(--radius-md);
}
```

Use `:focus-visible` not `:focus` so mouse users don't see the ring, only keyboard users.

## Screen Readers

### Live regions for streaming data

Streaming prices shouldn't fire screen reader announcements on every tick (that's torture). Use `aria-live="off"` on price cells, and only announce material changes (e.g., order filled):

```tsx
{/* Price updates silently */}
<span aria-live="off" className="tabular-nums">${price}</span>

{/* Order fill announces */}
{lastFill && (
  <div role="status" aria-live="polite" className="sr-only">
    Order filled: {lastFill.size} {lastFill.symbol} at ${lastFill.price}
  </div>
)}
```

### Number readout

`tabular-nums` doesn't affect screen readers — they read the actual string. But CSS that hides parts of numbers does. Avoid:

```tsx
// BAD: screen reader reads ".34%" 
<span>
  <span className="invisible">+2</span>.34%
</span>
```

### Sparkline alt text

Charts and sparklines should have meaningful aria labels:

```tsx
<svg aria-label={`${symbol} 7-day trend: ${changePct >= 0 ? 'up' : 'down'} ${Math.abs(changePct).toFixed(1)}%`}>
```

Or `aria-hidden` if the same information is shown adjacent.

### Tables

Use real `<table>` elements with `<th scope="col">` for column headers. Pro traders' screen readers depend on table semantics for navigation.

```tsx
<table>
  <caption className="sr-only">Portfolio holdings</caption>
  <thead>
    <tr>
      <th scope="col">Asset</th>
      <th scope="col">Price</th>
      <th scope="col">24h change</th>
      ...
    </tr>
  </thead>
  ...
</table>
```

## Motion Reduction

Respect `prefers-reduced-motion`:

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

For tick flashes, an alternative: keep the brief background change but disable transition. The change still registers visually.

## Text Zoom

Pro traders often zoom UI to 110-120%. Use `rem`-based sizing so zoom scales correctly:

```css
/* GOOD: scales with browser zoom */
.text-sm { font-size: 0.8125rem; }  /* 13px at 16px root */

/* BAD: fixed px ignores zoom in some browsers */
.text-sm { font-size: 13px; }
```

(Tailwind uses `rem` by default for `text-*` classes. Keep it.)

## Touch targets

For mobile/tablet financial apps:
- Minimum 44x44px tap targets
- Buttons in tables need adequate padding
- Don't make rows the tap target unless every part of the row should navigate

## Internationalization

Quick wins:
- Use `toLocaleString` with explicit locale
- Don't hard-code `$` if you support multiple currencies
- Handle RTL (Arabic, Hebrew) — numbers stay LTR even in RTL text
- Negative number conventions: `-$1.50` (Western) vs `($1.50)` (accounting) vs `1.50-` (some EU)

```ts
const FORMAT = new Intl.NumberFormat(userLocale, {
  style: "currency",
  currency: userCurrency,
});
```

## Checklist

Before shipping a financial surface:

- [ ] All gain/loss signals have a non-color cue (sign, arrow, label)
- [ ] Tested in grayscale mode — still parseable
- [ ] Contrast ratios pass WCAG AA for text and UI elements
- [ ] Keyboard navigation works for all interactive rows
- [ ] Focus rings visible and high-contrast
- [ ] Streaming prices do not announce to screen readers
- [ ] Material events (order fills, errors) announce via `aria-live="polite"`
- [ ] Real `<table>` semantics on data tables
- [ ] `prefers-reduced-motion` respected
- [ ] Sparklines have aria labels or `aria-hidden`
- [ ] Numbers and currency localize correctly
