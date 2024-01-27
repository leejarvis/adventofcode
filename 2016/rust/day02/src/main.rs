#![allow(dead_code)]

const KEYPAD_BAS: [[&'static str; 5]; 5] = [
    [" ", " ", " ", " ", " "],
    [" ", "1", "2", "3", " "],
    [" ", "4", "5", "6", " "],
    [" ", "7", "8", "9", " "],
    [" ", " ", " ", " ", " "],
];
const KEYPAD_BAS_START: (usize, usize) = (2, 2);

const KEYPAD_ADV: [[&'static str; 5]; 5] = [
    [" ", " ", "1", " ", " "],
    [" ", "2", "3", "4", " "],
    ["5", "6", "7", "8", "9"],
    [" ", "A", "B", "C", " "],
    [" ", " ", "D", " ", " "],
];
const KEYPAD_ADV_START: (usize, usize) = (2, 0);

fn solve<'a>(keypad: &'a [[&'a str; 5]], start: (usize, usize), ins: Vec<Vec<char>>) -> String {
    let mut pos = start;
    let mut code = String::new();

    for line in ins {
        for c in line {
            match c {
                'U' => if pos.0 > 0 && keypad[pos.0 - 1][pos.1] != " " { pos.0 -= 1 },
                'D' => if pos.0 < 4 && keypad[pos.0 + 1][pos.1] != " " { pos.0 += 1 },
                'L' => if pos.1 > 0 && keypad[pos.0][pos.1 - 1] != " " { pos.1 -= 1 },
                'R' => if pos.1 < 4 && keypad[pos.0][pos.1 + 1] != " " { pos.1 += 1 },
                _ => panic!("Invalid instruction"),
            }
        }
        code.push_str(keypad[pos.0][pos.1]);
    }

    code
}

fn main() {
    let input = include_str!("../input.txt");
    let ins: Vec<Vec<char>> = input.lines().map(|l| l.chars().collect()).collect();

    println!("{}", solve(&KEYPAD_BAS, KEYPAD_BAS_START, ins.clone()));
    println!("{}", solve(&KEYPAD_ADV, KEYPAD_ADV_START, ins.clone()));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_solve() {
        let ins = vec![vec!['U', 'L', 'L'], vec!['R', 'R', 'D', 'D', 'D']];
        assert_eq!(solve(&KEYPAD_BAS, KEYPAD_BAS_START, ins.clone()), "19");

        let ins = vec![vec!['R'], vec!['R'], vec!['D']];
        assert_eq!(solve(&KEYPAD_ADV, KEYPAD_ADV_START, ins.clone()), "67B");
    }
}
