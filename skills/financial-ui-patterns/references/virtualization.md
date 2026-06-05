# Virtualization

When the row count exceeds what the viewport renders, virtualize. For trading UIs the threshold is lower than you think because each tick re-renders.

## When to Virtualize

| Rows | Streaming? | Decision |
|---|---|---|
| <100 | No | No virt. Plain map. |
| <100 | Yes | No virt, but memoize each row by ID. |
| 100-500 | No | Optional. Test scroll perf first. |
| 100-500 | Yes | Virtualize. Tick updates compound. |
| 500+ | Either | Virtualize. |
| Order book (15-50 levels per side) | Yes | No virt. Memoize. |
| Trades tape (append-only) | Yes | Virtualize with reverse-prepend; cap retained rows at 2000-5000. |

## Library Choice

| Use case | Pick |
|---|---|
| Fixed row height, simple table | `@tanstack/react-virtual` |
| Variable row height (expanded order detail) | `@tanstack/react-virtual` with measure refs |
| Sticky headers + horizontal scroll | `react-window` + custom outer |
| Massive (10k+ rows) with grouping | `react-arborist` or custom |

Don't reach for AG Grid or Handsontable on a financial UI unless you need pivots / cell editing. They bring 200KB+ and a non-native interaction model.

## Critical Patterns

### Memoize the row, not the table

```tsx
const Row = memo(function Row({ position }: { position: Position }) {
  return <RowContent position={position} />;
}, (a, b) => a.position.id === b.position.id && a.position.version === b.position.version);
```

Without this, every tick re-renders every row. `version` increments only on actual data change.

### Sticky header

Header lives outside the virtualized container. Match column widths via shared `grid-template-columns` token or CSS variables.

### Scroll restoration

Save scroll offset on unmount, restore on mount. Pros tab away and back constantly.

### Tick flash with virt

Tick flash uses `data-flash` attribute on the cell, transitioned via CSS. Virtualization doesn't break this because each cell owns its own state — but the cell must NOT remount on scroll (stable keys).

### Reverse-prepend for trades tape

New trades arrive at the top. Naive `[...newTrades, ...old]` causes every visible row to re-key. Use a stable circular buffer keyed by trade ID, render bottom-up:

```tsx
const buffer = useTradesBuffer(symbol, { max: 2000 });
// buffer is stable; new trades shift in at index 0 with new ID, old fall off the end
```

## Anti-Patterns

| Don't | Why |
|---|---|
| Virtualize a 50-row order book | Adds complexity, breaks depth-bar layout |
| Re-render whole table on tick | Drops frames past 100 cells streaming |
| Use index as row key | Tick flash flashes wrong row on reorder |
| Variable row height without measure ref | Scroll jumps and overshoots |
| Header inside virtualized container | Header scrolls with rows |
| Recompute formatted values per render | Format in selector, memoize |
| Use `useEffect` to scroll-to-bottom on new trade | Causes jank; use CSS `scroll-snap` or `behavior: "instant"` |
