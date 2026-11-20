"""Paden en instellingen uit de omgeving, met de data-lagen van de repo als standaard."""

from __future__ import annotations

import os
from collections.abc import Mapping
from dataclasses import dataclass
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[4]


@dataclass(frozen=True)
class Settings:
    data_dir: Path

    @property
    def raw(self) -> Path:
        return self.data_dir / "raw"

    @property
    def external(self) -> Path:
        return self.data_dir / "external"

    @property
    def interim(self) -> Path:
        return self.data_dir / "interim"

    @property
    def processed(self) -> Path:
        return self.data_dir / "processed"

    @property
    def reference(self) -> Path:
        return self.data_dir / "reference"

    @property
    def models(self) -> Path:
        return self.data_dir / "models"


def load_settings(env: Mapping[str, str] | None = None) -> Settings:
    values = os.environ if env is None else env
    data_dir = values.get("DATA_DIR") or str(REPO_ROOT / "data")
    return Settings(data_dir=Path(data_dir).resolve())
