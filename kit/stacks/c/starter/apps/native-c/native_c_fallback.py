"""Python side of apps/native-c (starter).

Tries build/libnative_c.so via ctypes; otherwise a pure fallback.
NATIVE_STRICT=1: no fallback — the .so is required (CI / check-full).
"""

from __future__ import annotations

import ctypes
import os
from pathlib import Path

_LIB = Path(__file__).resolve().parent / "build" / "libnative_c.so"


def add(left: int, right: int) -> int:
    if os.environ.get("NATIVE_STRICT") == "1":
        if not _LIB.is_file():
            raise FileNotFoundError(f"NATIVE_STRICT: missing {_LIB}")
        lib = ctypes.CDLL(str(_LIB))
        lib.native_c_add.argtypes = [ctypes.c_int32, ctypes.c_int32]
        lib.native_c_add.restype = ctypes.c_int32
        return int(lib.native_c_add(left, right))
    if _LIB.is_file():
        try:
            lib = ctypes.CDLL(str(_LIB))
            lib.native_c_add.argtypes = [ctypes.c_int32, ctypes.c_int32]
            lib.native_c_add.restype = ctypes.c_int32
            return int(lib.native_c_add(left, right))
        except OSError:
            pass
    return left + right
