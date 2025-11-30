use crate::ext::Ints;
use std::collections::HashMap;

pub fn parse(str: &str) -> Vec<Vec<i32>> {
    let mut out = HashMap::new();

    for line in str.lines() {
        let [id, x, y, w, h] = line.ints::<i32>()[..] else {
            continue;
        };
        for i in x..x + w {
            for j in y..y + h {
                out.entry((i, j)).or_insert(Vec::new()).push(id);
            }
        }
    }

    out.values().cloned().collect()
}

pub fn part1(fabric: &[Vec<i32>]) -> i32 {
    fabric.iter().filter(|v| v.len() > 1).count() as i32
}

pub fn part2(fabric: &[Vec<i32>]) -> i32 {
    let mut ids = fabric.iter().flatten();
    *ids.find(|id| !fabric.iter().any(|ids| ids.contains(id) && ids.len() > 1))
        .unwrap_or(&0)
}
