//! Starter: pure `add` + optionele FFI-scaffolds.
//! - **napi (Nest/Node):** `package.json` + `pnpm build` (toolchain; zie index.js-fallback).
//! - **PyO3 (Python/analytics):** `pyproject.toml` (maturin) + feature `pyo3-bridge`.
//!
//! `cargo test` (zonder features) blijft groen zonder Node/Python-toolchain.

/// Pure hot-path voorbeeld — vervang na ADR/meting.
pub fn add(left: i32, right: i32) -> i32 {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn add_works() {
        assert_eq!(add(2, 2), 4);
    }
}

// napi: volledige `#[napi]`-exports via @napi-rs/cli + build — niet hard-gepinned (OS-varia).
// Nest laadt de `.node` achter een seam (polyglot.md).

#[cfg(feature = "pyo3-bridge")]
mod pyo3_bridge {
    use pyo3::prelude::*;
    use super::add;

    #[pyfunction]
    fn add_py(left: i32, right: i32) -> i32 {
        add(left, right)
    }

    #[pymodule]
    fn native(m: &Bound<'_, PyModule>) -> PyResult<()> {
        m.add_function(wrap_pyfunction!(add_py, m)?)?;
        Ok(())
    }
}
