# pro-terminal

**Reference products:** Bloomberg Terminal, Interactive Brokers TWS Desktop, ThinkOrSwim, TradeStation, Reuters Eikon, eSignal.

**One-line:** institutional desktop terminal. Black or near-black with amber accent. Mono-everywhere, ALL CAPS section labels with bracket separators. Max density. 0-2px radius. Function-key driven. Command-line first.

## Token Set

```css
:root[data-theme="dark"] {
  --surface:           0 0 0;          /* pure black */
  --surface-chrome:    20 20 22;       /* window chrome */
  --surface-elevated:  8 8 10;
  --surface-panel:     16 16 18;
  --surface-hover:     28 28 30;

  --text-primary:   240 240 245;
  --text-secondary: 180 180 192;
  --text-muted:     130 130 140;

  --amber:        255 176 0;            /* Bloomberg signature */
  --amber-bright: 255 200 60;
  --amber-dim:    255 176 0 / 0.55;
  --cyan:         0 210 255;
  --blue:         80 140 220;

  --positive: 0 230 110;
  --negative: 255 60 60;
  --warning:  255 196 0;

  --accent: 255 176 0;
  --border: 255 176 0;

  --radius-md: 0.125rem;                /* 2px — sharp */
  --radius-lg: 0.125rem;
}

:root[data-theme="light"] {
  --surface:           248 246 240;
  --surface-chrome:    234 230 222;
  --surface-elevated:  240 236 226;
  --surface-panel:     228 222 212;
  --text-primary:      30 28 22;
  --text-secondary:    80 72 60;
  --text-muted:        128 118 100;
  --amber:        170 100 0;
  --positive: 0 130 60;
  --negative: 200 30 30;
  --accent: 170 100 0;
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Headline ticker | Mono (IBM Plex Mono, JetBrains Mono) | 18-22px | 700 |
| Section labels | Mono UPPERCASE, bracket-wrapped `[ QUOTE ]` | 10-11px | 700 |
| Field labels | Mono UPPERCASE | 10px | 700 |
| Body data | Mono + `tabular-nums` | 12-13px | 500 |
| Stats / chrome | Mono | 10-11px | 400-500 |
| Function keys | Mono `F1 HELP` | 11px | 700 amber, 400 white label |
| Command line | Mono | 11-12px | 700 |

**Pro Terminal is mono-everywhere.** No sans, no serif. The whole aesthetic depends on monospace alignment and ALL CAPS section structure.

## Density

| Element | Pixel range |
|---|---|
| Table row | 22-26px |
| Order book row | 18-22px |
| Cell horizontal padding | 6-10px |
| Section padding | 8-12px |
| Function key strip | 24-28px tall |
| Status bar strip | 20-24px tall |

Pro Terminal is **the densest of all styles.** 40+ rows per screen is expected.

## Visual Rules

- **Borders:** hairline amber `rgba(255, 176, 0, 0.22)` for major sections; dim white `rgba(255, 255, 255, 0.08)` for sub-rows
- **Radius:** 0-2px. Sharp corners everywhere.
- **Shadows:** none. CRT aesthetic.
- **Gradients:** none. Pure flat color.
- **Hover:** subtle bg change to `surface-hover`; no transition delay
- **Focus:** amber 1px ring (no halo)
- **Motion:** essentially none. No transitions over 80ms.

## Pro Terminal-Specific Patterns

### Window chrome
- Title bar at top with traffic-light dots
- "Window N / 4 · TILED" indicator showing pane layout state
- Tearable panes (drag to undock)

### Command bar (Bloomberg signature)
- Always present at top of any screen
- Format: `> TICKER FUNCTION` (e.g., `> ES Z26 EQUITY DES`)
- `<GO>` prompt to execute
- "Type any function or topic" placeholder
- Amber border, black inner

### Section labels
- Always uppercase mono with bracket wrappers: `[ QUOTE ]`, `[ DEPTH · NBBO ]`, `[ T&S ]`
- Numbered for keyboard access: `[1] QUOTE`, `[2] CHART`
- Always amber

### Function keys (F1-F12)
- Bottom of screen (NOT top — common AI mistake)
- Format: `F1 HELP   F2 QUOTE   F3 CHART ...`
- Function number in bright amber, label in dim amber/white
- Real terminals have memorized shortcuts; show them in tooltips

### Status bar
- Bottom-most strip
- Shows: user, account, server time (multiple timezones), feed health, ping, build version
- Always tab-separated, never with icons

### Four-quadrant layout
- Default to 4 panes per window: top-left, top-right, bottom-left, bottom-right
- Each pane numbered `[1]`, `[2]`, `[3]`, `[4]`
- Equal heights (don't let one pane grow taller than another in a single window)
- Amber dividers between quadrants

### Color coding conventions
- **Amber:** labels, structural elements, dim chrome
- **White:** primary data values
- **Green:** positive deltas, bid prices, buy side
- **Red:** negative deltas, ask prices, sell side
- **Cyan:** secondary indicators (SMA, EMA overlays)
- **Never use brand colors** outside this palette

## Anti-Patterns (Pro Terminal specific)

| Don't | Why |
|---|---|
| Function keys at TOP | Bloomberg/TWS put them at bottom. Top placement reads as "fake" |
| Rounded corners >2px | Reads as consumer/web, not terminal |
| Drop shadows | CRT aesthetic — no shadows |
| Generous whitespace | Wastes screen real estate |
| Sentence case section labels | Must be UPPERCASE with brackets |
| Multiple accent colors | Single amber identity |
| Sans-serif anywhere | Mono everywhere — no exceptions |
| Auto-hiding controls | Pros want every control visible always |
| Smooth animated transitions | Trader fatigue; near-instant only |
| Modern blue accent | This is the Bloomberg aesthetic — amber is the signature |

## Example: Pro Terminal command bar + quote block

```tsx
<div style={{ background: "rgb(0,0,0)", color: "rgb(240,240,245)", fontFamily: "JetBrains Mono, ui-monospace, monospace" }}>
  {/* Command bar */}
  <div style={{ padding: "8px 10px", background: "rgba(255,176,0,0.04)", borderBottom: "1px solid rgba(255,176,0,0.22)", display: "flex", alignItems: "center", gap: 10 }}>
    <div style={{ flex: 1, border: "1px solid rgb(255,176,0)", padding: "4px 8px", background: "rgba(0,0,0,0.5)" }}>
      <span style={{ color: "rgb(255,176,0)", marginRight: 8, fontWeight: 700 }}>{">"}</span>
      <span style={{ color: "rgb(240,240,245)", fontWeight: 700 }}>ES Z26 EQUITY</span>
      <span style={{ color: "rgba(255,176,0,0.55)", marginLeft: 8 }}>Type any function or topic</span>
      <span style={{ float: "right", color: "rgb(255,176,0)", fontSize: 10 }}>{"<GO>"}</span>
    </div>
  </div>

  {/* Quote block */}
  <div style={{ padding: "10px 14px", borderBottom: "1px solid rgba(255,255,255,0.08)" }}>
    <div style={{ color: "rgb(255,176,0)", fontSize: 10, letterSpacing: "0.1em", marginBottom: 6, fontWeight: 700 }}>[1] QUOTE</div>
    <div style={{ display: "grid", gridTemplateColumns: "repeat(4, 1fr)", gap: "14px 14px" }}>
      <Stat label="LAST" value="5,847.25" strong />
      <Stat label="CHG" value="+12.75" tone="positive" />
      <Stat label="PCT" value="+0.22%" tone="positive" />
      <Stat label="VOL" value="1,247,830" />
    </div>
  </div>
</div>
```

## Reference URLs

- Bloomberg Terminal — https://www.bloomberg.com/professional/products/bloomberg-terminal/
- IBKR Trader Workstation — https://www.interactivebrokers.com/en/trading/tws.php
- ThinkOrSwim by Schwab — https://www.schwab.com/trading/thinkorswim
- TradeStation — https://www.tradestation.com
- Refinitiv Eikon — https://www.refinitiv.com/en/products/eikon-trading-software

## Verification (Pro Terminal specific)

- [ ] Background is pure black or near-black
- [ ] Amber `rgb(255, 176, 0)` is the sole accent color
- [ ] Mono font on EVERY text element (no sans anywhere)
- [ ] Section labels are UPPERCASE with bracket wrappers `[ ... ]`
- [ ] Function keys at the BOTTOM, not top
- [ ] Command bar at the top with `> TICKER FUNCTION` format and `<GO>` prompt
- [ ] Status bar at the very bottom with system metrics (user, time, feed, ping)
- [ ] Table rows 22-26px tall, dense
- [ ] 0-2px border radius throughout
- [ ] No shadows, no gradients
- [ ] Amber dividers between major sections
- [ ] Four-quadrant layout used for primary trading view (Quote, Chart, Depth, T&S)
