use crate::{Solution, SolutionPair};
use std::fs::read_to_string;

const NUMBERS: [&str; 9] = [
    "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
];

pub fn solve() -> SolutionPair {
    let input = read_to_string("input/day01.txt").unwrap();

    let mut p1 = 0;
    let mut p2 = 0;

    for line in input.lines() {
        p1 += extract_number(line, false);
        p2 += extract_number(line, true);
    }

    (Solution::from(p1), Solution::from(p2))
}

fn extract_number(line: &str, replace_words: bool) -> u64 {
    let mut numbers = Vec::new();

    for (c, char) in line.chars().enumerate() {
        if char.is_digit(10) {
            numbers.push(char.to_digit(10).unwrap() as u8);
        } else if replace_words && char.is_alphabetic() {
            for (i, n) in NUMBERS.iter().enumerate() {
                // use starts_with over `[c..(c + n.len())] == n` to avoid
                // out of bounds errors and having to conditionally check size
                if line[c..].starts_with(n) {
                    numbers.push(i as u8 + 1);
                    break;
                }
            }
        }
    }

    let n1 = numbers.first().unwrap();
    let n2 = numbers.last().unwrap();
    format!("{}{}", n1, n2).parse().unwrap()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_extract_number() {
        assert_eq!(extract_number("1abc2", false), 12);
        assert_eq!(extract_number("1abc2def3", false), 13);
        assert_eq!(extract_number("1abc2def3ghi4", false), 14);
        assert_eq!(extract_number("treb7uchet", false), 77);
        assert_eq!(extract_number("treb7uchet", true), 77);
        assert_eq!(extract_number("17oneightwo", true), 12);
    }
}
