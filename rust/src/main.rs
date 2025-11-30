use std::env;

pub mod ext;

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();
    let mut filter_year: Option<&str> = None;
    let mut filter_day: Option<&str> = None;
    let example = args.contains(&"-e".to_owned());

    if let Some(arg) = args.first() {
        if let Some((y, d)) = arg.split_once('/') {
            filter_year = Some(y);
            filter_day = Some(d);
        } else {
            filter_year = Some(arg.as_str());
        }
    }
    let solutions: Vec<Vec<Solution>> = vec![y2018()];

    for year in &solutions {
        for sol in year {
            if filter_year.is_none_or(|y| sol.year == y) && filter_day.is_none_or(|d| sol.day == d)
            {
                let input_path = if example {
                    format!("input/{}/{}.example.txt", sol.year, sol.day)
                } else {
                    format!("input/{}/{}.txt", sol.year, sol.day)
                };
                let input = std::fs::read_to_string(&input_path)
                    .unwrap_or_else(|_| panic!("missing input file: {}", input_path));
                let (p1, p2) = (sol.runner)(&input);
                println!("{} {} -> {:?} {:?}", sol.year, sol.day, p1, p2);
            }
        }
    }
}

struct Solution {
    year: &'static str,
    day: &'static str,
    runner: fn(&str) -> (String, String),
}

macro_rules! solutions {
    ( $( $year:ident { $( $day:ident ),* $(,)? } ),* $(,)? ) => {
        $(
            pub mod $year {
                $( pub mod $day; )*
            }
        )*
        $(
            solution!($year $( $day ),*);
        )*
    }
}

macro_rules! solution {
    ($year:tt $( $day:tt ),* ) => {
        fn $year() -> Vec<Solution> {
            vec![
                $(
                    Solution {
                        year: stringify!($year),
                        day: stringify!($day),
                        runner: |data: &str| {
                            use $year::$day::*;
                            let input = parse(data);
                            let part1 = part1(&input).to_string();
                            let part2 = part2(&input).to_string();
                            (part1, part2)
                        }
                    }
                ),*
            ]
        }
    }
}

solutions!(y2018 { d01, d02, d03 });
