# api-dashboard

**Reference products:** Massive (Polygon.io) dashboard, Stripe dashboard, Vercel dashboard, Linear, PlanetScale, Resend, Supabase dashboard, Modal, Render.

**One-line:** developer-friendly dashboard aesthetic. Near-black or near-white background, mono-heavy for code/IDs/keys, status pills used aggressively, generous form fields, documentation-adjacent feel.

## Token Set

```css
/* DARK (default for developer products) */
:root[data-theme="dark"] {
  /* Surfaces */
  --surface:           10 10 11;       /* near-black, slight warmth */
  --surface-elevated:  17 17 18;
  --surface-panel:     27 27 29;
  --surface-hover:     38 38 41;

  /* Text */
  --text-primary:   239 239 240;
  --text-secondary: 170 170 175;
  --text-muted:     115 115 120;

  /* Signal */
  --positive: 56 161 105;
  --negative: 226 73 90;
  --warning:  217 158 35;
  --info:     59 130 246;

  /* Brand accent — pick ONE from the style's reference products */
  --accent:   132 71 226;              /* Stripe-style purple, or use brand */

  --border:   255 255 255;
  --radius-md: 0.375rem;
  --radius-lg: 0.5rem;
}

/* LIGHT */
:root[data-theme="light"] {
  --surface:           253 253 253;
  --surface-elevated:  248 248 249;
  --surface-panel:     242 242 244;
  --surface-hover:     235 235 237;
  --text-primary:      20 20 22;
  --text-secondary:    80 80 88;
  --text-muted:        140 140 150;
  --positive: 22 122 64;
  --negative: 200 30 40;
  --accent:   132 71 226;
  --border:   0 0 0;
}
```

**Style-specific accent picks:**
- Stripe-flavored: `132 71 226` (purple)
- Vercel-flavored: monochrome (use `255 255 255` accent, prove yourself with type/space alone)
- Linear-flavored: `94 106 210` (indigo-purple)
- Massive brand-flavored: `0 143 250` (blue)
- Supabase-flavored: `62 207 142` (green)

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| H1 page title | Sans (Inter, Geist) | 24-30px | 600 |
| H2 section | Sans | 18-20px | 600 |
| Body | Sans | 14-15px | 400-500 |
| Form labels | Sans | 13px | 500 |
| Field input | Sans | 14px | 400 |
| Table cells | Sans + `tabular-nums` | 13-14px | 400 |
| Code blocks / API keys / IDs | Mono (JetBrains Mono, GeistMono) | 13px | 400 |
| Section labels | Sans uppercase, `tracking-wider` | 11px | 500 |
| Numbers (usage, billing) | Sans + `tabular-nums` | 14-32px | 500-600 |

Mono is heavy here — every API key, request ID, transaction ID, customer ID, webhook URL, JSON snippet is rendered in mono.

## Density

| Element | Pixel range |
|---|---|
| Table row | 40-48px (more relaxed than trading UIs) |
| Card padding | 20-28px |
| Form field height | 36-40px |
| Section gap | 32-48px |
| Sidebar nav item | 32-36px |
| Page padding | 24-40px |

API dashboards prioritize legibility over density. Devs spend hours reading docs and copying values.

## Visual Rules

- **Borders:** hairline `border-border/10` for structure, slightly heavier `border-border/15` for cards
- **Radius:** 6-8px on cards, 6px on buttons, 4-6px on inputs, 4px on inline code/badges
- **Shadows:** subtle. Cards can use `0 1px 2px rgba(0,0,0,0.04)` in light mode. Dark mode: skip shadows, use elevation.
- **Hover:** background change to `surface-hover/60` at 120ms
- **Focus:** visible 2px accent ring + 4px low-opacity halo (devs use keyboard heavily)
- **Code blocks:** distinct background `surface-panel`, mono, 12-13px, with inline syntax highlight
- **Inline code:** `bg-surface-panel`, `text-text-primary`, `font-mono`, `text-xs`, `px-1.5 py-0.5 rounded`
- **Copy-to-clipboard button:** present on every code block, API key, transaction ID

## Components

### Sidebar nav
- Fixed-width left sidebar (200-280px)
- Icon + label, 13-14px, sans
- Active state: accent-colored left border (2-3px) + slight bg tint
- Collapsible sections
- Workspace switcher at top

### Header bar
- Breadcrumbs (Stripe pattern) showing path
- Search (cmd+K)
- Account avatar / workspace
- Notification bell

