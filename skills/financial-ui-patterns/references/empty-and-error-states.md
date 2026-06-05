# Empty and Error States

Trading UIs have specific empty/error categories with specific copy. Don't reach for marketing illustrations.

## Empty States

| Surface | Treatment | Copy pattern |
|---|---|---|
| No positions | One-line message + "Place your first trade" CTA | "No open positions." |
| No orders | One-line message, no CTA (orders come from elsewhere) | "No open orders." |
| No fills today | One-line, optionally "View history" link | "No fills today." |
| Empty watchlist | "Add symbol" CTA inline | "Add a symbol to track." |
| Filtered to nothing | "No matches for {filter}" + "Clear filter" | "No symbols match `XYZ`." |
| Gated (no permission, not enabled) | Explain why + how to unlock. No mock data | "Options trading isn't enabled on this account." |

Rules:
- No illustrations on empty trading surfaces. They read as "broken" or "marketing".
- Empty ≠ zero. Zero positions is `No open positions.` — never `$0.00 across 0 symbols`.
- One CTA max. Multiple choices read as "we don't know what to suggest".

## Error States

Pick the surface by blast radius:

| Error type | Surface | Example |
|---|---|---|
| Whole page can't load | Full-page error with retry | API down, auth expired |
| Section can't load | Inline panel error, rest of page works | Chart fails, table still shows |
| Single action failed | Toast (auto-dismiss 4-6s) + inline if persistent | Order rejected |
| Action will fail if submitted | Inline below field, red border, block submit | Insufficient funds |
| Network is degraded | Persistent banner at top, dismissible | High latency, partial feed |

## Trading-Specific Errors

| Error | Where to show | Required detail |
|---|---|---|
| Order rejected | Toast + order row turns red, status pill = `Rejected` | Reason code, raw broker message in expandable |
| Fill failed / partial | Order row + toast | Filled qty, remaining qty, reason |
| Insufficient funds | Inline on order form, block submit | Available balance, required balance |
| Market closed | Inline on order form | Next open time with timezone |
| Rate-limited | Toast + disable submit briefly | Retry-after seconds, NOT a generic "try again" |
| Stale quote (>N sec) | Tick cell goes amber, tooltip explains | Age in seconds, last update timestamp |
| Liquidation risk | Persistent banner, not dismissible | Margin used %, liquidation price |

## Copy Rules

- Never "Something went wrong." Always say what.
- Never "Please try again." Show the retry button or auto-retry.
- Include error code or correlation ID for support tickets.
- Don't apologize for system errors. State the fact. Pros want signal, not sympathy.

## Anti-Patterns

| Don't | Why |
|---|---|
| Marketing illustration on empty positions | Reads as broken |
| Toast for liquidation risk | Auto-dismiss = user misses it |
| Generic "Something went wrong" | No actionable info |
| Hide raw broker error | Pros want the truth, not a sanitized version |
| Block whole page for one failed widget | Cascading blanking destroys trust |
| Auto-retry without telling the user | Hidden retries mask real outages |
