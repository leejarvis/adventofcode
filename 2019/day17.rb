#!/usr/bin/env ruby

require_relative "intcode"

class Grid
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def at(row, col)
    grid[row] && grid[row][col]
  end

  def each_with_index
    grid.each_with_index do |row, rindex|
      row.each_with_index do |col, cindex|
        yield row, rindex, col, cindex
      end
    end
  end

  def intersections
    o = []
    each_with_index do |r, rx, c, cx|
      if c == "#" &&
        at(rx - 1, cx) == "#" &&
        at(rx + 1, cx) == "#" &&
        at(rx, cx + 1) == "#" &&
        at(rx, cx - 1) == "#"

        o << [rx, cx]
      end
    end
    o
  end
end

program = File.read("res/day17.txt").split(",").map(&:to_i)
mapping = { "35" => "#", "46" => ".", "10" => "\n" }
output = Intcode.run(program).join.gsub(Regexp.union(mapping.keys), mapping)

grid = Grid.new(output.split("\n").map { |s| s.split("") })
# grid = Grid.new(DATA.read.split("\n").map { |s| s.split("") })

p grid.intersections.map { |top, left| top * left }.sum

p 807320 # done by hand

__END__
..#..........
..#..........
#######...###
#.#...#...#.#
#############
..#...#...#..
..#####...^..
