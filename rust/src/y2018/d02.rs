use std::collections::HashMap;

pub fn parse(str: &str) -> Vec<&str> {
    str.lines().collect()
}

pub fn part1(input: &[&str]) -> u32 {
    checksum(input)
}

pub fn part2(input: &[&str]) -> String {
    for i in 0..input.len() {
        for j in i + 1..input.len() {
            let a = input[i];
            let b = input[j];
            let diff = remove_differing_chars(a, b);
            if diff.len() == a.len() - 1 {
                return diff;
            }
        }
    }

    "".to_owned()
}

fn checksum(input: &[&str]) -> u32 {
    let mut p2 = 0;
    let mut p3 = 0;

    for line in input {
        let counts = char_counts(line);
        if counts.values().any(|&v| v == 2) {
            p2 += 1;
        }
        if counts.values().any(|&v| v == 3) {
            p3 += 1;
        }
    }

    p2 * p3
}

fn remove_differing_chars(a: &str, b: &str) -> String {
    a.chars()
        .zip(b.chars())
        .filter(|&(a, b)| a == b)
        .map(|(a, _)| a)
        .collect()
}

fn char_counts(str: &str) -> HashMap<char, u32> {
    str.chars().fold(HashMap::new(), |mut acc, c| {
        *acc.entry(c).or_insert(0) += 1;
        acc
    })
}
