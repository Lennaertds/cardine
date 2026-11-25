"""Smoke test for the ctypes starter. Works with the fallback without the .so."""

from __future__ import annotations

from native_c_fallback import add


def test_add() -> None:
    assert add(2, 3) == 5
