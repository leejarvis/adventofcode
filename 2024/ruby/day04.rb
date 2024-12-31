#!/usr/bin/env ruby

require_relative "grid"

GRID = Grid.parse(DATA)
DIRS = [[1, 0], [0, 1], [0, -1], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]

def xmas_count(point)
  return 0 unless GRID.at(point) == "X"
  count = 0

  DIRS.each { |(dx, dy)|
    (0..3).reduce("") { |word, delta|
      if (letter = GRID.at(point.add(delta * dx, delta * dy)))
        word + letter
      else
        word
      end
    }.tap { count += 1 if _1 == "XMAS" }
  }

  count
end

def x_mas?(point)
  return unless GRID.at(point) == "A"

  d1 = [GRID.at(point.x - 1, point.y - 1), GRID.at(point.x + 1, point.y + 1)].compact.sort
  d2 = [GRID.at(point.x - 1, point.y + 1), GRID.at(point.x + 1, point.y - 1)].compact.sort

  d1 == %w[M S] && d2 == %w[M S]
end

p1 = p2 = 0

GRID.each_point { |point|
  p1 += xmas_count(point)
  p2 += 1 if x_mas?(point)
}

puts "P1: #{p1}"
puts "P2: #{p2}"

__END__
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
