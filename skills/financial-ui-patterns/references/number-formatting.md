# Number Formatting

Specific rules for formatting financial numbers correctly. Reference when displaying any price, quantity, percentage, currency, or basis point.

## Prices

**Stocks (US equities):** 2 decimal places, always. `$182.43`. Penny stocks under $1 may use 4 dp (`$0.7321`).

**Crypto:** magnitude-aware. Anchor: minimum 2, maximum 8 fraction digits, but truncate trailing zeros for high-value tokens.

```ts
function formatCryptoPrice(price: number): string {
  if (price >= 1000) return price.toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  if (price >= 1) return price.toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 4 });
  if (price >= 0.01) return price.toFixed(4);
  if (price >= 0.0001) return price.toFixed(6);
  if (price >= 0.00000001) return price.toFixed(8);
  // Significant figures fallback for sub-satoshi values
  return price.toExponential(2);
}
```

**Forex / FX:** 4-5 decimal places. Major pairs: 4 dp (`1.0834`). JPY pairs: 3 dp (`148.521`). Crosses with stablecoins: 4-6 dp.

**Significant-figure pricing (Coinbase, CoinGecko pattern):** for tokens under $0.001, show 4 significant figures of the *fractional* part:

```ts
function formatSigFig(price: number, sigDigits = 4): string {
  if (price === 0) return "0.00";
  if (price >= 0.01) return price.toFixed(2);
  // Find first non-zero digit
  const exp = Math.floor(Math.log10(Math.abs(price)));
  const dp = Math.max(2, -exp + sigDigits - 1);
  return price.toFixed(dp);
}
// 0.00001234 → "0.00001234"
// 0.5678     → "0.57"
```

## Quantities / Sizes

**Stocks:** integer shares for retail (`1,247`). Fractional shares: 4 dp (`12.0834`).

**Crypto:** 4-8 dp depending on coin. BTC: 8 dp (`0.00123456`). ETH: 6 dp. Stablecoins: 2 dp.

**Always use `toLocaleString` for thousand separators:**
```ts
n.toLocaleString("en-US", { maximumFractionDigits: 4 })
// 1247.5 → "1,247.5"
```

**Negligible quantities:** show `< 0.0001` or scientific notation rather than rounding to 0. Rounding to 0 hides positions.

## Percentages

- 2 decimal places by default: `+2.34%`
- Always show sign: `+0.00%` for zero is acceptable; some teams prefer `0.00%`
- 1 decimal for daily moves in compact views: `+2.3%`
- 4 decimals for forex tick-level moves: `+0.0023%`

```ts
function formatPct(pct: number, dp = 2): string {
  const sign = pct >= 0 ? "+" : "";
  return `${sign}${pct.toFixed(dp)}%`;
}
```

## Basis Points

For yields, spreads, fees. 1 bp = 0.01%.

```ts
function formatBps(bps: number): string {
  if (Math.abs(bps) < 100) return `${bps.toFixed(1)} bps`;
  return `${(bps / 100).toFixed(2)}%`;
}
```

## Currency Amounts

**Always include currency symbol or code.** `$1,234.56` or `USD 1,234.56` or `1,234.56 USDC`.

```ts
function formatUSD(amount: number, opts: { compact?: boolean } = {}): string {
  if (opts.compact && Math.abs(amount) >= 10_000) {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
      notation: "compact",
      maximumFractionDigits: 2,
    }).format(amount);
  }
  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(amount);
}
// 1234.5  → "$1,234.50"
// 1_500_000 → "$1.5M" (compact)
```

**Compact notation rules:**
- **Use for:** market cap, 24h volume, total assets, AUM, supply
- **Never use for:** holdings value the user is about to trade, account balance, P&L
- **Threshold:** typically $10K+ for compact; below that show full

`1.2K`, `1.2M`, `1.2B`, `1.2T` — never `1.2k` (lowercase) which looks unprofessional.

## P&L

Cumulative and realized P&L always show:
- Sign prefix
- Currency
- Color (positive/negative)
- Two decimal places

```tsx
<span className={`tabular-nums font-medium ${value >= 0 ? "text-positive" : "text-negative"}`}>
  {value >= 0 ? "+" : "-"}${Math.abs(value).toLocaleString("en-US", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  })}
</span>
// +$1,234.56 (green)
// -$847.10  (red)
```

## Time

**Trade timestamps:** `HH:mm:ss` in market timezone (ET for US, UTC for crypto). Bloomberg uses 24h. Robinhood uses 12h with am/pm.

**Relative time for feeds:** `2m ago`, `47s ago`, `3h ago`. Switch to absolute after 24h.

```ts
function formatRelative(date: Date): string {
  const secs = (Date.now() - date.getTime()) / 1000;
  if (secs < 60) return `${Math.floor(secs)}s ago`;
  if (secs < 3600) return `${Math.floor(secs / 60)}m ago`;
  if (secs < 86400) return `${Math.floor(secs / 3600)}h ago`;
  return date.toLocaleDateString("en-US", { month: "short", day: "numeric" });
}
```

**Market hours indicator:**
- `09:30 - 16:00 ET` for regular hours
- `Pre-market` / `After-hours` for extended sessions
- `Closed` with next-open countdown when relevant

## Numeric Display Anti-Patterns

| Anti-pattern | Why | Fix |
|---|---|---|
| `${price.toFixed(2)}` for crypto | Breaks for BTC ($100,000) and SHIB ($0.00001) | Magnitude-aware formatter |
| `1.2k` lowercase | Unprofessional, inconsistent with Bloomberg/Reuters | `1.2K` uppercase |
| Rounding tiny holdings to `0` | Hides positions, looks like data loss | Show `< 0.0001` or scientific |
| `0%` for unchanged | Ambiguous (no data? actually flat?) | `0.00%` or `—` for no-data |
| Mixing `.` and `,` decimal separators | Locale bugs | Lock to `en-US` for financial apps unless localizing |
| No thousand separators | `12345678` is unreadable | Always `toLocaleString` |
| Compact notation on user balance | "$1.2K" hides cents user cares about | Compact only for stats, not balances |
| Truncating not rounding | `0.999 → 0.99` mis-represents | Use `toFixed` (rounds) or explicit `Math.round` |
