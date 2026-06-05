# Loading and Skeletons

Never spin on a data table. Use a skeleton that pre-allocates the final layout, then fade to live data with no shift.

## Treatment by Surface

| Surface | Treatment |
|---|---|
| Table / order list | Skeleton rows matching final count |
| Order book | Skeleton bid/ask rows with random-width depth bars |
| Chart | Axis + gridlines only. Never fake candle bodies |
| Sparkline | Flat hairline placeholder, no shimmer |
| Hero number (P&L, total) | Block sized to final formatted number width |
| Cell awaiting first tick | `--` in `text-muted`. Not a skeleton |
| Submit action (place order) | Button `loading` state, disabled cursor. No overlay |
| Reconnect after disconnect | Dim last-known data to 50%, show "Reconnecting…" pill. Never blank |

## Skeleton Anatomy

Match the real row's `grid-template-columns` exactly. Cap row count at viewport height + 1.

```tsx
<div
  role="status"
  aria-label="Loading"
  className="grid gap-2 px-3 h-8 items-center border-b border-border/10"
  style={{ gridTemplateColumns: cols.map(c => `${c}px`).join(" ") }}
>
  {cols.map((w, i) => (
    <div key={i} className="h-3 rounded-sm bg-text-muted/15 animate-pulse" style={{ width: w - 12 }} />
  ))}
</div>
```

## Shimmer

- `animate-pulse` (opacity), not translate. Cheaper at 100+ rows.
- Period 1.4-1.8s. Opacity 0.4-0.7 of base.
- Disable under `prefers-reduced-motion`.
- Hold ≥200ms or skip the skeleton entirely.

## Anti-Patterns

| Don't | Why |
|---|---|
| Centered spinner over a table | No layout reservation, snaps on load |
| Pill-shaped skeleton blocks | Reads as social UI, not data |
| Bright shimmer peak (>70%) | Looks like content, not placeholder |
| Skeleton rows past viewport | Wasted DOM |
| Skeleton on streaming first tick | Use `--` muted; skeleton implies "soon" not "never" |
| Blank on reconnect | Pros need last-known data even when stale |
| Skeleton on tab change | Cache; skeleton only on cold load |
| Fake candle bodies in chart skeleton | Pop-in reads as data correction |
