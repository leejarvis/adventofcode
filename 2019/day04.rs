// rustc day4.rs && ./day4 && rm day4

const START: i32 = 136818;
const FINISH: i32 = 685979;

fn part1_match(chars: &Vec<char>) -> bool {
  return chars.windows(2).any(|p| p[0] == p[1]) &&
    chars.windows(2).all(|p| p[0] <= p[1])
}

fn part2_match(chars: &Vec<char>) -> bool {
  for c in chars {
    if chars.iter().filter(|&x| *x == *c).count() == 2 {
      return true
    }
  }
  return false
}

fn main() {
  let mut part1: i32 = 0;
  let mut part2: i32 = 0;

  for n in START..FINISH {
    let chars: Vec<char> = n.to_string().chars().collect();

    if part1_match(&chars) {
      part1 += 1;

      if part2_match(&chars) {
        part2 += 1;
      }
    }
  }

  println!("{}", part1);
  println!("{}", part2);
}
