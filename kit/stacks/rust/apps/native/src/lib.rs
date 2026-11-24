//! Pure hot-path helpers. Zonder `--starter`: geen napi.
//! Met starter: zie dezelfde crate + `package.json` (napi).

/// Voorbeeld pure functie — vervang door het gemeten hot path.
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
