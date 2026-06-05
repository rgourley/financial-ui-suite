# Chart Interactions

Patterns and animations specific to interactive financial charts. Base correctness is in `charts-and-candles.md`.

## Crosshair

Always-on horizontal + vertical line tracking the cursor. Snaps to candle midpoint, never floats between bars.

- Show price (right axis tag) and time (bottom axis tag) at intersection.
- Hairline width: 1px. Color: `text-muted/60`.
- Hide on cursor leave with 80ms fade.
- Touch: snap to nearest candle on first touch, persist until next touch elsewhere.

## Zoom and Pan

| Input | Action |
|---|---|
| Wheel up/down | Zoom in/out around cursor X |
| Click + drag horizontally | Pan time axis |
| Click + drag vertically on Y axis | Rescale price axis |
| Pinch (touch) | Zoom around pinch center |
| Double-click chart body | Reset to default view |
| Double-click X axis | Fit all data |
| Shift + drag | Brush-select range (zoom into selection) |

Easing: 180ms `ease-out` for wheel zoom. Pans are instant — no easing, follows pointer 1:1.

## Drawing Tools

Common tools: trend line, horizontal line, vertical line, rectangle, Fibonacci retracement, annotation/text.

- Drawings persist per-symbol-per-timeframe in local storage.
- Selected drawing shows 2-3 anchor handles; non-selected drawings are thinner and lower contrast.
- Right-click drawing → contextual menu (delete, duplicate, lock, color).
- Locked drawings are immovable, dimmed, no anchor handles.

## Multi-Pane Charts

Price + volume + indicators stacked vertically, sharing X axis.

- Synced crosshair: vertical line spans all panes, horizontal price label per pane.
- Independent Y zoom per pane.
- Draggable pane dividers, min-height 60px per pane.
- Pane visibility toggles in the chart toolbar, not buried in settings.

## Number Animations

| Surface | Animation |
|---|---|
| Hero P&L / portfolio total | Count-up over 400-600ms when value changes by >5%. Skip for sub-1% deltas. |
| Sparkline | Morph path with 200ms `ease-out` on data append. Never crossfade. |
| Tick flash (background) | Default for table cells. 300-400ms tinted bg. |
| Tick flash (glyph) | Arrow up/down with 200ms fade. Use when bg flash conflicts with row hover. |
| Order book row insert/remove | 120ms slide + fade. Never pop. |
| Axis rescale | 180ms `ease-out` on the labels, instant on the gridlines. |

## Reduced Motion

Under `@media (prefers-reduced-motion: reduce)`:
- No count-up. Snap to final value.
- No sparkline morph. Snap.
- Tick flash background only (no glyph motion).
- Crosshair shows/hides without fade.

## Anti-Patterns

| Don't | Why |
|---|---|
| Crosshair that floats between candles | Reads wrong price; snap to candle |
| Wheel zoom that loses cursor anchor | Disorienting; always zoom around cursor X |
| Smooth pan with easing | Pan must feel 1:1 with pointer |
| Drawings stored per-session only | Pros expect persistence across reloads |
| Animated zoom past 250ms | Trader fatigue; rapid view changes need to feel snappy |
| Count-up on every tick | Should fire on meaningful deltas only |
| Pane reorder via settings menu | Direct manipulation expected (drag the divider) |
| Crosshair fade-in over 200ms | Should appear instantly on cursor enter |
