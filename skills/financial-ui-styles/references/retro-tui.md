# retro-tui

**Reference products:** Gloomberb (the direct inspiration), and TUI dashboards in its lineage — lazygit, k9s, htop/btop, tig, gitui. Optional CRT mode nods to cool-retro-term and DEC VT monitors.

**One-line:** clean modern terminal UI. Near-black ground, muted white/grey monospace text, green/red reserved for values, thin dividers, `::`-prefixed panel titles, a tiled multi-pane grid with window chrome. Restrained by default; a swappable phosphor palette and an optional CRT mode are available but off by default.

## The important correction

This is **not** a glowing CRT skeuomorph. The real aesthetic (see Gloomberb) is *restraint*: muted text, semantic color only where it means something, hairline dividers, tight panes. The phosphor palettes (amber/green/cyan) are optional themes, and scanlines/bloom are an opt-in "retro mode" — not the core look. Build the clean version first; reach for CRT only if the user asks for it.

## How this differs from `pro-terminal`

Both are black, mono, dense. They are different terminals.

| | `pro-terminal` | `retro-tui` |
|---|---|---|
| Lineage | Bloomberg / IBKR desk | Indie TUI dashboards (Gloomberb, lazygit, k9s) |
| Accent | One fixed amber | Muted; swappable phosphor themes |
| Panel labels | `[ QUOTE ]` ALL CAPS brackets | `:: Quote` title case |
| Structure | Command bar + F-keys + four quadrants | Tiled panes + window chrome + tab strips |
| Chrome | Status bar, function keys | Traffic-light dots, workspace tabs (`^1 ^2`) |
| Mood | Institutional, execution-grade | Developer/indie, personal, scannable |

## Token Set

