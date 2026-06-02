# pro-terminal (stub)

**Reference products:** Bloomberg Terminal, Interactive Brokers TWS Desktop, ThinkOrSwim, TradeStation, eSignal, Reuters Eikon.

**One-line:** institutional desktop terminal. Black or near-black with amber or cyan accent. Mono-everywhere, ALL CAPS section labels. Max density. 0-2px radius. Hairline borders. Function-key shortcuts in tooltips.

## Distinguishing characteristics

- **Surfaces:** pure black `0 0 0` or very dark `8 8 8`. Cards are slightly elevated `16 16 16`.
- **Accent:** amber/orange `255 191 0` (Bloomberg signature) OR cyan `0 195 255` (IBKR/TWS variants).
- **Typography:** mono everywhere — body, labels, tables, prices. Sans only for occasional UI chrome (sparingly).
- **Section labels:** ALL CAPS, mono, accent-colored, often with bracket-style separators `[MARKETS]`.
- **Density:** maximum. 24-28px table rows. 11-12px body. 10-11px labels. As many data points per screen as possible.
- **Radius:** 0-2px. Sharp, terminal feel.
- **Borders:** solid hairlines everywhere, structural grid feel.
- **Function keys:** show F1-F12 shortcuts in tooltips and command palette. Bloomberg's signature: every action has a memorable shortcut.

## When to use

- Building internal tools at Massive that mimic Bloomberg's pro-trader audience
- Institutional desktop products
- Power-user terminals where density beats friendliness
- Any context where the user is paid to stare at screens 10+ hours/day

## When NOT to use

- Any consumer-facing product (reads as hostile/clinical)
- Marketing pages or onboarding
- Mobile (terminal aesthetic doesn't translate)

## Reference URLs

- Bloomberg Terminal — https://www.bloomberg.com/professional/products/bloomberg-terminal/ (study screenshots; live access requires subscription)
- IBKR TWS — https://www.interactivebrokers.com/en/trading/tws.php (desktop screenshots and the TWS web variant at https://www.interactivebrokers.com/portal/)
- ThinkOrSwim — https://www.schwab.com/trading/thinkorswim (screenshots from Schwab)
- Tastytrade (the pro-terminal-adjacent view, not their main consumer site)
- Reuters Eikon — https://www.refinitiv.com/en/products/eikon-trading-software

## Anti-patterns specific

- Don't use rounded corners (>4px)
- Don't use serifs anywhere
- Don't use generous whitespace (waste of screen real estate)
- Don't use drop shadows
- Don't auto-hide controls (terminal users want every control visible)
- Don't use sentence case for section labels

## Deep-fill triggers

Promote this from stub to deep when:
- Building actual Massive internal trading tools
- A client/employer needs Bloomberg-style replicas
- You've shipped 2+ projects in this aesthetic and want canonical patterns

For now, follow `modern-pro-dark` for the structure and override these specific things:
- Switch to mono-everywhere
- Switch accent to amber/cyan
- Tighten density (24-28px rows)
- Switch radius to 0-2px
- ALL CAPS section labels with mono + accent color
