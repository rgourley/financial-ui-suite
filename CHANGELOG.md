# Changelog

All notable changes to this plugin. Newest first.

## [Unreleased]

### Changed
- Renamed `financial-ui-personas` skill to `financial-ui-styles` (folder, plugin metadata, all prose). `Style` replaces `Persona` throughout. Reinstall required.
- Style Index in styles SKILL.md dropped the stale Status column (all 10 styles ship the same depth).
- "How to Pick" replaced the GraphViz decision tree with a clean audience → style table.
- Patterns SKILL.md gained Tailwind v4 (`@theme`) form alongside the v3 (`tailwind.config.ts`) form.
- README install section now shows GitHub `git clone` form in addition to local path.
- README adds a Scope section clarifying React + Tailwind in examples; rules are framework-agnostic.

### Added
- `financial-ui-patterns/references/loading-and-skeletons.md` — skeleton shapes, shimmer rules, reconnect treatment.
- `financial-ui-patterns/references/empty-and-error-states.md` — empty positions/orders, rejected/closed/rate-limited surfaces.
- `financial-ui-patterns/references/timestamps-and-timezones.md` — TZ display, "as of" stamps, ms precision rules.
- `financial-ui-patterns/references/virtualization.md` — when to virtualize, row memoization, trades-tape buffer.
- `financial-ui-patterns/references/chart-interactions.md` — crosshair, zoom/pan, drawing tools, multi-pane stacks, number animations.
- `financial-ui-patterns/references/order-entry-and-lifecycle.md` — order forms, types, preview-then-submit, pending → filled states, T&S tape.
- `financial-ui-patterns/references/alerts-and-disclosures.md` — escalation rules, price alerts, PDT/wash-sale/options gating.
- `financial-ui-patterns/references/data-sources-and-freshness.md` — real-time → delayed → stale → frozen chain, source attribution, multi-account context.
- `financial-ui-patterns/references/heatmaps-and-density-viz.md` — sector heatmaps, options color scales, IV surface, correlation grids.
- `apple-native` style now documents SF Pro licensing constraint.

### Fixed
- `mobile-and-responsive.md` is now properly tracked (was orphaned by the v0.3.0 commit message but not staged).
- `.orphaned_at` added to `.gitignore`.

## [0.3.0] — 2026-06-02

### Added
- `financial-ui-patterns/references/mobile-and-responsive.md` — phone/tablet patterns, responsive tables, bottom sheets, touch interactions.

## [0.2.0] — 2026-06-02

### Added
- Deep-fills for the remaining 6 styles: pro-terminal, tasty-pro, crypto-exchange, retail-polish-light, defi-native, apple-native.
- Trademark notice in README.

## [0.1.0] — 2026-06-02

### Added
- Initial release. `financial-ui-patterns` (correctness) and `financial-ui-personas` (visual styles, since renamed to `financial-ui-styles`).
- 4 deep styles, 6 stubs (later filled in 0.2.0).
- Composition with `product-design`.
