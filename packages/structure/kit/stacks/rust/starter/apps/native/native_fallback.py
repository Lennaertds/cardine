"""Python side of apps/native (starter).

Tries the maturin/PyO3 module `native`; otherwise a pure fallback (mirror of index.js).
NATIVE_STRICT=1: no fallback (CI / check-full).
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
