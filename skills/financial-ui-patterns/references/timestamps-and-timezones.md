# Timestamps and Timezones

Traders need to know the exact moment a number was true, in the timezone they trade in. Never assume UTC, never hide the TZ.

## Display Rules

| Surface | Format | Example |
|---|---|---|
| Trade execution time | `HH:MM:SS.mmm TZ` (millisecond precision) | `14:32:07.421 ET` |
| Order timestamp | `HH:MM:SS TZ` | `14:32:07 ET` |
| Position open date | `YYYY-MM-DD` | `2026-03-15` |
| Last quote update | Relative under 60s, absolute after | `12s ago` then `14:32:07 ET` |
| Table-wide "as of" | Absolute + TZ + age pill | `14:32:07 ET · 3s ago` |
| Market hours strip | All relevant markets, current time each | `NYSE 14:32 · LSE 19:32 · TSE 04:32+1` |
| Chart axis | Localized short form | `Mar 15 14:30` |

## Timezone Handling

- **Always show TZ.** `14:32:07` with no zone is broken. Trader assumes it's wrong.
- **Default to user's market TZ**, not browser TZ. Equities trader → ET. Crypto trader → UTC or local. FX trader → local + counter-market.
- **Allow user override** in settings. Persist per device.
- **Multi-TZ status bar** (Pro Terminal pattern): show 3-4 timezones simultaneously in the bottom strip.
- **Show market open/close**, not just current time: `NYSE 14:32 (Open)`, `LSE 19:32 (Closed)`.

## Relative vs Absolute

| Context | Use |
|---|---|
| Streaming cell freshness | Relative (`3s ago`) — switches to absolute past 60s |
| Activity log row | Absolute (`14:32:07 ET`) |
| News headline | Relative (`12m ago`) |
| Position entry / exit | Absolute date + time |
| "Last updated" on a dashboard | Both: `14:32:07 ET · 3s ago` |

Rule: relative is fine for "recent". Absolute is required for "exact". When in doubt, show both.

## Millisecond Precision

| Show ms | Don't show ms |
|---|---|
| Trade prints / time-and-sales | Order book updates |
| Fill confirmations | Position list refresh |
| Latency / ping in status bar | Chart axis |

## Market Hours

- Pre-market and after-hours sessions need separate visual treatment (dim text, "EXT" badge).
- Holiday closures: render the next open as `Closed · Opens Mar 18 09:30 ET`.
- Crypto/FX: 24/5 or 24/7 — show "Always open" instead of session badges.

## Anti-Patterns

| Don't | Why |
|---|---|
| Bare `HH:MM:SS` with no TZ | Looks correct but ambiguous; trader assumes wrong |
| Browser TZ for a US equities UI | Trader in London sees `19:32` and is confused |
| Relative-only timestamps (`3m ago`) on fills | Fills need exact time for reconciliation |
| Millisecond precision on slow-update surfaces | Implies latency that isn't there |
| `Z` suffix for "UTC" without context | Most retail users don't know what `Z` means |
| Showing only one TZ when trader spans markets | Need at least home + market TZ |
| Mixing 12h and 24h within the same UI | Pick one and stick |