### Data table
- 40-48px rows
- Mono for IDs (`cus_abc123`, `pi_xyz789`)
- Sans + tabular for amounts
- Status pill column always present
- Last column: ellipsis menu for actions
- Sticky header, sortable columns
- Filter chips above table

### Code block
```tsx
<pre className="rounded-lg bg-surface-panel border border-border/10 p-4 text-xs font-mono overflow-x-auto">
  <code>{snippet}</code>
  <button className="absolute top-2 right-2 text-text-muted hover:text-text-primary">
    {copied ? "Copied" : "Copy"}
  </button>
</pre>
```

### API key display
- Masked by default (`sk_test_•••••••••••••••••••••••••••`)
- "Reveal" button
- "Copy" button
- Created/last-used timestamps
- Mono throughout

### Status pill (heavy use)
- Used for: API call status (200/4xx/5xx), payment status (succeeded/pending/failed), webhook delivery, deployment status, build status
- 11px text, colored bg + text + border at 15% opacity, 4px radius
- Status dot to the left

### Stat tiles
- Hero number large (24-32px) + sparkline + context label
- Used for: monthly usage, MRR, active customers, API calls today
- Distinct from "trading hero numbers" (those are bigger and centered)

### Forms
- Generous height (36-40px field)
- Label above field (sans, 13px, weight 500)
- Helper text below in muted
- Inline validation (red text below field for errors)
- Submit button right-aligned

## Anti-Patterns (API Dashboard specific)

| Don't | Why |
|---|---|
| Hide API keys without a reveal pattern | Devs need to copy them; full mask breaks workflow |
| Skip the copy-to-clipboard button | Devs constantly copy IDs and snippets |
| Use sans for IDs and keys | Mono is required; sans IDs are unreadable |
| Use cramped form fields (<32px) | Devs type a lot; small fields hurt |
| Use only color for status | Always pair with text label in pill |
| Skip search/cmd+K | Devs expect keyboard-first navigation |
| Use heavy table density (24-28px rows) | API dashboards aren't trading UIs; relax to 40+ |
| Hide code block syntax highlighting | Devs read code; highlight improves scan speed |

## Example: API Dashboard transactions table row

```tsx
<tr className="border-t border-border/10 hover:bg-surface-hover/40 transition-colors">
  <td className="px-4 py-3">
    <span className="font-mono text-xs text-text-secondary">cus_NffrFeUfNV2Hib</span>
  </td>
  <td className="px-4 py-3">
    <div className="font-medium text-text-primary text-sm">Acme Corp</div>
    <div className="font-mono text-xs text-text-muted">acme@example.com</div>
  </td>
  <td className="px-4 py-3 text-right tabular-nums font-medium">$2,450.00</td>
  <td className="px-4 py-3">
    <span className="inline-flex items-center gap-1.5 px-1.5 py-0.5 rounded text-[11px] font-medium border bg-positive/15 text-positive border-positive/30">
      <span aria-hidden className="size-1.5 rounded-full bg-current" />
      Succeeded
    </span>
  </td>
  <td className="px-4 py-3 text-xs text-text-muted">
    <time className="font-mono">Jun 1, 4:02 PM</time>
  </td>
</tr>
```

## Reference URLs

- Stripe — https://dashboard.stripe.com (the gold standard; study payments table, customer detail, API logs)
- Vercel — https://vercel.com/dashboard (monochrome aesthetic, study project list, deployments)
- Linear — https://linear.app (issue tracker but style-defining for dev tools)
- Polygon.io / Massive.com — https://polygon.io/dashboard (financial-API-product reference)
- Supabase — https://supabase.com/dashboard (project + table editor patterns)
- PlanetScale — https://app.planetscale.com (db dashboard reference)
- Resend — https://resend.com (email API dashboard, modern reference)
- Modal — https://modal.com (serverless dashboard)

## Verification (API Dashboard specific)

- [ ] Background is near-black (#0A0A0B) or near-white (#FDFDFD), not pure
- [ ] Single brand accent color used consistently
- [ ] All IDs, API keys, transaction refs, URLs are mono
- [ ] Code blocks have copy-to-clipboard
- [ ] API keys masked by default with reveal pattern
- [ ] Status pills used on every state field, color + label
- [ ] Cmd+K / search keyboard shortcut works
- [ ] Form fields 36-40px tall
- [ ] Table rows 40-48px tall
- [ ] Focus ring visible and high-contrast (devs use keyboard)
- [ ] No raw color values — semantic tokens only
- [ ] Light + dark themes both render
