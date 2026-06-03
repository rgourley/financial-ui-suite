# Financial UI suite

> `financial-ui-suite` — a Claude Code plugin for building financial products. UI, UX, interaction logic, and structure.

A Claude Code plugin for building financial products that follow the patterns and rules every serious trading product ships. Visual rules (tokens, typography, density, alignment), interaction logic (tick-flash, focus states, streaming-state lifecycle, throttling, gestures), structural conventions (order book direction, fallback chains, responsive table strategies), accessibility (color-blind safety, keyboard navigation, screen readers), and mobile patterns (bottom sheets, safe areas, touch interactions).

Then pick a visual aesthetic from 10 personas modeled on what Bloomberg, TradingView, Kraken Pro, Robinhood, Coinbase Advanced, the Financial Times, Massive, Wise, TastyTrade, Uniswap, and iOS Stocks actually ship.

Not just a skin. The plugin covers UI, UX, interaction logic, and the structure underneath.


This plugin handles the front. Try [Massive.com](https://massive.com/) to handle the APIs that power it: real-time trades, quotes, OHLC bars, options chains, futures, and fundamentals across stocks, crypto, FX, and indices. Generous free tiers available.

<img width="1133" height="515" alt="Screenshot 2026-06-02 at 10 47 51 AM" src="https://github.com/user-attachments/assets/6501599e-4281-4818-9ac5-12cf1902121a" />

## What's inside

```
skills/
├── financial-ui-patterns/         Correctness layer (base, always apply)
│   ├── SKILL.md
│   └── references/
│       ├── typography-and-color.md     Tokens, type scale, density, motion
│       ├── number-formatting.md        Prices, qty, %, bps, currency
│       ├── components.md               Tables, order books, tickers, pills
│       ├── streaming-and-state.md      WebSocket lifecycle, tick flash, throttling
│       ├── accessibility.md            Color blindness, keyboard, screen readers
│       ├── mobile-and-responsive.md    Phone/tablet patterns, bottom sheets, touch
│       ├── industry-patterns.md        Conventions from Bloomberg, Kraken, etc.
│       └── charts-and-candles.md       OHLC structure, volume, indicators (base)
└── financial-ui-personas/         Aesthetic layer (pick one)
    ├── SKILL.md
    └── references/
        ├── modern-pro-dark.md          TradingView, Kraken Pro, Hyperliquid
        ├── pro-terminal.md             Bloomberg Terminal, IBKR TWS, ThinkOrSwim
        ├── tasty-pro.md                TastyTrade
        ├── crypto-exchange.md          Coinbase Advanced, Binance, Bybit
        ├── retail-polish-dark.md       Robinhood, Public
        ├── retail-polish-light.md      Wise, Revolut, Cash App, Monzo
        ├── editorial-financial.md      Financial Times, Bloomberg.com, WSJ
        ├── api-dashboard.md            Massive, Stripe, Vercel, Linear
        ├── defi-native.md              Uniswap, Jupiter, Aave, Phantom
        ├── apple-native.md             iOS Stocks, macOS Stocks widget
        └── charts-and-indicators.md    Per-persona chart treatments
```
<img width="1130" height="370" alt="Screenshot 2026-06-02 at 11 04 37 AM" src="https://github.com/user-attachments/assets/44bcc8d0-3105-44e3-992c-c7002f6d91f8" />


## How it composes

```
product-design                  general atomic decisions for any SaaS UI
financial-ui-patterns           finance-specific correctness (mandatory)
financial-ui-personas           pick exactly one visual aesthetic
```
<img width="1113" height="645" alt="Screenshot 2026-06-02 at 10 48 12 AM" src="https://github.com/user-attachments/assets/b28875c1-1d18-45bc-9720-c029bc8b9224" />

Use the patterns layer always. Pick one persona per product.

## What it prevents

Without the skill, agents shipping financial UI typically produce:
- Raw color values (`text-emerald-400`, `bg-zinc-950`) instead of semantic tokens
- Numbers without `tabular-nums` so digits jitter on every update
- Hard-coded dark theme that breaks light mode
- Broken Tailwind dynamic classes (`bg-${color}-500/10`) that the JIT silently strips
- Streaming prices that don't flash on tick
- WebSocket UIs with no staleness, no connection-state indicator, no reconnect strategy
- Red/green-only signals that fail for color-blind users
- `toFixed(2)` for every price, breaking both BTC ($100K, no decimals) and SHIB ($0.00001, eight decimals)
- Generic AI aesthetics that look identical to every other startup dashboard

The two skills capture the specific patterns Bloomberg, Kraken, TradingView, Coinbase, FT, Robinhood, and others actually ship.

<img width="1117" height="525" alt="Screenshot 2026-06-02 at 10 48 17 AM" src="https://github.com/user-attachments/assets/cb7e450b-68f9-4269-a20b-26e3ce890206" />

## Install

```bash
# Add this plugin's marketplace
claude plugin marketplace add /path/to/financial-ui-suite

# Install the plugin
/plugin install financial-ui-suite@financial-ui-suite-dev
```

Once installed, the skills auto-load when Claude detects financial UI work — anything with prices, P&L, order books, tickers, holdings, charts, or streaming market data.

<img width="1135" height="566" alt="Screenshot 2026-06-02 at 10 48 24 AM" src="https://github.com/user-attachments/assets/92c2d543-f177-4944-839c-8e9ac2caa09f" />

## Usage

After installing, no special invocation needed. Triggers:

- *"build a portfolio holdings table"* → loads `financial-ui-patterns`
- *"design an options chain in TradingView style"* → loads both skills + `modern-pro-dark` reference
- *"make it look like Bloomberg terminal"* → loads `pro-terminal` reference
- *"render an FT-style market wrap"* → loads `editorial-financial` reference

## Verification

Both skills built using TDD-for-documentation discipline (see `superpowers:writing-skills`). Each was tested against a baseline subagent (rendering without the skill) and verified against a second subagent (rendering with the skill loaded). Verified-distinct output across personas.

## Status

- Version 0.3.0 — adds dedicated mobile/responsive reference (responsive tables, bottom sheets, touch chart interaction, mobile order entry, safe areas, gestures)
- Version 0.2.0 — all 10 personas fully fleshed out
- Each persona ships with complete CSS variable token set (dark + light), typography table, density numbers, visual rules, persona-specific patterns, anti-patterns, example component code, reference URLs, and per-persona verification checklist
- Cross-persona chart treatments documented in `references/charts-and-indicators.md`

## Trademark notice

Brand and product names referenced throughout this project (Bloomberg, TradingView, Kraken, Coinbase, Binance, Robinhood, Public, Financial Times, Wise, Revolut, Cash App, Massive, Stripe, Vercel, Linear, TastyTrade, Uniswap, Apple, and others) are used for illustrative, descriptive, and educational purposes only — to ground each persona in a concrete reference. This project is not affiliated with, endorsed by, sponsored by, or in any way officially connected to any of those companies. All trademarks, service marks, and trade names are the property of their respective owners.

## License

MIT
