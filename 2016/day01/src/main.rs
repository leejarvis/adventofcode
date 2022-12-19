#![allow(dead_code)]

use std::collections::HashSet;

/// A point is a tuple of x and y coordinates. e.g. (1, 2)
type Point = (i32, i32);

/// A move is a tuple of a direction and a number of steps. e.g. ("R", 2)
type Move<'a> = (&'a str, i32);

#[derive(Debug, PartialEq, Clone, Copy)]
enum Dir {
    North,
    East,
    South,
    West,
}

struct Bot {
    pos: Point,
    dir: Dir,
    visited: Vec<Point>,
}

impl Bot {
    fn new() -> Bot {
        Bot {
            pos: (0, 0),
            dir: Dir::North,
            visited: vec![(0, 0)]
        }
    }

    fn simulate(&mut self, moves: Vec<Move>) {
        for m in moves {
            self.move_to(m);
        }
    }

    /// Move once in the current direction
    fn move_once(&mut self) {
        let (x, y) = self.pos;

        let new_pos = match self.dir {
            Dir::North => (x, y + 1),
            Dir::East => (x + 1, y),
            Dir::South => (x, y - 1),
            Dir::West => (x - 1, y),
        };

        self.visited.push(new_pos);
        self.pos = new_pos;
    }

    /// Move in the given direction for the given number of steps
    fn move_to(&mut self, m: Move) {
        let (d, n) = m;

        self.dir = match self.dir {
            Dir::North => match d {
                "R" => Dir::East,
                "L" => Dir::West,
                _ => panic!("Unknown direction"),
            },
            Dir::East => match d {
                "R" => Dir::South,
                "L" => Dir::North,
                _ => panic!("Unknown direction"),
            },
            Dir::South => match d {
                "R" => Dir::West,
                "L" => Dir::East,
                _ => panic!("Unknown direction"),
            },
            Dir::West => match d {
                "R" => Dir::North,
                "L" => Dir::South,
                _ => panic!("Unknown direction"),
            },
        };

        for _ in 0..n {
            self.move_once();
        }
    }

    /// Find the first point visited twice
    fn first_point_visited_twice(&self) -> Option<&Point> {
        let mut visited = HashSet::new();
        let mut first = None;

        for p in &self.visited {
            if visited.contains(&p) {
                first = Some(p);
                break;
            } else {
                visited.insert(p);
            }
        }

        first
    }
}

fn parse_input(input: &str) -> Vec<Move> {
    input
        .split(", ")
        .map(|s| {
            let (d, n) = s.split_at(1);
            (d, n.parse::<i32>().unwrap())
        })
        .collect()
}

fn manhattan_distance(pos: Point) -> i32 {
    let (x, y) = pos;
    x.abs() + y.abs()
}

fn main() {
    let input = include_str!("../input.txt");
    let moves = parse_input(input);
    let mut bot = Bot::new();
    bot.simulate(moves);

    println!("{:?}", manhattan_distance(bot.pos));

    match bot.first_point_visited_twice() {
        Some(p) => println!("{:?}", manhattan_distance(*p)),
        None => println!("No point visited twice"),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_input() {
        let input = "R2, L3";
        let expected = vec![("R", 2), ("L", 3)];
        assert_eq!(parse_input(input), expected);
    }

    #[test]
    fn test_move_to() {
        let mut bot = Bot::new();
        bot.move_to(("R", 2));
        assert_eq!(bot.pos, (2, 0));
        assert_eq!(bot.dir, Dir::East);
        assert_eq!(bot.visited, vec![(0, 0), (1, 0), (2, 0)]);
        bot.move_to(("L", 3));
        assert_eq!(bot.pos, (2, 3));
        assert_eq!(bot.dir, Dir::North);
        assert_eq!(bot.visited, vec![(0, 0), (1, 0), (2, 0), (2, 1), (2, 2), (2, 3)]);
    }

    fn test_first_point_visited_twice() {
        let mut bot = Bot::new();
        bot.simulate(vec![("R", 8), ("R", 4), ("R", 4), ("R", 8)]);
        assert_eq!(bot.first_point_visited_twice(), Some(&(4, 0)));
    }
}
