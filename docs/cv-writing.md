# CV Writing Standards

## XYZS Framework

Every bullet should communicate impact, not just activity. Use the XYZS test:

| Component | Question | Example |
|---|---|---|
| **X** – Achievement | What changed or was accomplished? | "Reduced latency" |
| **Y** – Measurement | How much? How fast? How often? | "by 60%" |
| **Z** – Method | How was it done? | "by replacing sync fan-out with async workers" |
| **S** – Scope/Context | At what scale or business context? | "for 3M daily requests" |

### Scoring scale (0–4)

| Score | Pattern | Meaning |
|---|---|---|
| 0 | No X | Pure duty/task statement |
| 1 | X only | Direction claimed, no measurement or method |
| 2 | Two of XYZ | Partial — XY or XZ present, one missing |
| 3 | Full XYZ | Strong, but scale/context absent |
| 4 | Full XYZS | Complete, credible, well-anchored |

### Canonical contrast

**Score 0 (duty only)**
> "Responsible for the backend of the payments service."

**Score 4 (full XYZS)**
> "Reduced failed checkout sessions by 27% by shipping an idempotent retry flow for 5M monthly shoppers, lifting conversion by 3.1 points."

---

## Rewrite Formula

```
[Action verb] [what changed] by [how], resulting in [measured outcome], at [scope/context].
```

Example transformation:
- Before: "Worked on API performance improvements."
- After: "Reduced API p95 latency from 420ms to 180ms by replacing synchronous fan-out calls with batched async workers for 3M daily requests."

---

## Verb Quality

**Strong verbs** — use these:
Architected, Reduced, Drove, Shipped, Led, Established, Eliminated, Scaled, Redesigned, Automated, Migrated, Deployed, Built, Owned, Cut, Increased, Launched

**Weak verbs** — flag and replace:
Helped, Assisted, Supported, Worked on, Was responsible for, Participated in, Involved in, Contributed to

---

## Anti-patterns to flag

- `Responsible for...` → rewrite as achievement
- `Worked on...` → rewrite with outcome
- `Helped with...` / `Assisted in...` → own the contribution
- Hedged quantification: "significantly improved", "large team", "many customers" → use numbers
- Vague impact: "improved performance" without magnitude or scope → add Y and S

---

## Formatting conventions

- **Numbers:** Always use numerals, never words — `3 teams` not "three teams", `5 engineers` not "five engineers"
- **Units:** No space between number and unit — `30s`, `600h/week`, `3ms`, `1.5k$/month`

---

## Hard constraints

- **Never invent metrics.** If a number is unknown, use conditional phrasing: *"If [metric] is available, add here."*
- **Never score above 1** if there is no number and no concrete direction of change.
- **Cap at 3** if XYZ is present but scale/context is absent.
- Scope inferred rather than explicit → keep conservative and note uncertainty.
