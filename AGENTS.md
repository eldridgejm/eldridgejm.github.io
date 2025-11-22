# Repository Guide

This repo contains the static site for Justin Eldridge (UCSD). GitHub Actions builds the site automatically on push; locally, `make` runs the generator in `bin/mksite` to produce the `_build/` output. Dependencies are managed using Nix. To enter the Nix shell and build the site in one step, run:

```bash
nix develop -c make
```

## Layout
- `bin/mksite`: Python script that walks `pages/` and builds HTML into `_build/`. Markdown pages are rendered through `templates/template.html`; plain HTML pages are copied verbatim. The front page is generated from `frontpage.yaml` with `templates/front_template.html`.
- `pages/`: Content sources. `pages/faq/recrequest.md` is a Markdown FAQ. The legacy `pages/index.html` is ignored in favor of `frontpage.yaml`.
- `templates/`: TailwindCSS-based HTML templates (`template.html` and `front_template.html`) pulled from the CDN with Inter as the primary font. `template.html` is used for Markdown pages; `front_template.html` wraps the front-page body assembled from `frontpage.yaml` in the classic layout. Both templates link `static/style.css` for global overrides (including link styling).
- `static/`: CSS, images, PDFs for talks/dissertation. Copied into `_build/static/` during generation. `style.css` now carries global link styles.
- `_build/`: Generated output (not source of truth).

## Current behavior
- `bin/mksite` detects `.md` vs `.html` files in `pages/`. Markdown is converted via `markdown` library (with `nl2br`) and wrapped with `templates/template.html`; HTML files are copied unchanged. Paths to root are injected via `{{PATH_TO_ROOT}}`. The front page is rendered from YAML (`frontpage.yaml`) using `front_template.html` and Markdown for rich text in the classic layout.
- Styles use TailwindCSS from the CDN with global overrides in `static/style.css` (links, legacy spacing). No HTMX in use.
