use std::collections::HashMap;

pub struct GridMap {
    pub map: HashMap<(i32, i32), char>,
    pub width: i32,
    pub height: i32,
}

impl GridMap {
    pub fn each_cell(&self, f: impl Fn(i32, i32, char)) {
        for y in 0..=self.height {
            for x in 0..=self.width {
                f(x, y, *self.map.get(&(x, y)).unwrap());
            }
        }
    }

    pub fn adjacent_cells(&self, x: i32, y: i32, include_diagonal: bool) -> Vec<(i32, i32)> {
        let mut cells = vec![];
        if x > 0 {
            cells.push((x - 1, y));
        }
        if x < self.width {
            cells.push((x + 1, y));
        }
        if y > 0 {
            cells.push((x, y - 1));
        }
        if y < self.height {
            cells.push((x, y + 1));
        }
        if include_diagonal {
            if x > 0 && y > 0 {
                cells.push((x - 1, y - 1));
            }
            if x < self.width && y > 0 {
                cells.push((x + 1, y - 1));
            }
            if x > 0 && y < self.height {
                cells.push((x - 1, y + 1));
            }
            if x < self.width && y < self.height {
                cells.push((x + 1, y + 1));
            }
        }
        cells
    }
}

impl std::str::FromStr for GridMap {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let mut map = HashMap::new();
        let mut width = 0;
        let mut height = 0;

        for (y, line) in s.lines().enumerate() {
            height = y as i32;
            for (x, c) in line.chars().enumerate() {
                width = x as i32;
                map.insert((x as i32, y as i32), c);
            }
        }

        Ok(GridMap { map, width, height })
    }
}

impl std::fmt::Display for GridMap {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        for y in 0..=self.height {
            for x in 0..=self.width {
                write!(f, "{}", self.map.get(&(x, y)).unwrap())?;
            }
            writeln!(f)?;
        }

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_grid_map() {
        let input = "....\n....\n....\n....\n";
        let grid = input.parse::<GridMap>().unwrap();
        assert_eq!(grid.width, 3);
        assert_eq!(grid.height, 3);
    }

    #[test]
    fn test_adjacent_cells() {
        let input = "....\n....\n....\n....\n";
        let grid = input.parse::<GridMap>().unwrap();
        assert_eq!(
            grid.adjacent_cells(0, 0, true),
            vec![(1, 0), (0, 1), (1, 1)]
        );
        assert_eq!(
            grid.adjacent_cells(1, 1, false),
            vec![(0, 1), (2, 1), (1, 0), (1, 2)]
        );
        assert_eq!(grid.adjacent_cells(3, 3, false), vec![(2, 3), (3, 2)]);
    }
}
