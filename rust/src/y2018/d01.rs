use std::collections::HashSet;

pub fn parse(str: &str) -> Vec<i32> {
    str.split("\n")
        .filter_map(|s| s.parse::<i32>().ok())
        .collect()
}

pub fn part1(input: &[i32]) -> i32 {
    input.iter().sum()
}

pub fn part2(input: &[i32]) -> i32 {
    let mut sum = 0;
    let mut seen = HashSet::new();
    let mut cycle = input.iter().cycle();

    loop {
        let Some(n) = cycle.next() else { break };
        sum += n;
        if seen.contains(&sum) {
            break;
        }
        seen.insert(sum);
    }

    sum
}
