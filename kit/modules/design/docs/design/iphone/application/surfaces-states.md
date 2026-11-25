# UI iPhone — surfaces · empty / loading / error

> **Role:** Empty, loading and error states — the same hierarchy everywhere.
> **Not here:** cards ([surfaces-cards](surfaces-cards.md)); sticky headers ([surfaces-sticky-heads](surfaces-sticky-heads.md)).

## S1. Empty state

Every list/feed/board that can have **0 items** gets an empty state — no blank white space.

| Element | Rule |
|---------|------|
| **Place** | In the content zone of that section (not as a toast) |
| **Title** (optional) | `.type-headline` — short |
| **Body** | `.type-caption text-muted` or `.type-body text-muted` — one sentence on what is missing |
| **CTA** (optional) | One secondary or primary (C1) that resolves the empty state |
| **Icon** | Optional, muted; no emoji wall |

**Four kinds of empty:**

| Kind | Copy direction | CTA direction |
|------|----------------|---------------|
| **first run** | Welcome / what goes here | Primary first action |
| **no results** | The query returned nothing | Clear search / categories |
| **error** | What broke + what now ([S3](#s3-errors)) | Retry / back |
| **filtered** | Filters made the list empty | Clear filters |

**Don't:** only `"…"` or a bare `null`; no Sonner for "the list is empty"; no log-file copy.

## S2. Loading

| Situation | Pattern |
|-----------|---------|
| Route suspense | Short muted text, centred in the page chrome |
| Inline section refresh | Muted caption in that section; **no** full-screen flash |
| Skeleton | Layout before content if the shift is > ~1 screen high |
| Optimistic UI | UI immediately; sync in the background; rollback + one error on failure |
| Progress | Real % or "time left" where an upload runs |

**Don't:** a blank white screen while loading; three "Loading…" fonts at once; optimistic without a rollback path.

## S3. Errors

| Kind | Pattern |
|------|---------|
| **Field validation** | Inline caption + `aria-invalid` ([overlays-forms](overlays-forms.md)) |
| **Action failed** (network) | Sonner `toast.error` **or** an inline banner if the user has to stay and fix it |
| **Screen unusable** | Short error + "Retry" / back — in the page chrome, not only the console |

| Axis | Rule |
|------|------|
| **Type → surface** | Validation = inline; connection = banner or toast; crash = its own space |
| **Severity → volume** | Minor inline; transient toast; blocking only if unusable |
| **Exit / retry** | Always a path — no dead "OK" |
| **Plain language** | What broke, why, what now |

**Don't:** a toast **and** a blocking modal for the same error.

## S4. Never (states)

| Never | Instead |
|-------|---------|
| An empty list without an explanation | S1 empty |
| Toast spam on an empty inbox | Empty state |
| Skeleton + spinner + "Loading" at once | One pattern from S2 |
| A blank screen on first paint | Skeleton / caption / existing chrome |
