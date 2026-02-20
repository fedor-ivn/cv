# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a CV/resume project built with [Typst](https://typst.app/), using Nix flakes for reproducible builds via [Typix](https://github.com/loqusion/typix).

## Build Commands

All commands require the Nix flake devshell (activated automatically via direnv with `.envrc`):

- **Watch mode (auto-rebuild on changes):** `nix run` or `nix run .#watch`
- **One-time build:** `nix run .#build` (outputs `main.pdf` to current directory)
- **Enter dev shell:** `nix develop`

**Important:** Do not run `typst` directly. Use the Nix commands above to ensure fonts and packages are properly available.

## Project Structure

- `main.typ` - Main Typst source file containing the resume content and custom template
- `flake.nix` - Nix flake configuration (fonts, Typst packages, build scripts)
- `profile.jpeg` - Profile photo
- `logos/` - Company/institution logos used in the resume

## Typst Packages Used

- `modern-cv` - Base CV template
- `fontawesome` - Icons for contact info
- `cetz` - Drawing library
- `linguify` - Internationalization support

## Key Customizations in main.typ

The file defines a custom `resume` function that extends `modern-cv` with additional features like configurable profile pictures and custom styling. It also defines `resume-entry-with-logo` for work entries with company logos.

## Vertical Spacing Guidelines

### Fixed Spacing Scale

Use only these values for vertical spacing:

| Token | Value    | Use Case                                                    |
|-------|----------|-------------------------------------------------------------|
| `xs`  | `0.25em` | Tight spacing within components                             |
| `sm`  | `0.5em`  | Between related elements (e.g., skill tags, certificates)   |
| `md`  | `0.75em` | Between entries within a section                            |
| `lg`  | `1em`    | Before section headings                                     |

### Component-Level vs Manual `#v()` Rules

1. **Component spacing**: Each component should define its own `above`/`below` spacing
2. **No manual `#v()`**: Avoid manual `#v()` calls in the document body
3. **Exception**: Only use `#v()` for one-off visual tweaks that can't be handled by components

### Standardized Spacing by Element Type

| Element                  | Above        | Below         |
|--------------------------|--------------|---------------|
| Section heading (`= X`)  | `lg` (1em)   | `md` (0.75em) |
| `resume-entry-with-logo` | `lg` (1em)   | `md` (0.75em) |
| `resume-entry-content`   | `lg` (1em)   | `md` (0.75em) |
| `certificate-entry`      | `sm` (0.5em) | `sm` (0.5em)  |
| `section-note`           | `md` (0.75em)| `0`           |

### Key Principles

- Section headings handle their own spacing (`above: 1em`, `below: 0.75em`) - defined in `resume` function
- Entry components (`resume-entry-with-logo`, `resume-entry-content`) use symmetric `lg`/`md` spacing
- Certificate entries use symmetric `sm` spacing for compact lists
- No manual `#v()` calls should appear between sections or entries
- Use `section-note` for footnote-style text at the end of sections
