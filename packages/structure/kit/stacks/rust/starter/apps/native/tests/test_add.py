"""Smoke voor PyO3-starter. Werkt met fallback zonder maturin-build."""

from __future__ import annotations

from native_fallback import add


def test_add() -> None:
    assert add(2, 3) == 5
