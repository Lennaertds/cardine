from pathlib import Path

import pytest

from pipeline.config import REPO_ROOT, ConfigError, load_settings

LOCAL_URL = "postgres://app:app@localhost:5432/app"


def test_settings_come_from_env(tmp_path: Path) -> None:
    settings = load_settings({"DATABASE_URL": LOCAL_URL, "DATA_DIR": str(tmp_path)})

    assert settings.database_url == LOCAL_URL
    assert settings.raw == tmp_path / "raw"


def test_empty_data_dir_falls_back_to_repo_data() -> None:
    settings = load_settings({"DATABASE_URL": LOCAL_URL, "DATA_DIR": ""})

    assert settings.data_dir == (REPO_ROOT / "data").resolve()


def test_missing_database_url_is_an_error() -> None:
    with pytest.raises(ConfigError, match="DATABASE_URL"):
        load_settings({})
