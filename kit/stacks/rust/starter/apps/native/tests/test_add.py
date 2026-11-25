"""Smoke test for the PyO3 starter. Works with the fallback without a maturin build."""

from __future__ import annotations

from native_fallback import add


def test_add() -> None:
    assert add(2, 3) == 5
