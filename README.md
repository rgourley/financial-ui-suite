# financial-ui-suite

Production-grade financial UI design skills for Claude Code. Two composable layers — correctness and aesthetic personas — that capture how leaders like Bloomberg, TradingView, Kraken Pro, Coinbase Advanced, Robinhood, Financial Times, Polygon, and Wise actually build trading and finance UI.

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
│       ├── industry-patterns.md        Conventions from Bloomberg, Kraken, etc.
│       └── charts-and-candles.md       OHLC structure, volume, indicators (base)
└── financial-ui-personas/         Aesthetic layer (pick one)
    ├── SKILL.md
    └── references/
        ├── modern-pro-dark.md          TradingView, Kraken Pro, Hyperliquid    [DEEP]
        ├── editorial-financial.md      FT, Bloomberg.com, WSJ                  [DEEP]
        ├── api-dashboard.md            Polygon, Stripe, Vercel, Linear         [DEEP]
        ├── retail-polish-dark.md       Robinhood, Public                       [DEEP]
        ├── pro-terminal.md             Bloomberg Terminal, IBKR TWS            [stub]
        ├── tasty-pro.md                TastyTrade                              [stub]
        ├── crypto-exchange.md          Coinbase Advanced, Binance              [stub]
        ├── retail-polish-light.md      Wise, Revolut, Cash App                 [stub]
        ├── defi-native.md              Uniswap, Jupiter                        [stub]
        ├── apple-native.md             iOS Stocks                              [stub]
        └── charts-and-indicators.md    Per-persona chart treatments
```

## How it composes

```
product-design                  general atomic decisions for any SaaS UI
financial-ui-patterns           finance-specific correctness (mandatory)
financial-ui-personas           pick exactly one visual aesthetic
```

Use the patterns layer always. Pick one persona per product.

## What it prevents

Without the skill, agents shipping financial UI typically produce:
- Raw color values (`text-emerald-400`, `bg-zinc-950`) instead of semantic tokens
- Numbers without `tabular-nums` (digits jitter on update)
- Hard-coded dark theme that breaks light mode
- Broken Tailwind dynamic classes (`bg-${color}-500/10`)
- Missing tick-flash on streaming prices
- No staleness or connection state indicators
- Red/green-only signals (fails for color-blind users)
- `toFixed(2)` for all prices (breaks for BTC and SHIB simultaneously)
- Generic AI aesthetics that look the same as every other startup

The two skills capture the specific patterns Bloomberg, Kraken, TradingView, Coinbase, FT, Robinhood, and others actually ship.

## Install

```bash
# Add this plugin's marketplace
claude plugin marketplace add /path/to/financial-ui-suite

# Install the plugin
/plugin install financial-ui-suite@financial-ui-suite-dev
```

Once installed, the skills auto-load when Claude detects financial UI work — anything with prices, P&L, order books, tickers, holdings, charts, or streaming market data.

## Usage

After installing, no special invocation needed. Triggers:

- *"build a portfolio holdings table"* → loads `financial-ui-patterns`
- *"design an options chain in TradingView style"* → loads both skills + `modern-pro-dark` reference
- *"make it look like Bloomberg terminal"* → loads `pro-terminal` reference
- *"render an FT-style market wrap"* → loads `editorial-financial` reference

## Verification

Both skills built using TDD-for-documentation discipline (see `superpowers:writing-skills`). Each was tested against a baseline subagent (rendering without the skill) and verified against a second subagent (rendering with the skill loaded). Verified-distinct output across personas.

## Status

- Version 0.2.0 — all 10 personas fully fleshed out
- Each persona ships with complete CSS variable token set (dark + light), typography table, density numbers, visual rules, persona-specific patterns, anti-patterns, example component code, reference URLs, and per-persona verification checklist
- Cross-persona chart treatments documented in `references/charts-and-indicators.md`

## Trademark notice

Brand and product names referenced throughout this project (Bloomberg, TradingView, Kraken, Coinbase, Binance, Robinhood, Public, Financial Times, Wise, Revolut, Cash App, Polygon, Stripe, Vercel, Linear, TastyTrade, Uniswap, Apple, and others) are used for illustrative, descriptive, and educational purposes only — to ground each persona in a concrete reference. This project is not affiliated with, endorsed by, sponsored by, or in any way officially connected to any of those companies. All trademarks, service marks, and trade names are the property of their respective owners.

## License

MIT
