# defi-native

**Reference products:** Uniswap, Jupiter (Solana), Aave, Curve, Raydium, Phantom Wallet, Rabby, Rainbow Wallet, GMX, dYdX, Hyperliquid.

**One-line:** gradients, glassy panels with backdrop-blur, saturated brand palette, playful and product-led. Less institutional than crypto-exchange, more on-chain-first. Often light or hybrid theme.

## Token Set

```css
:root[data-theme="dark"] {
  --surface:           15 16 24;        /* deep purple-tinted near-black */
  --surface-elevated:  255 255 255 / 0.04;
  --surface-panel:     255 255 255 / 0.06;
  --surface-hover:     255 255 255 / 0.08;

  --glass-bg:    255 255 255 / 0.05;
  --glass-blur:  blur(20px);

  --text-primary:   245 246 250;
  --text-secondary: 188 192 215;
  --text-muted:     130 135 158;

  /* Saturated brand palette — pick one identity per product */
  --brand:        255 0 122;            /* Uniswap pink-magenta */
  --brand-soft:   255 0 122 / 0.18;
  --brand-glow:   255 0 122 / 0.35;
  /* Alternatives:
     --brand: 168 85 247;                Solana purple
     --brand: 20 219 184;                Solana teal alt
     --brand: 184 109 247;               Aave purple
     --brand: 14 203 129;                Phantom green
     --brand: 255 122 0;                 Bitcoin orange
  */

  --accent: 255 0 122;
  --positive: 0 230 130;
  --negative: 255 70 100;

  --border: 255 255 255;
  --radius-md: 0.75rem;
  --radius-lg: 1.5rem;
  --radius-pill: 999px;
}

:root[data-theme="light"] {
  --surface:           250 250 252;
  --surface-elevated:  255 255 255 / 0.7;
  --surface-panel:     255 255 255 / 0.85;
  --text-primary:      20 22 32;
  --text-secondary:    80 85 110;
  --text-muted:        130 135 158;
  --brand: 255 0 122;
  --positive: 0 178 100;
  --negative: 220 50 70;
}
```

## Background treatment

DeFi apps frequently use a **page-level radial gradient or animated mesh** as background. Examples:

```css
body {
  background: radial-gradient(ellipse at top, rgba(255, 0, 122, 0.15), transparent 70%),
              radial-gradient(ellipse at bottom right, rgba(168, 85, 247, 0.12), transparent 60%),
              rgb(15, 16, 24);
}
```

## Typography

| Element | Font | Size | Weight |
|---|---|---|---|
| Hero swap title | Sans (Inter, IBM Plex Sans, Manrope) | 22-28px | 700 |
| Display number (swap amounts) | Sans + `tabular-nums` | 28-44px | 600 |
| Body | Sans | 14-16px | 400-500 |
| Token symbol | Sans | 14-16px | 600 |
| Wallet address | Mono (truncated `0x1234...abcd`) | 12-13px | 500 |
| Transaction hash | Mono | 11-12px | 400 |
| Section labels | Sans, sometimes UPPERCASE | 11-13px | 500-600 |

Mono is used **only** for wallet addresses, transaction hashes, contract addresses. Token amounts and prices use sans + tabular.

## Density

| Element | Pixel range |
|---|---|
| Swap card padding | 24-32px |
| Token list row | 56-72px |
| Card radii | 16-24px |
| Field height (token input) | 60-80px (large for amount entry) |

Less dense than crypto-exchange because DeFi is **single-action focused** (one swap, one stake, one borrow) rather than continuous monitoring.

## Visual Rules

- **Borders:** mostly absent, replaced by translucent backgrounds (glass)
- **Radius:** 12-24px on cards, 999px (pill) on buttons and inputs
- **Shadows:** soft glows in brand color, especially on focus/hover
- **Gradients:** **encouraged**:
  - Page background (radial mesh)
  - Token icons (often brand gradient)
  - Active button states (gradient fill)
  - Hero text fills (gradient text)
- **Glass panels:** `bg-white/5` + `backdrop-blur-xl` is signature
- **Hover:** glow effect in brand color, slight scale (1.01)
- **Active:** brief brand-color flash

## Persona-Specific Patterns

### Connect Wallet button
- Always top-right, prominent
- Pre-connect: limited UI (or onboarding takes over)
- Post-connect: shows truncated address `0x1234...abcd` + balance
- Click to open wallet drawer

### Wallet drawer
- Right-side slide-out
- Account info, network, balance per chain
- Disconnect / switch wallet
- Transaction history

### Token swap card
- Two-token input format (FROM / TO)
- Reverse-arrow button between
- Each input: token selector dropdown + amount input
- Below: estimated rate, slippage, gas, route
- Bottom: large Swap button (full-width, brand gradient)
- Real-time price quote updates

### Token selector
- Modal or drawer with search
- Common tokens pinned at top
- Search by name, symbol, or contract address
- Verified badge for known tokens
- Custom token import flow

### Gas estimator
- Show estimated gas in USD AND native currency
- Format: `~$2.14 in gas (0.0008 ETH)`
- Update live as gas prices change
- Speed selector: Slow / Average / Fast

### Slippage tolerance
- Settings gear opens slippage modal
- Presets: 0.1% / 0.5% / 1% / Custom
- Warning if user sets above 5%
- Auto-default 0.5% for most swaps

### Chain switcher
- Always visible, shows current network
- Click opens chain list (Ethereum, Solana, Base, Arbitrum, Optimism, etc.)
- Mismatch warnings: "Switch to Ethereum to use this app"

