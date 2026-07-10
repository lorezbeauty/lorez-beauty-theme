# AGENTS.md

## Cursor Cloud specific instructions

This repository is the **Shopify Online Store 2.0 theme** for **Lorez Beauty**
(store `ibrcsh-ir`). It is plain Liquid/JSON/CSS/JS synced to/from Shopify via
the GitHub theme integration (commits titled "Update from Shopify for theme
lorez-beauty-theme/main"). There is **no Node build step and no `package.json`**
— the `dev = "npm run dev"` line in `shopify.app.toml` is a stray/unused entry;
do not rely on it.

### Tooling

- The dev tool is the **Shopify CLI** (`shopify`), installed globally by the
  update script. Verify with `shopify version`.
- The PowerShell scripts in `scripts/` (`*.ps1`) talk to the Shopify **Admin
  API** and require `SHOPIFY_STORE` + `SHOPIFY_ADMIN_TOKEN` env vars. They are
  operational helpers, not part of the local run/build loop.

### Lint

- Run from the repo root: `shopify theme check`
- This works fully offline (no store auth needed) and inspects all theme files.
- Note: the theme currently reports a **pre-existing baseline** of offenses
  (~5 errors, ~28 warnings, e.g. `UnusedAssign`, `AppBlockValidTags` in
  `templates/policy.liquid`). These exist on `main` and are **not** introduced
  by your changes — only worry about *new* offenses you add.

### Run (local dev server)

- The real dev server is `shopify theme dev --store ibrcsh-ir.myshopify.com`.
  It renders the live store's Liquid + data with hot reload.
- **It requires authentication.** Interactively it opens a device-code login
  (blocks headless). To run non-interactively, provide a **Theme Access token**
  (from the "Theme Access" app in Shopify admin) and run:
  `SHOPIFY_CLI_THEME_TOKEN=<token> shopify theme dev --store ibrcsh-ir.myshopify.com`
  In this cloud VM no store credentials are configured, so `theme dev` cannot
  reach the store without that secret.

### Run/preview WITHOUT store credentials

- The repo ships a **self-contained static storefront preview** at
  `preview.html` (+ `preview.css`). Serve it to visually verify the storefront
  design renders, with no Shopify auth:
  `python3 -m http.server 8123` (from repo root), then open
  `http://localhost:8123/preview.html`.
- Note `preview.html` uses its own inline styles; it does **not** load the
  theme's `assets/base.css` / `assets/theme.js`. It is a design mockup, not the
  Liquid theme itself.

### Build

- There is no build/compile step for a Shopify theme. "Deploying" means
  `shopify theme push` (needs store auth) or letting the GitHub↔Shopify
  integration sync `main`.
