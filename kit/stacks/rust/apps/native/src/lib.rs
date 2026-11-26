//! Pure hot-path helpers. Without `--starter`: no napi.
//! Met starter: zie dezelfde crate + `package.json` (napi).

/// Example pure function — replace with the measured hot path.
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
