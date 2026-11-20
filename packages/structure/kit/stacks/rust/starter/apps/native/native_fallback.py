"""Python-kant van apps/native (starter).

Probeert de maturin/PyO3-module `native`; anders pure fallback (spiegel van index.js).
NATIVE_STRICT=1: geen fallback (CI / check-full).
"""

from __future__ import annotations

import os


def add(left: int, right: int) -> int:
    if os.environ.get("NATIVE_STRICT") == "1":
        from native import add_py  # type: ignore[import-untyped]

        return int(add_py(left, right))
    try:
        from native import add_py  # type: ignore[import-untyped]

        return int(add_py(left, right))
    except Exception:
        return left + right
