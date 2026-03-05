The user may provide a bullet as an argument: $ARGUMENTS

If $ARGUMENTS is non-empty, treat it as the bullet text to improve.
If $ARGUMENTS is empty, ask the user to paste the bullet they want to improve.

For the selected bullet:
1. Score it XYZS 0–4 using the criteria in `docs/cv-writing.md`
2. Identify which XYZS components are present and which are missing
3. Provide a rewritten version applying the rewrite formula from `docs/cv-writing.md`
4. If a metric is unknown, use conditional phrasing: *"If [metric] is available, insert here"* — never invent numbers
5. Note any data the candidate must supply to complete the rewrite

Format output as:

**Original:** <bullet text>
**XYZS score:** <0-4> (missing: <components>)
**Rewrite:** <improved bullet>
**Data needed:** <what to fill in, or "none">
