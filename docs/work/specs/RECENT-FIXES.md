What I just found and fixed
make sandbox-check — the gate that had to guard your whole plan — was red. The unit tests of the workspace guard failed, and only when CARDINE_WORKSPACE was in the shell: exactly what the Zed server sets now. The tests prove the boundary through the session cwd, but a CARDINE_WORKSPACE overrides that cwd, so /tmp/guard-repo-* was refused as "outside the workspace".
Fix: index.test.js removes the variable per suite for a moment (withEnvOff), plus a regression test for the case itself.
Now: node --test 7/7 green, make sandbox-check green, make check green.
Negative control: with the fix switched off the suite goes red (3 failing) — so the green really proves something.
Probe files cleaned up; make finish logged.
What is already in order (not by me, but measured)
Requirement
State
Evidence
Shell in the cage, writes on the host
works
echo in the cage directly readable with the read tool, file in git status
Bind instead of overlay
works
the workspace is plain btrfs, no overlay mount
ADR 0017 + spec + profile source
exists
install-lab.sh, check-sandbox.sh, daily log
Writing inside/outside, cells
measured
matrix green
What is not finished yet

- This session still runs on the old DSH process. `write`/`edit` stay in that toolset until Zed is closed, `pkill -f "bin/dsh"`, one window, a new thread on **DeepSeek Harness**. Not "DeepSeek Harness (full)".
- `CARDINE_KEY` has not been rotated at the publisher yet.
- Tag `lab-v0.4.0` belongs on the release commit. Meta stays `v0.3.0`, structure stays `structure-v0.4.0`.

Closed since the note above

- `--unshare-user` is on. `make sandbox-check` requires a uid map that is not the host identity. A write on the bind keeps your uid.
- The shell network stays open (ADR 0017). `make sandbox-check` requires a successful TCP connect.
