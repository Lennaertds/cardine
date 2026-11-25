# Creating a profile — guide

> **Role:** How to create a new kit profile and add it to the existing ones.
> **Not here:** the existing profiles ([kit/profiles/](../kit/profiles/README.md)), what a profile is ([standard/profielen.md](../standard/profielen.md)).

## Steps

1. **Decide the profile** — which modules? Which stacks? Extra folders?
2. **Create `kit/profiles/<name>.profile`** — see the example below.
3. **Add a row** in `standard/profielen.md` (the table) and in `kit/README.md` (the profile table).
4. **Adjust `new-project.sh` if needed** when the profile needs extra logic (e.g. a separate Makefile).
5. **Test:** `make test-kit` and try: `bash kit/new-project.sh tmp/test-profile --profile <name> --dry-run`.

## Example `.profile` file

```bash
# kit/profiles/studie.profile
PROFILE_NAME="studie"
PROFILE_DESCRIPTION="Study planning: calendar, deadlines, study log"
MODULES="assignment"
STACKS=""
STARTER=false
EXTRA_DIRS="werk/kalender.md,werk/deadlines.md,werk/studielog.md"
```

## Extra folders for a profile

The folder `kit/profiles/extra/<name>/` can hold files that are installed into a project with that profile. For example:

```
kit/profiles/extra/studie/
├── werk/
│   ├── kalender.md            # template for the yearly calendar
│   ├── deadlines.md           # table with deadlines
│   └── studielog.md           # daily log
└── local.mk                   # profile targets: log, deadline, kalender
```

## Must-check after creation

- [ ] The profile works with `--dry-run`: it shows the right modules and folders
- [ ] The profile works without `--dry-run`: the folder exists and `make check` is green
- [ ] No unnecessary modules (e.g. `compose` for `studie`)
- [ ] `kit/README.md` has a row
- [ ] `standard/profielen.md` has a row
- [ ] `make test-kit` is green

## Removing a profile

1. Remove `kit/profiles/<name>.profile`
2. Remove the row from `standard/profielen.md` and `kit/README.md`
3. Remove `kit/profiles/extra/<name>/` if it exists
4. `make test-kit`
