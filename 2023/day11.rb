#!/usr/bin/env ruby

require "set"

map = []
galaxies = []

DATA.readlines.each_with_index do |row, y|
  row = row.chomp.chars

  row.each_with_index do |c, x|
    map[y] ||= []
    map[y][x] = c

    galaxies << [x, y] if c == ?#
  end
end

blank_rows = map.map.with_index.select { |row, _| row.all? { |c| c == ?. } }.map(&:last).to_set
blank_cols = map.transpose.map.with_index.select { |col, _| col.all? { |c| c == ?. } }.map(&:last).to_set

count = galaxies.combination(2).sum do |(x1, y1), (x2, y2)|
  c = (x1 - x2).abs + (y1 - y2).abs
  c += Range.new(*[y1, y2].sort, true).count { |y| blank_rows.include?(y) }
  c += Range.new(*[x1, x2].sort, true).count { |x| blank_cols.include?(x) }
  c
end

p count

__END__
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
