# Desktop — ux

> **Role:** How the showcase works: goal, copy, links, forms, feedback.
> **Not here:** looks ([looks.md](looks.md)).

Pretty follows from this. An effect that does not serve the goal goes out.

## 1. Goal per page

Every showcase route has one sentence: what the visitor must be able to do here (understand, act, or go on).

A pattern people already know: bar on top, claim, action, then the rest. No new navigation metaphor.

## 2. Copy

- The claim names the concrete result. No vague promise ("the best platform").
- Short words. No stack jargon in the claim or the feature line. Stack may appear in a technical spot.
- One topic per sentence. Cut the fluff. Plain product copy — no AI marketing wool ("revolutionize your journey").
- Long text breaks with an H2, an image or a list. No wall.
- The primary button says what happens ("Open the demo", "Go to the app"). Not "Submit", "Click here", "Learn more".
- Same destination in the bar and in the hero.
- One accent CTA in the hero (~90/10 against the secondary). Real proof in that same viewport: product UI or a real scene — no stock abstract, no AI blob as "proof".

## 3. Links

- In prose: `--accent` **and** underlined. Colour alone is not enough.
- In the bar: no underline. The active route is weight 650.
- Blue is not a link colour. Underlined text that is not a link does not exist.
- External links say where they go.

## 4. Hierarchy on the landing page

The eye path, top to bottom:

1. Claim (size).
2. Primary button (accent, the only filled action).
3. Image of the product.
4. Then the rest of the sections.

Emphasise something by keeping the rest calmer, not by introducing a second accent. An image pulls hard: that is why it sits in the hero, not again as full width between features.

## 5. Forms

Rare on the showcase. If there is a field:

- Visible label above the field, one vertical line. A placeholder is not a label.
- A required field gets a word or asterisk in the label.
- Error under the field, on blur, not on every keystroke. The text says what is wrong and how to fix it.
- Several errors: a summary at the top that takes focus, plus the errors at the fields.
- Type and `autocomplete` are right (`email`, paste allowed).
- Field height ≥ 44px.
- Unsaved input: ask before closing.

## 6. Feedback

- Every action answers within 100ms (press, or the pending state).
- Short confirmation: the existing toaster, 3–5 seconds, does not steal focus, `aria-live="polite"`.
- An error that stays: in the page, with a way to try again.
- Destructive sits spatially away from the primary button, in the product's danger colour, with a word next to it.
- Undo if the action wipes content.

## 7. Consistency across pages

- Help and footer links sit in the same order on every showcase route.
- Going back restores scroll where the browser does. The page does not jump quietly to home.
- A dialog is not navigation. Content pages are routes.

**Test:** the hero button names the destination. A prose link is accent and underlined. There is no second filled action.
