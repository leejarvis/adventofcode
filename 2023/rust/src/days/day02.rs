use crate::{Solution, SolutionPair};
use std::fs::read_to_string;

#[derive(Debug, PartialEq)]
enum Cube {
    Red(u8),
    Blue(u8),
    Green(u8),
}

impl std::str::FromStr for Cube {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        if let Some((n, color)) = s.split_once(" ") {
            let num = n.parse::<u8>().unwrap();
            match color {
                "red" => return Ok(Cube::Red(num)),
                "blue" => return Ok(Cube::Blue(num)),
                "green" => return Ok(Cube::Green(num)),
                _ => return Err(format!("Invalid color: {}", color)),
            }
        } else {
            return Err(format!("Invalid cube: {}", s));
        }
    }
}

type Handful = Vec<Cube>;

#[derive(Debug, PartialEq)]
struct Game {
    id: u64,
    handfuls: Vec<Handful>,
}

impl std::str::FromStr for Game {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let (prefix, game) = s.split_once(": ").ok_or("Error parsing game")?;
        let id = prefix
            .split_once(" ")
            .ok_or("Error parsing game id")?
            .1
            .parse::<u64>()
            .unwrap();

        let handfuls = game
            .split("; ")
            .map(|x| {
                x.split(", ")
                    .map(|y| y.parse::<Cube>())
                    .collect::<Result<Handful, String>>()
            })
            .collect::<Result<Vec<Handful>, String>>()?;

        Ok(Game { id, handfuls })
    }
}

impl Game {
    fn is_playable(&self) -> bool {
        let mut r = 0;
        let mut g = 0;
        let mut b = 0;

        for handful in self.handfuls.iter() {
            for cube in handful {
                match cube {
                    Cube::Red(n) if n > &r => r = *n,
                    Cube::Green(n) if n > &g => g = *n,
                    Cube::Blue(n) if n > &b => b = *n,
                    _ => (),
                }
            }
        }

        r <= 12 && g <= 13 && b <= 14
    }
}

pub fn solve() -> SolutionPair {
    let input = read_to_string("input/day02.txt").unwrap();

    let sol2: u64 = 0;

    let sol1 = input
        .lines()
        .map(|x| x.parse::<Game>().unwrap())
        .fold(0, |acc, game| {
            if game.is_playable() {
                acc + game.id
            } else {
                acc
            }
        });

    (Solution::from(sol1), Solution::from(sol2))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_cube() {
        assert_eq!("3 blue".parse::<Cube>(), Ok(Cube::Blue(3)));
        assert_eq!("1 red".parse::<Cube>(), Ok(Cube::Red(1)));
        assert_eq!("foo".parse::<Cube>(), Err("Invalid cube: foo".to_string()));
    }

    #[test]
    fn test_parse_game() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
        let game = input.parse::<Game>().unwrap();

        assert_eq!(game.id, 1);

        let mut handfuls = game.handfuls.iter();

        assert_eq!(handfuls.next().unwrap(), &vec![Cube::Blue(3), Cube::Red(4)]);
        assert_eq!(
            handfuls.next().unwrap(),
            &vec![Cube::Red(1), Cube::Green(2), Cube::Blue(6)]
        );
        assert_eq!(handfuls.next().unwrap(), &vec![Cube::Green(2)]);
        assert_eq!(handfuls.next(), None);
    }

    #[test]
    fn test_playable() {
        let game = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
            .parse::<Game>()
            .unwrap();
        assert!(game.is_playable());

        let game = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
            .parse::<Game>()
            .unwrap();
        assert!(!game.is_playable());
    }
}
