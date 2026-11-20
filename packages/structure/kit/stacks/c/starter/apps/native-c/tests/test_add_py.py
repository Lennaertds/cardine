"""Smoke voor ctypes-starter. Werkt met fallback zonder .so."""

from __future__ import annotations

from native_c_fallback import add


def test_add() -> None:
    assert add(2, 3) == 5
