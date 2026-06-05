# apple-native

**Reference products:** iOS Stocks app, macOS Stocks widget, Wallet app, Apple Cash, App Store Connect financial reports, Numbers spreadsheet.

**One-line:** translucent surfaces with system blur (vibrancy), SF Pro Display + SF Pro Mono, system colors, continuous-corner radii (squircles), seamless light/dark transitions, refined iOS feel. Use only for native iOS companions or web that explicitly mimics native iOS.

## Token Set

```css
:root[data-theme="dark"] {
  /* iOS Dark Mode system surfaces */
  --surface:           0 0 0;
  --surface-elevated:  28 28 30;
  --surface-panel:     44 44 46;
  --surface-grouped:   18 18 20;
  --surface-hover:     58 58 60;

  /* Translucent overlays */
  --glass-bar:    255 255 255 / 0.05;
  --glass-card:   255 255 255 / 0.08;

  /* iOS Dark Mode label colors */
  --text-primary:   255 255 255;
  --text-secondary: 235 235 245 / 0.6;
  --text-tertiary:  235 235 245 / 0.3;
  --text-muted:     235 235 245 / 0.18;

  /* iOS system colors */
  --ios-blue:    10 132 255;
  --ios-green:   52 199 89;
  --ios-red:     255 69 58;
  --ios-orange:  255 159 10;
  --ios-yellow:  255 214 10;
  --ios-pink:    255 55 95;
  --ios-purple:  191 90 242;
  --ios-teal:    100 210 255;
  --ios-indigo:  94 92 230;

  --positive: 52 199 89;
  --negative: 255 69 58;
  --accent: 10 132 255;
  --border: 60 60 67 / 0.6;
  --radius-md: 1rem;
  --radius-lg: 1.5rem;
}

:root[data-theme="light"] {
  --surface:           255 255 255;
  --surface-elevated:  242 242 247;
  --surface-panel:     229 229 234;
  --surface-grouped:   242 242 247;
  --text-primary:      0 0 0;
  --text-secondary:    60 60 67 / 0.6;
  --text-tertiary:     60 60 67 / 0.3;
  --text-muted:        60 60 67 / 0.18;
  --ios-blue:    0 122 255;
  --ios-green:   52 199 89;
  --ios-red:     255 59 48;
  --positive: 52 199 89;
  --negative: 255 59 48;
  --accent: 0 122 255;
  --border: 60 60 67 / 0.29;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Large Title | SF Pro Display | 34px | 700 |
| Title 1 | SF Pro Display | 28px | 700 |
| Title 2 | SF Pro Display | 22px | 700 |
| Title 3 | SF Pro Display | 20px | 600 |
| Headline | SF Pro Text | 17px | 600 |
| Body | SF Pro Text | 17px | 400 |
| Callout | SF Pro Text | 16px | 400 |
| Subheadline | SF Pro Text | 15px | 400 |
| Footnote | SF Pro Text | 13px | 400 |
| Caption 1 | SF Pro Text | 12px | 400 |
| Numbers (price displays) | SF Pro Mono / SF Pro Display + `tabular-nums` | matches context | 600 |

**Web fallback stack:**

```css
font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text", system-ui, sans-serif;
font-family: ui-monospace, "SF Pro Mono", "SF Mono", Menlo, monospace; /* for mono */
```

This is the **only style where the OS font stack matters more than custom fonts.** On Apple hardware, the system fonts render perfectly. On other platforms, the fallback is acceptable but not identical.

**Licensing:** SF Pro is Apple's font, licensed for **Apple platforms only** (iOS, iPadOS, macOS apps and websites that promote Apple software/hardware). Do **not** ship `SF-Pro.woff2` from your web server for a general-purpose web app — Apple's license doesn't cover it. The `-apple-system` / `BlinkMacSystemFont` system stack above is safe because the browser resolves it locally on Apple devices and falls back elsewhere. If you need SF Pro's look cross-platform, use Inter or Geist as a close visual match.

## Density

| Element | Pixel range |
|---|---|
| List row (iOS standard) | 44px minimum (touch target) |
| Section header | 32-36px |
| Tab bar (bottom) | 49pt + safe area |
| Navigation bar | 44pt + safe area |
| Card padding | 16-20px |
| Section gap | 16-24px |

Apple Human Interface Guidelines mandate **44pt minimum touch targets**. Don't go smaller.

## Visual Rules

- **Borders:** absent except as 0.5px hairline `--border` between list rows within a section
- **Radius:** 16-24px continuous-corner (squircle) on cards
- **Shadows:** very subtle, often replaced by `backdrop-filter: blur()` (vibrancy)
- **Translucency:** signature. Navigation bars, tab bars, modals all use vibrancy
- **Hover:** very subtle bg change (web-only — iOS uses press states)
- **Press states:** brief opacity change on tap (0.6 alpha during touch)
- **Motion:** spring animations for sheet presentations; otherwise minimal

## Style-Specific Patterns

### Section grouping
- iOS Settings-app pattern
- Rows grouped into rounded card containers
- Hairline `--border` between rows WITHIN a section
- No hairline between sections (just gap)
- Group has rounded corners on first and last row

### Navigation bar (top)
- 44pt height
- Title centered (or large title on scroll)
- Back button left (`< Account`)
- Action button right (`Edit` or icon)
- Translucent with backdrop-blur

### Tab bar (bottom, iOS)
- 49pt + safe area
- 4-5 tabs typical (financial apps: Watchlist / News / Browse / Discover / Account)
- SF Symbol icons + label
- Active tab in accent color

### Chart treatment (iOS Stocks style)
- Smooth filled area chart
- Single accent color (green if positive, red if negative)
- 15% opacity fill gradient
- No grid
- Period selector (segmented control) at bottom: 1D 1W 1M 3M 6M YTD 1Y 2Y 5Y 10Y
- Touch and hold for crosshair with price label

### Watchlist row
- Symbol left
- Mini-sparkline center (44x20px)
- Price right
- Change pill (rounded rect with bg tint + text color)
- 44pt minimum height

### Chevron rows
- Right-pointing `›` indicates tap-to-drill-in
- Always at right edge
- Color: `--text-tertiary`

### Action sheets
- Bottom-anchored modal
- Rounded top corners (24-32px)
- Drag handle at top
- Translucent with vibrancy
- Sequential action buttons stacked

### Status pills / badges
- Used sparingly
- Rounded rect, 4-6px radius
- Subtle bg tint of accent color
- Small label

### SF Symbols
- Use SF Symbols icon font (or web approximations)
- 17-20pt typical size
- Match weight to surrounding text

## Anti-Patterns (Apple Native specific)

| Don't | Why |
|---|---|
| Use generic Inter / Roboto as primary font | Must be SF Pro stack or proper fallback |
| Square corners | Continuous-corner radius is signature |
| Skip vibrancy/translucency | iOS feel depends on it |
| Use Material/Android patterns | Wrong design language |
| Use serif anywhere | iOS is sans-only |
| Custom palette outside iOS system colors | Mix only with iOS-defined palette |
| Tiny touch targets (<44pt) | Apple HIG violation |
| Drop shadows where blur would work | iOS uses vibrancy, not shadows |
| Heavy animations | iOS motion is subtle and physics-based |
| Replicate web/desktop patterns blindly | Mobile-first patterns required |

## Example: watchlist row

```tsx
<button className="w-full flex items-center gap-3 px-4 h-14 hover:bg-white/5 active:opacity-60 transition-opacity"
  style={{ fontFamily: "-apple-system, BlinkMacSystemFont, SF Pro Display, system-ui, sans-serif" }}>
  {/* Symbol + name */}
  <div className="flex-1 text-left">
    <div className="text-[17px] font-semibold tracking-tight text-text-primary">AAPL</div>
    <div className="text-[13px] text-text-secondary">Apple Inc.</div>
  </div>

  {/* Sparkline */}
  <svg width="56" height="22" viewBox="0 0 56 22">
    <path d="M0,16 L8,14 L16,17 L24,12 L32,10 L40,8 L48,6 L56,4"
      fill="none" stroke="rgb(52,199,89)" strokeWidth="1.5" />
  </svg>

  {/* Price + change pill */}
  <div className="text-right">
    <div className="text-[17px] font-semibold tabular-nums tracking-tight text-text-primary">182.43</div>
    <div className="inline-flex items-center px-2 py-0.5 rounded-md text-[13px] font-semibold tabular-nums text-white"
      style={{ background: "rgb(52,199,89)" }}>
      +1.42%
    </div>
  </div>

  {/* Chevron */}
  <span className="text-text-tertiary text-lg">›</span>