### Address display
- Truncated mono: `0x1234...abcd`
- Click to copy
- Hover shows full address
- ENS support: shows `vitalik.eth` instead of raw 0x when available

### TVL / APY displays
- Lending/staking products show TVL prominently
- APY format: `12.4% APY` with hover for breakdown
- APY can include gradient or animation

## Anti-Patterns (DeFi Native specific)

| Don't | Why |
|---|---|
| Use institutional/Pro-Terminal aesthetic | Persona is playful, product-led |
| Use solid opaque cards exclusively | Glass effects are signature |
| Hide gas costs pre-transaction | Must be visible; users hate gas surprises |
| Hide chain/network indicator | Multi-chain awareness is critical |
| Use serif anywhere | DeFi is digital-native |
| Ship without wallet-connect prominence | Web3 onboarding standard |
| Use full wallet address inline | Always truncated, mono |
| Use generic Buy/Sell buttons | Web3 uses "Swap" / "Stake" / "Lend" / "Borrow" |
| Skip transaction status feedback | Must show pending/confirmed/failed clearly |

## Example: swap card

```tsx
<div className="rounded-3xl p-6 backdrop-blur-xl border border-white/10" style={{ background: "rgba(255,255,255,0.04)" }}>
  <div className="flex justify-between items-center mb-4">
    <h2 className="text-xl font-bold text-text-primary">Swap</h2>
    <button className="size-9 rounded-full bg-white/5 flex items-center justify-center text-text-secondary">
      ⚙
    </button>
  </div>

  {/* FROM input */}
  <div className="bg-white/5 rounded-2xl p-4 mb-1">
    <div className="text-xs text-text-muted mb-2">You pay</div>
    <div className="flex items-center justify-between gap-3">
      <input
        type="text"
        defaultValue="1.0"
        className="flex-1 bg-transparent text-3xl font-semibold tabular-nums text-text-primary outline-none"
      />
      <button className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-white/10 hover:bg-white/15">
        <div className="size-7 rounded-full bg-gradient-to-br from-[#627EEA] to-[#3C5FC8]" />
        <span className="font-semibold text-text-primary">ETH</span>
        <span className="text-text-muted">▼</span>
      </button>
    </div>
    <div className="text-xs text-text-muted mt-2">≈ $3,247.18</div>
  </div>

  {/* Reverse */}
  <div className="flex justify-center -my-3 relative z-10">
    <button className="size-9 rounded-xl bg-[rgb(15,16,24)] border-4 border-[rgb(15,16,24)] flex items-center justify-center hover:bg-white/5">
      ↓
    </button>
  </div>

  {/* TO input */}
  <div className="bg-white/5 rounded-2xl p-4 mt-1">
    <div className="text-xs text-text-muted mb-2">You receive</div>
    <div className="flex items-center justify-between gap-3">
      <div className="flex-1 text-3xl font-semibold tabular-nums text-text-primary">3,247.18</div>
      <button className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-white/10 hover:bg-white/15">
        <div className="size-7 rounded-full bg-gradient-to-br from-[#2775CA] to-[#1E5EA8]" />
        <span className="font-semibold text-text-primary">USDC</span>
        <span className="text-text-muted">▼</span>
      </button>
    </div>
    <div className="text-xs text-text-muted mt-2">≈ $3,247.18</div>
  </div>

  {/* Rate + slippage + gas */}
  <div className="mt-3 px-3 py-2.5 bg-white/[0.03] rounded-xl text-xs text-text-muted">
    <div className="flex justify-between"><span>Rate</span><span className="text-text-secondary tabular-nums">1 ETH = 3,247.18 USDC</span></div>
    <div className="flex justify-between"><span>Network fee</span><span className="text-text-secondary tabular-nums">~$2.14</span></div>
    <div className="flex justify-between"><span>Slippage</span><span className="text-text-secondary">0.5%</span></div>
  </div>

  {/* Swap button */}
  <button className="mt-4 w-full py-4 rounded-2xl font-bold text-base text-white" style={{ background: "linear-gradient(135deg, rgb(255,0,122), rgb(168,85,247))" }}>
    Swap
  </button>
</div>
```

## Reference URLs

- Uniswap — https://app.uniswap.org
- Jupiter — https://jup.ag
- Aave — https://app.aave.com
- Curve — https://curve.fi
- Raydium — https://raydium.io
- Phantom Wallet — https://phantom.com
- Rabby Wallet — https://rabby.io
- Rainbow Wallet — https://rainbow.me
- GMX — https://app.gmx.io
- Hyperliquid — https://app.hyperliquid.xyz

## Verification (DeFi Native specific)

- [ ] Page background uses radial gradient or mesh in brand color
- [ ] Saturated brand color is the visual identity
- [ ] Glassy panels (`bg-white/5` + `backdrop-blur-xl`) used for cards
- [ ] Connect Wallet button prominent (top-right)
- [ ] Wallet addresses truncated and mono (`0x1234...abcd`)
- [ ] Swap card uses two-input + reverse button pattern
- [ ] Gas costs visible BEFORE transaction (in USD and native)
- [ ] Slippage tolerance accessible and editable
- [ ] Chain switcher visible
- [ ] Token icons use brand gradient circles
- [ ] Primary action button uses brand gradient fill
- [ ] Radii are 16-24px on cards, pill on buttons
- [ ] No serif fonts
- [ ] Verified-token badges on token list entries
