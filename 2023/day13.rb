#!/usr/bin/env ruby

def reflected_offset(grid)
  (1...grid.size).each do |offset|
    width = [offset, grid.size - offset].min

    return offset if (1..width).all? { grid[offset - _1] == grid[offset + _1 - 1] }
  end

  0
end

sum = 0

DATA.read.split("\n\n").each do
  grid = _1.lines.map { |x| x.chomp.chars }
  row = reflected_offset(grid)
  col = reflected_offset(grid.transpose)
  sum += row * 100 + col
end

p sum

__END__
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
