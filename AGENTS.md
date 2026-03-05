# CLAUDE.md

## Overview

CV/resume built with [Typst](https://typst.app/), using Nix flakes for reproducible builds via [Typix](https://github.com/loqusion/typix).

## Build Commands

All commands require the Nix flake devshell (activated automatically via direnv):

- **Watch mode:** `nix run` or `nix run .#watch`
- **One-time build:** `nix run .#build` → outputs `main.pdf`

**Do not run `typst` directly** — use Nix commands to ensure fonts and packages are available.

## Project Structure

- `main.typ` — CV source (content + template)
- `flake.nix` — fonts, packages, build scripts
- `assets/` — logos and images
- `evaluations/` — cv-eval output files
- `docs/` — writing standards and template reference

## References

@docs/cv-writing.md
@docs/typst.md
