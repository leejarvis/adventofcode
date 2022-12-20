#![allow(dead_code)]

fn is_triangle((a, b, c): (u32, u32, u32)) -> bool {
    a + b > c && a + c > b && b + c > a
}

fn count_triangles(triangles: Vec<(u32, u32, u32)>) -> usize {
    triangles.iter().filter(|t| is_triangle(**t)).count()
}

fn group_and_transpose(triangles: Vec<(u32, u32, u32)>) -> Vec<(u32, u32, u32)> {
    let mut grouped = vec![];
    for i in 0..triangles.len() / 3 {
        grouped.push((triangles[i * 3].0, triangles[i * 3 + 1].0, triangles[i * 3 + 2].0));
        grouped.push((triangles[i * 3].1, triangles[i * 3 + 1].1, triangles[i * 3 + 2].1));
        grouped.push((triangles[i * 3].2, triangles[i * 3 + 1].2, triangles[i * 3 + 2].2));
    }
    grouped
}

fn main() {
    let input = include_str!("../input.txt");
    let triangles: Vec<(u32, u32, u32)> =
        input.lines().map(|l| {
            let mut sides = l.split_whitespace().map(|s| s.parse().unwrap());
            (sides.next().unwrap(), sides.next().unwrap(), sides.next().unwrap())
        }).collect();

    println!("{}", count_triangles(triangles.iter().copied().collect()));
    println!("{}", count_triangles(group_and_transpose(triangles)));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_is_triangle() {
        assert!(!is_triangle((5, 10, 25)));
        assert!(is_triangle((10, 10, 15)));
    }

    #[test]
    fn test_group_and_transpose() {
        let triangles = vec![(1, 2, 3), (4, 5, 6), (7, 8, 9)];
        let expected = vec![(1, 4, 7), (2, 5, 8), (3, 6, 9)];
        assert_eq!(group_and_transpose(triangles), expected);
    }
}
