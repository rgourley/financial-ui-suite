# Alerts and Disclosures

Notifications that interrupt vs notifications that log. Disclosures the regulator (or the trader) needs to see at the right moment, not buried in settings.

## Notification Escalation

| Surface | Use for | Lifetime |
|---|---|---|
| Inline (cell, row, field) | State change visible in normal scan | Permanent |
| Toast (corner) | Action result the user just took | 4-6s auto-dismiss |
| Banner (top of page) | System-wide condition affecting the session | Until cleared or condition resolves |
| Modal | Block-on-action confirmation or critical warning | Until user dismisses |
| Push / OS notification | User is away from the tab | Until tapped or expired |

Rule: pick the lowest-friction surface that still gets seen. Modal is the last resort.

## Trading Notifications by Event

| Event | Surface | Reason |
|---|---|---|
| Order submitted | Inline (row appears) + toast | Confirmation without interruption |
| Order filled | Toast + persistent log | Important but not blocking |
| Order partial fill | Inline row update only | Don't fire 12 toasts on a slow fill |
| Order rejected | Toast + inline red row | Need both — toast may be missed |
| Price alert triggered | Toast + sound (opt-in) + push (if away) | User asked for this — make sure it lands |
| Margin call | Banner (persistent, undismissable until resolved) + push | Cannot be missed |
| Account locked / restricted | Banner + modal on next action | Blocks further trading |
| News alert (user-subscribed) | Toast + inbox log | Informational |
| Connection lost | Banner + dim data | Already covered in `streaming-and-state.md` |

## Price Alerts

- Create from chart (right-click → "Alert here") and from symbol page.
- Conditions: above/below price, % change from now, % change from open, volume spike.
- Manage in a single list view per account. Group by symbol.
- Triggered alerts persist in an "alerts inbox" until dismissed.
- Allow snooze (1h, until close, custom) without delete.

## Compliance Disclosures

Show the disclosure **at the moment of relevance**, not in a settings page. The required ones:

| Disclosure | When to surface |
|---|---|
| Pattern Day Trader (PDT) warning | When 4th day trade triggers within 5 sessions on a sub-$25k account |
| Wash sale notice | When selling a position at a loss with a recent repurchase |
| Options agreement | On first attempt to open an options-enabled view |
| Crypto risk disclosure | On first buy of any crypto, once per asset class |
| Restricted symbol | On any attempt to trade a halted, locked, or restricted symbol |
| Margin disclosure | On first margin order, and on margin balance change >threshold |
| Settlement reminder (T+1/T+2) | On first unsettled-funds reuse attempt |

Format:
- Inline panel above the action, not a modal, unless it requires acknowledgment.
- Required acknowledgment uses a checkbox + button, not just a button.
- Don't soften the wording. "You are about to make a day trade" beats "Note: this may count as a day trade".

## Anti-Patterns

| Don't | Why |
|---|---|
| Modal for every order confirmation | Modal fatigue; users click through without reading |
| Toast for margin call | Auto-dismiss = missed = catastrophe |
| Push notification with no opt-in | Spam; trader leaves |
| Bury PDT warning in settings | Regulatory requirement is "at the moment" |
| Banner that can't be dismissed for non-blocking conditions | Trader can't see data behind it |
| Stack 4+ toasts vertically | Reads as broken; queue and replace |
| Generic "Order processed" toast | State which order, which symbol, what side, what qty |
| Disclosure copy that hedges ("may", "could") | Required disclosures should be declarative |