Default is **White** (muted white-on-black — matches Gloomberb's shipped look). The palette is swappable; everything else holds.

```css
:root[data-theme="dark"] {           /* "White" — the clean default */
  --surface:          0 0 0;         /* near-black tube */
  --surface-panel:    10 10 10;
  --surface-elevated: 10 10 10;
  --surface-hover:    34 34 34;      /* row hover / selection */

  --text-primary:   204 204 204;     /* #cccccc — muted, not stark white */
  --text-bright:    255 255 255;     /* values, active tab, title */
  --text-secondary: 136 136 136;     /* labels, secondary columns */
  --text-muted:     102 102 102;     /* chrome, timestamps */

  --positive: 0 204 102;             /* #00cc66 — gains, up */
  --negative: 255 51 51;             /* #ff3333 — losses, down */
  --neutral:  136 136 136;
  --warning:  221 170 0;

  --accent:         255 255 255;     /* active-tab underline, focus */
  --border:         51 51 51;        /* #333 hairline dividers */
  --border-focused: 255 255 255;

  --radius-md: 0;                    /* terminals are a character grid */
  --radius-lg: 0;
  --glow: 0 0 0;                     /* OFF by default; retro mode sets it */
}

:root[data-theme="light"] {          /* "Paper" — warm printout */
  --surface:          247 243 232;   /* #f7f3e8 */
  --surface-panel:    255 250 240;
  --surface-elevated: 255 247 232;
  --surface-hover:    234 220 196;
  --text-primary:   47 42 35;
  --text-bright:    23 19 15;
  --text-secondary: 95 85 72;
  --text-muted:     119 107 93;
  --positive: 47 125 74;
  --negative: 179 54 48;
  --warning:  148 98 0;
  --accent:         160 90 44;
  --border:         216 205 183;
  --border-focused: 160 90 44;
  --radius-md: 0; --radius-lg: 0; --glow: 0 0 0;
}
```

**All 22 themes ship as drop-in CSS** in [`retro-tui-themes.css`](./retro-tui-themes.css): the muted White default plus phosphor hues (Amber, Green, Cyan, Red, Blue, Purple, Pink), named dev palettes (Tokyo Night, Dracula, Nord, Monokai, Catppuccin, Gruvbox, Rose Pine, Solarized, Midnight), and light variants (Paper, GitHub/Solarized/Gruvbox/Nord Light). Each is a `[data-theme="id"]` block of `R G B` tokens; set the attribute on a wrapper to switch. Named dev palettes (Dracula, Nord, …) keep their established names.

**Contrast rule:** on single-hue phosphor themes it's easy to drop below readable. Every text token must clear WCAG AA on both `--surface` and `--surface-panel` (4.5:1 body, 3:1 labels). When a raw phosphor dim fails (amber/cyan are the usual offenders), blend it toward `--text-bright` until it passes.

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Window title | Mono | 13-14px | 600 |
| Panel title | Mono, `:: Title` title case | 12-13px | 600 |
| Column headers | Mono UPPERCASE, dimmed | 10-11px | 400 |
| Body data | Mono + `tabular-nums` | 12-13px | 400 |
| Values (price, last) | Mono, bright | 12-13px | 400-500 |
| Chrome / status | Mono, muted | 11-12px | 400 |

**Mono everywhere.** A standard, readable mono (SF Mono, IBM Plex Mono, JetBrains Mono, Berkeley Mono) — not a bitmap/VT face unless the user wants the retro mode.

## Density

| Element | Pixel range |
|---|---|
| Table row | 22-26px |
| Panel header | 28-32px |
| Cell horizontal padding | 8-12px |
| Divider | 1px `--border` |
| Window top/bottom bar | 28-32px |

Dense and scannable, like `pro-terminal`. The tiling does the work; panes stay tight.

## Visual Rules (default / clean)

- **Ground:** near-black (dark) / warm paper (light). Not slate, not navy.
- **Muted text.** Primary is `#ccc`-grade, not stark white. Values and the active tab go bright. This muting is what reads as "terminal" rather than "web app on black."
- **Semantic color only.** Green/red for up/down and P&L; the phosphor hue (if not White) tints titles/accents. No decorative color.
- **Dividers, not boxes.** Separate panes with 1px `--border` lines and gaps. Do **not** wrap every pane in `┌─┐` ASCII art — the real look uses thin rules.
- **`::` panel titles**, title case: `:: World Indices`, `:: Breaking News`, `:: Prediction Markets`. Title in `--text-bright`, the `::` in `--text-secondary`.
- **Window chrome:** a top bar with macOS traffic-light dots + app title + a right-aligned market ticker; a bottom bar with workspace tabs (`^1 Default  ^2 Monitor`) and user/clock.
- **Status dots:** small filled circles (green/red/amber) as leading row indicators in tables.
- **Radius 0. No shadows. No gradients. No glow.** Motion near-instant.

## Optional retro (CRT) mode — off by default

Only when the user explicitly wants the vintage look:

- **Phosphor bloom:** `text-shadow: 0 0 4px currentColor` on bright values only. Switch the palette to Amber or Green.
- **Scanlines:** a fixed `repeating-linear-gradient(rgba(0,0,0,.14) 0 1px, transparent 1px 3px)` overlay, `pointer-events:none`, toggleable and gated behind `prefers-reduced-motion` if it flickers.
- **Block cursor:** blinking `█` at a command prompt (~530ms).

Treat these as a costume over the clean structure, never a replacement for it.

## retro-tui patterns

### Tiled panes (the signature)
- A grid of independent panes (2-3 columns), each a self-contained widget: indices table, watchlist, positions, news, chart, prediction markets, chat.
- Panes divided by hairline rules. Each has a `:: Title` header with a bottom divider.

### Tables with status dots
- Leading dot (green/red/amber) + symbol, then right-aligned `tabular-nums` columns. Selected/hovered row gets `--surface-hover`. Column headers dimmed uppercase.

### Tabbed data panel
- A single instrument pane with a tab strip (`Overview  Financials  Chart  Analyst  Events`); active tab in `--text-bright` with a 2px `--accent` underline.

### Window chrome
- Top: `● ● ●` dots · title · version pill · right-aligned `PRE-MKT · SPY +0.23% · VIX +2.8% · USD`.
- Bottom: `^1 Default  ^2 Monitor` workspace tabs left, `@user · 10:58 AM` right.

## Anti-Patterns

| Don't | Why |
|---|---|
| Add glow/scanlines by default | The real look is clean; CRT is opt-in |
| Wrap panes in `┌─┐` ASCII boxes | Use 1px dividers; boxes read as a toy |
| Stark pure-white body text | Muted `#ccc` is what reads as terminal |
| Slate/navy background | Must be near-black (or paper) |
| Multiple accent hues at once | One phosphor at a time; swappable ≠ simultaneous |
| Decorative color | Green/red mean up/down only |
| Sans-serif anywhere | Breaks the character grid |
| Emoji / colored icons | Use text glyphs (`▲▼●○`) |
| Rounded corners / shadows | Terminals have neither |

## Example: retro-tui tiled scene (clean White default)

```tsx
const T = { surf:"rgb(0,0,0)", txt:"rgb(204,204,204)", brt:"rgb(255,255,255)",
  dim:"rgb(136,136,136)", br:"rgb(51,51,51)", pos:"rgb(0,204,102)", neg:"rgb(255,51,51)" };

<div style={{ background:T.surf, color:T.txt, fontFamily:"'SF Mono',ui-monospace,monospace",
  fontSize:13, border:`1px solid ${T.br}`, fontVariantNumeric:"tabular-nums" }}>
  {/* window chrome */}
  <div style={{ display:"flex", alignItems:"center", gap:8, padding:"8px 12px", borderBottom:`1px solid ${T.br}` }}>
    <span style={{ display:"flex", gap:6 }}>
      {["#ff5f57","#febc2e","#28c840"].map(c => <i key={c} style={{ width:11, height:11, borderRadius:"50%", background:c }} />)}
    </span>
    <span style={{ color:T.brt, fontWeight:600, marginLeft:6 }}>Terminal</span>
    <span style={{ marginLeft:"auto", color:T.dim }}>PRE-MKT · SPY <span style={{color:T.pos}}>+0.23%</span> · USD</span>
  </div>
  {/* a pane */}
  <div>
    <div style={{ padding:"7px 12px", borderBottom:`1px solid ${T.br}`, color:T.dim }}>:: <span style={{ color:T.brt, fontWeight:600 }}>World Indices</span></div>
    <table style={{ width:"100%", borderCollapse:"collapse" }}>
      <tbody>
        <tr><td style={{ padding:"3px 12px" }}><span style={{ display:"inline-block", width:7, height:7, borderRadius:"50%", background:T.pos, marginRight:8 }} />SPX</td>
          <td style={{ padding:"3px 12px", color:T.dim }}>S&amp;P 500</td>
          <td style={{ padding:"3px 12px", textAlign:"right", color:T.brt }}>7,412.84</td>
          <td style={{ padding:"3px 12px", textAlign:"right", color:T.pos }}>+0.19%</td></tr>
      </tbody>
    </table>
  </div>
</div>
```

## Reference URLs

- Gloomberb — https://github.com/gloom-sh/gloomberb (screenshot: https://gloomberb.com/landing-terminal.png)
- lazygit — https://github.com/jesseduffield/lazygit
- k9s — https://github.com/derailed/k9s
- btop — https://github.com/aristocratos/btop
- cool-retro-term (CRT mode) — https://github.com/Swordfish90/cool-retro-term

## Verification

- [ ] Near-black ground; primary text muted (`#ccc`-grade), not stark white
- [ ] Green/red only on values and P&L; no decorative color
- [ ] Panes divided by 1px hairlines — no `┌─┐` ASCII boxes
- [ ] `:: Title` panel headers, title case, with a bottom divider
- [ ] Window chrome: traffic-light dots + title + right-aligned ticker; bottom workspace tabs + user/clock
- [ ] Mono everywhere, `tabular-nums` on all numbers, 0px radius
- [ ] Tables use leading status dots; active tab underlined in `--accent`
- [ ] Glow/scanlines are OFF unless the user asked for retro/CRT mode
- [ ] If a phosphor theme is used, text clears WCAG AA on surface and panel
- [ ] Rows 22-26px, panes tight

_Palette values adapted from the Gloomberb project (MIT, © 2026 Gloomberb Contributors)._
