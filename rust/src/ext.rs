use std::str::FromStr;

pub trait Ints {
    fn ints<T: FromStr>(&self) -> Vec<T>;
}

impl Ints for str {
    fn ints<T: FromStr>(&self) -> Vec<T> {
        self.split(|c: char| !c.is_ascii_digit() && c != '-')
            .filter(|s| !s.is_empty())
            .filter_map(|s| s.parse::<T>().ok())
            .collect()
    }
}
