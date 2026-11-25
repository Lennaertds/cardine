# Desktop — images

> **Role:** Which images, how text sits on them, and the technical measures.
> **Not here:** brand personality (project).

Images support the story. An image that only "fills", goes out.

## 1. Kinds that are allowed

| Kind | Where |
|------|-------|
| Product UI (device mock, real screen) | Hero, product section |
| Scene photo from the product family | Full-bleed, possibly under Clear glass |
| Portrait / team | Detail panel if needed |

No stock of generic "happy users", no illustration pack, no patterns, no 3D objects as atmosphere.

Side by side: the same aspect ratio and the same short side. Not a square next to a banner.

## 2. Text on a photo

One method per image.

| Order | Method | When |
|-------|--------|------|
| 1 | Dim or a gradient over the image | Default as soon as there is text on the photo |
| 2 | Text in a calm part of the photo | Only if that part is really empty and reaches the contrast |
| 3 | Solid reading surface | Only in a detail panel, if glass does not carry the text ([surfaces.md](surfaces.md)) |

Do not stack the three methods on the same image.

## 3. Technical

- Source at least 2× the displayed CSS pixels. `srcset` with 1× and 2×.
- Format: AVIF or WebP. PNG only if real transparency is needed.
- `width` and `height`, or `aspect-ratio`, so the layout does not jump.
- Hero image: eager, high fetch priority. Everything below the first viewport: `loading="lazy"`.
- Compressed. A hero under about 200KB after compression is the goal; above that, compress again first.
- `max-width: 100%` and `height: auto` within the column. The full-bleed photo may leave the column, the text may not.
- Alt: descriptive if the image carries information. `alt=""` if it is decoration and the text next to it says the same.

## 4. Crop

Crop in on the subject. No second crop in CSS that does it anyway: `object-fit: cover` only if the safe zone is in the file.

**Test:** the landing page shows the product, not a stock photo. Every image has a reserved ratio. Text on a photo uses one of the three methods.
