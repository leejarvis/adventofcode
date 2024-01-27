#![allow(dead_code)]
#![allow(unused_imports)]

mod days;
mod etc;

use etc::solution::Solution;
use days::{day01, day02, day03, day04, day05,
           day06, day07, day08, day09, day10,
           day11, day12, day13, day14, day15,
           day16, day17, day18, day19, day20,
           day21, day22, day23, day24, day25};
use std::env;
use std::time::Instant;

pub type SolutionPair = (Solution, Solution);

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: cargo run <day> [day...]");
        std::process::exit(1);
    }

    let days: Vec<u8> = args[1..].iter()
        .map(|x| x.parse().unwrap_or_else(|_| {
            eprintln!("{:?} is not a valid day", x);
            std::process::exit(1);
        }))
        .collect();

    let mut runtime = 0.0;

    for day in days {
        let func = get_day_solver(day);

        let time = Instant::now();
        let (p1, p2) = func();
        let elapsed_ms = time.elapsed().as_nanos() as f64 / 1_000_000.0;

        println!("Day {:02}: ({}, {}) in {:.4}ms", day, p1, p2, elapsed_ms);
        runtime += elapsed_ms;
    }

    if args.len() > 2 {
        println!("\nTotal runtime: {:.4} ms", runtime);
    }
}

fn get_day_solver(day: u8) -> fn() -> SolutionPair {
    match day {
         1 => day01::solve,
         2 => day02::solve,
         3 => day03::solve,
         4 => day04::solve,
         5 => day05::solve,
         6 => day06::solve,
         7 => day07::solve,
         8 => day08::solve,
         9 => day09::solve,
        10 => day10::solve,
        11 => day11::solve,
        12 => day12::solve,
        13 => day13::solve,
        14 => day14::solve,
        15 => day15::solve,
        16 => day16::solve,
        17 => day17::solve,
        18 => day18::solve,
        19 => day19::solve,
        20 => day20::solve,
        21 => day21::solve,
        22 => day22::solve,
        23 => day23::solve,
        24 => day24::solve,
        25 => day25::solve,
         _ => unimplemented!(),
    }
}
