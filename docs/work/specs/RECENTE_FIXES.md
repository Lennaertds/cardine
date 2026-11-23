Wat ik net vond en heb gefixt
make sandbox-check — de poort die je hele plan moest bewaken — was rood. De unit-tests van de workspace-guard faalden, en alleen als CARDINE_WORKSPACE in de shell stond: precies wat de Zed-server nu zet. De tests bewijzen de grens via de sessie-cwd, maar een CARDINE_WORKSPACE overrulet die cwd, dus /tmp/guard-repo-* werd als “buiten de workspace” geweigerd.
Fix: index.test.js haalt de variabele per suite tijdelijk weg (withEnvOff), plus een regressie-tests voor het geval zelf.
Nu: node --test 7/7 groen, make sandbox-check groen, make check groen.
Negatieve controle: met het herstel uitgezet wordt de suite rood (3 falend) — het groen bewijst dus echt iets.
Probe-bestanden opgeruimd; make finish gelogd.
Wat al wél op orde is (niet door mij, maar gemeeten)
Eisen
Stand
Bewijs
Shell in de kooi, writes op host
werkt
echo in de kooi direct leesbaar met de read-tool, bestand in git status
Bind i.p.v. overlay
werkt
workspace is gewone btrfs, geen overlay-mount
ADR 0017 + spec + profielbron
bestaat
install-lab.sh, check-sandbox.sh, dag-log
Schrijven in/buiten, cellen
gemeten
matrix groen
Wat nog niet af is

- Deze sessie draait nog op het oude DSH-proces. `write`/`edit` blijven in die toolset tot Zed dicht is, `pkill -f "bin/dsh"`, één venster, nieuwe thread op **DeepSeek Harness**. Niet "DeepSeek Harness (full)".
- `CARDINE_KEY` is nog niet geroteerd bij de uitgever.
- Tag `lab-v0.4.0` hoort op de release-commit. Meta blijft `v0.3.0`, structure blijft `structure-v0.4.0`.

Dicht sinds de notitie hierboven

- `--unshare-user` staat aan. `make sandbox-check` eist een uid-map die niet de host-identiteit is. Een write op de bind blijft van jouw uid.
- Het netwerk van de shell blijft open (ADR 0017). `make sandbox-check` eist een geslaagde TCP-connect.
