# Typst Template Reference

## Packages

- `modern-cv` — base CV template
- `fontawesome` — icons for contact info
- `cetz` — drawing library
- `linguify` — i18n support

## Custom components in main.typ

- `resume` — extends `modern-cv` with configurable profile picture and custom styling
- `resume-entry-with-logo` — work entries with company logo
- `resume-entry-content` — content block for a role entry
- `certificate-entry` — compact entry for certificates/awards
- `section-note` — footnote-style text at the end of a section

---

## Vertical Spacing

### Fixed spacing scale — use only these values

| Token | Value    | Use case |
|-------|----------|----------|
| `xs`  | `0.25em` | Tight spacing within components |
| `sm`  | `0.5em`  | Between related elements (skill tags, certificates) |
| `md`  | `0.75em` | Between entries within a section |
| `lg`  | `1em`    | Before section headings |

### Standardized spacing by element

| Element                  | Above        | Below         |
|--------------------------|--------------|---------------|
| Section heading (`= X`)  | `lg` (1em)   | `md` (0.75em) |
| `resume-entry-with-logo` | `lg` (1em)   | `md` (0.75em) |
| `resume-entry-content`   | `lg` (1em)   | `md` (0.75em) |
| `certificate-entry`      | `sm` (0.5em) | `sm` (0.5em)  |
| `section-note`           | `md` (0.75em)| `0`           |

### Rules

1. Each component defines its own `above`/`below` — do not add manual `#v()` between sections or entries.
2. `#v()` is only acceptable for one-off visual tweaks that components can't handle.
3. Section headings handle their own spacing — defined in the `resume` function.
