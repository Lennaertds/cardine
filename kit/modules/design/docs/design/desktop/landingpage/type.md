# Desktop — type

> **Role:** Showcase typography. The product ladder stays leading outside the showcase.
> **Not here:** fonts ([materials-type](../../iphone/materials-type.md)).

Three families, no fourth. `--font-sans` for UI and body. `--font-mono` only for real code or an id. `--font-display` only for the hero claim and the wordmark, and only if that override already exists behind the gate. Default display = sans.

Product screens, also ≥ 768px, keep the ladder in [materials-type](../../iphone/materials-type.md). This file enlarges nothing in the product path.

## 1. Roles on the showcase

| Role | Element | wide | regular | Weight | Leading | Tracking |
|------|---------|------|---------|--------|---------|----------|
| **Claim** | Hero H1 | 64–72px | 44–52px | 700 | 1.05–1.12 | −0.03em |
| **Section title** | H2 | 32–36px | 28px | 650 | 1.15 | −0.02em |
| **Lede** | Under the claim | 20–22px | 18px | 450 | 1.45 | 0 |
| **Body** | Prose | 17–18px | 17px | 400 | 1.55 | 0 |
| **Label** | On glass, eyebrow | 13px | 13px | 600 | 1.2 | 0.01em |
| **Meta** | Source, footnote | 13px | 13px | 450 | 1.35 | 0 |

Claim and section title may use `clamp()` within the band above. Body may not: 17px is the floor.

No all-caps section titles on the showcase. Product skins may use uppercase in the product; the showcase ignores that.

## 2. Hierarchy

- One H1 per page. On the landing page that is the claim.
- H2 = section title. At most one per section.
- An H3 in a feature column is the column name, same size as body + weight 650. No third display size.
- Lede is `--foreground`. Meta is `--muted`.
- Numbers in a demo chart: `.type-numeric`.

## 3. Size and class

The showcase claim uses a showcase class (or `.type-display` if that route deliberately makes it bigger). Not `text-6xl` loose in a component, and do not raise `--type-display` on the product root.

Buttons: 15–16px, weight 600. That is chrome, not a title role.

## 4. Prose

- Left-aligned. Measure: 65–72 characters on wide (band 60–75). On narrow 35–60.
- Body leading stays 1.55. That is inside 1.5–1.75. Do not stretch to 1.75 to feign "air".
- Weight never below 400. Headings 650–700. Labels 600.
- No justified text. No centred paragraphs. A short claim may centre on wide.
- No gradient text, no outline text.
- `text-wrap: balance` may be used on the claim and the section title, as an extra. The natural wrap must also be right.
- URLs and ids: `overflow-wrap: anywhere`. Do not break ordinary sentences with `word-break: break-all`.
- Nothing below 13px. Body not below 16px. 13px is label and meta only.

## 5. Heading ladder

H1, then H2, then H3. Do not skip a level. One H1.

**Test:** the hero H1 falls in the claim band; a product H1 in a wide window follows the product ladder. DevTools shows no fourth font-family. A prose line on wide stays under 75 characters.
