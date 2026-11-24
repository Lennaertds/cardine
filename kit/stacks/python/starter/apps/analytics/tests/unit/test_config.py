from pathlib import Path

from analytics.config import REPO_ROOT, load_settings


def test_data_dir_comes_from_env(tmp_path: Path) -> None:
    settings = load_settings({"DATA_DIR": str(tmp_path)})

    assert settings.processed == tmp_path / "processed"
    assert settings.raw == tmp_path / "raw"


def test_empty_data_dir_falls_back_to_repo_data() -> None:
    settings = load_settings({"DATA_DIR": ""})

    assert settings.data_dir == (REPO_ROOT / "data").resolve()
