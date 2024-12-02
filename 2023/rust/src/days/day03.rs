use crate::etc::grid_map::GridMap;
use crate::{Solution, SolutionPair};
use std::fs::read_to_string;

pub fn solve() -> SolutionPair {
    let input = read_to_string("input/day03.txt").unwrap();
    let grid = input.parse::<GridMap>().unwrap();

    let mut adjacent_numbers: Vec<(i32, i32)> = vec![];

    for ((x, y), c) in grid.map.iter() {
        if c.is_digit(10) || *c == '.' {
            continue;
        }

        for (x1, y1) in grid.adjacent_cells(*x, *y, true) {
            if let Some(c2) = grid.map.get(&(x1, y1)) {
                if c2.is_digit(10) {
                    adjacent_numbers.push((x1, y1));
                    println!("{} next to {} at ({},{})", c2, c, x1, y1);
                }
            }
        }
    }

    print!("{:?}", adjacent_numbers);

    let sol1: u64 = 0;
    let sol2: u64 = 0;

    (Solution::from(sol1), Solution::from(sol2))
}

#[cfg(test)]
mod tests {
    use super::*;
}
