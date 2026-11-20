# Glas — de ene klasse

> **Rol:** De implementatie van `.glass` voor alle vlakken. Waar glas mag, staat per craft-bestand.  
> **Niet hier:** waar glas mag per vlak ([liquid-glass.md](../desktop/landingpage/liquid-glass.md), [materials-depth](../iphone/materials-depth.md)).

Eén class. Geen tweede blur, geen mesh-gradient, geen vaste witte rand uit een kit.

## 1. `.glass`

```css
.glass {
  background: color-mix(in oklab, var(--card) 42%, transparent);
  backdrop-filter: saturate(1.9) blur(40px);
  -webkit-backdrop-filter: saturate(1.9) blur(40px);
  box-shadow:
    inset 0 0.5px 0 color-mix(in oklab, #fff 42%, transparent),
    0 10px 28px color-mix(in oklab, #000 18%, transparent);
}
```

Donker theme: buitenste schaduw 35% zwart, inset-glans 18% wit. Die override blijft in `globals.css` bij `.glass`.

Haarlijn op een vlakke bodem:

```css
border: 1px solid color-mix(in oklab, var(--stroke) 55%, transparent);
```

`prefers-reduced-transparency: reduce` maakt dit bijna solid: `--card` op ≥ 92%, blur uit. De haarlijn blijft. [a11y.md](a11y.md).

## 2. Clear

`.glass-clear` bestaat pas als de voorwaarden in [liquid-glass](../desktop/landingpage/liquid-glass.md) §1 slagen, en alleen als class in `globals.css`. Tint richting 18–24% `--card`, dezelfde blur-familie, dim eronder. Tot die class er is: Regular.

## 3. Waar de class zit

Glas = **functionele chrome**, niet content.

| Laag | Glas op | Niet op |
|------|---------|---------|
| Showcase / landingspagina | Nav, menu, hoogstens één functioneel paneel. [liquid-glass](../desktop/landingpage/liquid-glass.md) | Proza, kaartgrids, hero-copy |
| Applicatie | Header, tabbar / top-nav, sheet-chrome, gepinde titel. [materials-depth](../iphone/materials-depth.md) | Kaarten, tabellen, dichte content |

**Test:** elke glazen balk gebruikt deze class. Nergens een tweede `backdrop-filter` met een ander blur-getal.
