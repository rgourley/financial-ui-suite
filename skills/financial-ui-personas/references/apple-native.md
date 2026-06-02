# apple-native (stub)

**Reference products:** iOS Stocks app, macOS Stocks widget, Wallet app stock cards, Apple Cash, App Store Connect financial reports.

**One-line:** translucent surfaces, SF Pro Display + SF Pro Mono, system blur (vibrancy), seamless light/dark transitions, refined iOS feel. Use only for native iOS companions or web that explicitly mimics native iOS.

## Distinguishing characteristics

- **Surfaces:** translucent. `bg-white/70` + `backdrop-blur-2xl` over dynamic backgrounds. System vibrancy in native, approximated in web.
- **Typography:** SF Pro Display for display, SF Pro Text for body, SF Pro Mono for numbers and tickers. On web, fall back to `-apple-system, BlinkMacSystemFont` stack.
- **Density:** 44-52px row heights (Apple HIG minimum touch targets), 16-17px body. Generous whitespace.
- **Radius:** continuous-corner squircles (`border-radius: 22px / 28px` for full effect via `-webkit-border-radius` or SVG masks). On web, 16-24px is acceptable.
- **Theme transitions:** smooth via system, near-instant on web with CSS variable switching.
- **Color accents:** system colors — iOS blue `0 122 255`, green `52 199 89`, red `255 59 48`, yellow `255 204 0`. Use SP-defined names.

## Apple-specific patterns

- **Section grouping:** rounded card containers grouping related rows (Settings-app pattern)
- **Chevrons on rows:** rightward `›` indicator for "tap to drill in"
- **Subtle hairlines:** between rows within a section, none between sections
- **Action sheets:** bottom-anchored modals with rounded top corners
- **Tab bar:** bottom tab bar on iOS (use bottom nav on web if mimicking)
- **SF Symbols:** use SF Symbols (or approximations) for icons, not custom icon sets
- **Haptic feedback:** native only; on web, use brief opacity/scale transitions for tactile feel
- **Dynamic Type:** scale typography with user preference (less applicable to web)

## When to use

- Native iOS companion apps for your products (Massive iOS app, ClawStreet iOS)
- Web pages explicitly designed to mimic iOS for cross-platform consistency
- Apple-ecosystem-first products (anything heavily integrated with Apple Pay, Wallet, etc.)

## When NOT to use

- Web products with no iOS pairing
- Android-first or cross-platform-equal products
- Pro trading desktops
- Anything where Apple HIG conflicts with your needs

## Reference URLs

- Apple Human Interface Guidelines — https://developer.apple.com/design/human-interface-guidelines
- iOS Stocks app — examine on actual iPhone/iPad
- Apple Wallet — examine on iPhone
- Apple Newsroom Stocks press images — https://www.apple.com/newsroom/
- Studies: Sebastiaan de With, Marc Edwards, Dribbble shots tagged "iOS"

## Anti-patterns specific

- Don't use generic system fonts (must be SF Pro stack or proper fallback)
- Don't use square corners (continuous-corner radius is signature)
- Don't skip the vibrancy/translucency on iOS native
- Don't ignore touch target minimums (44pt)
- Don't use non-Apple system colors (mix custom with SP-defined palette only)
- Don't use serif anywhere
- Don't replicate Android Material patterns

## Deep-fill triggers

Promote when:
- Building an actual iOS app (Swift/SwiftUI)
- Cross-platform web needs heavy iOS fidelity
- Massive ships an iOS companion app you're styling

For now, follow `modern-pro-dark` for the structure and override:
- SF Pro font stack
- Continuous-corner radii (16-24px)
- Translucent panels with backdrop-blur
- System color palette (iOS blue/green/red)
- 44pt+ touch targets
- Section grouping with hairlines between rows only