</button>
```

## Reference URLs

- Apple Human Interface Guidelines — https://developer.apple.com/design/human-interface-guidelines
- iOS Stocks app — examine on iPhone/iPad (no public web URL)
- Apple Wallet — examine on iPhone
- Apple Newsroom — https://www.apple.com/newsroom/ (press images of financial UI)
- SF Symbols — https://developer.apple.com/sf-symbols/
- Apple Design Resources — https://developer.apple.com/design/resources/

## Verification (Apple Native specific)

- [ ] Font stack uses `-apple-system, BlinkMacSystemFont, "SF Pro..."` chain
- [ ] Radii are 16-24px (continuous-corner / squircle)
- [ ] Navigation bar has translucent backdrop-blur
- [ ] Tab bar at bottom (mobile) or top (macOS) with vibrancy
- [ ] Section grouping uses rounded card containers with hairlines between rows
- [ ] Tap targets are 44pt minimum
- [ ] Chevron `›` on tap-to-drill-in rows
- [ ] iOS system colors used (blue, green, red, orange, etc.)
- [ ] No serif fonts anywhere
- [ ] Charts are smooth filled area, not candles
- [ ] Period selector uses segmented control (iOS native pattern)
- [ ] Status pills/badges use rounded rect with subtle bg tint
- [ ] Press states use opacity (0.6 alpha during touch)
- [ ] Tabular nums on all numbers
