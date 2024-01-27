#!/usr/bin/env ruby

def tilt(input)
  input.gsub(/[O\.]+/) { _1.chars.sort.reverse.join }
end

grid = DATA.readlines.map { _1.chomp.chars }
# input grid is inbalanced, sneaky. Pad with blanks
grid = Array.new(grid.map(&:length).max) { |i| grid.map { _1[i] || "." } }
tilted_grid = grid.map { tilt(_1.join).chars }.transpose

p tilted_grid.each_with_index.sum { _1.count("O") * (_2 - grid.size).abs }

# p tilt("O.O.#.O") == "OO..#O."

__END__
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
