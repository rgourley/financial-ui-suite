# Heatmaps and Density Visualization

Cell-density viz (sector heatmaps, options chain color scales, IV surfaces, correlation grids) follows different rules from tables. Color carries the data, not the number.

## Color Scale Rules

- **Diverging scale for signed values** (% change, P&L): green-neutral-red with white/grey neutral at zero. Map zero exactly to the neutral, not the midpoint of the data range.
- **Sequential scale for magnitude-only values** (volume, OI, IV): single hue light→dark.
- **Cap the scale.** Outliers blow out the middle. Cap at p95/p5 or fixed ±5% for daily change.
- **Use perceptually-uniform palettes** (viridis, magma) for sequential. Avoid raw HSL gradients — they over-emphasize the middle.
- **Pair color with number.** Cell value renders on top of the color. Color is a scan signal, the number is the truth.

## Sector / Market Heatmap

Treemap layout: rectangle area = market cap (or weight), color = % change.

| Element | Rule |
|---|---|
| Cell label | Ticker (mono, sized to cell), then % change below |
| Color scale | Diverging green/red, ±3% or ±5% cap |
| Cell border | 1px `surface` color to separate rectangles |
| Hover | Show full name, price, volume, intraday range |
| Click | Drill into symbol |
| Group labels (sector) | Top of each group, contrast-checked against busiest cell color |

Threshold: if a cell is too small to show the ticker, don't render text at all. Don't shrink to 6px.

## Options Chain Color Scale

Options chains use color across columns (volume, OI, IV) within a fixed strike grid.

- Each numeric column gets its **own** scale, normalized within the visible strikes — not cross-column.
- Don't color the strike, the bid, or the ask. Coloring those reads as "this is the signal", which it isn't.
- ITM rows: subtle background tint (negative for calls, positive for puts, by convention). Tint is row-level, not column-level.
- ATM row: 2px border-top + border-bottom in `text-muted/40` to mark center.

## IV Surface

3D-ish surface (strike × expiry → IV). Render as 2D heatmap with axes.

- X axis: expiry (left = nearest)
- Y axis: strike (bottom = lowest)
- Color: IV magnitude, sequential scale (viridis works)
- Contour lines at fixed IV intervals (every 5%) for at-a-glance reading
- Tooltip on hover: exact strike, expiry, IV%, vega, last trade

## Correlation Grid

Symmetric matrix, diagonal is 1.0.

- Diverging scale: blue (−1) → white (0) → red (+1).
- Numbers shown in the cell, 2-decimal precision.
- Diagonal cells render grey, no number (or just `1.00` muted).
- Group/sort related symbols together (sector clustering) so the structure is visible.

## Density Floor

Density viz fails at low density:
- <8 cells: use a table instead. Heatmap reads as a pie chart joke.
- 8-40 cells: heatmap with numbers in every cell.
- 40-200 cells: heatmap with numbers when cell area > threshold; tooltip otherwise.
- 200+ cells: scan-only, no inline numbers, tooltip mandatory.

## Anti-Patterns

| Don't | Why |
|---|---|
| Diverging scale with no zero anchor | Zero floats; eye can't tell positive from negative |
| Pure HSL rainbow palette | Perceptually non-uniform; over-emphasizes the middle |
| Cross-column normalization in options chain | Volume and OI scales aren't comparable |
| Shrink text below 9px to fit a cell | Don't render text at all instead |
| Color the ticker instead of the data cell | Ticker is identity, not signal |
| Animate cell color on every tick | Heatmap is a scan surface, not a streaming surface — throttle to 1Hz |
| Hide the legend | Diverging scale needs a visible legend with caps marked |
| Use red/green only | 8% of men can't distinguish; pair with intensity or a label |
