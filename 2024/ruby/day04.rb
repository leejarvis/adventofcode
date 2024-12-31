#!/usr/bin/env ruby

GRID = DATA.readlines.map { _1.chomp.chars }
DIRS = [[1, 0], [0, 1], [0, -1], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]

def at(point)
  x, y = point
  return if x < 0 or y < 0
  return unless (row = GRID[y])
  row[x]
end

def xmas_count(point)
  return 0 unless at(point) == "X"
  x, y = point
  count = 0

  DIRS.each { |(dx, dy)|
    (0..3).reduce("") { |word, delta|
      if (letter = at([x + delta * dx, y + delta * dy]))
        word + letter
      else
        word
      end
    }.tap { count += 1 if _1 == "XMAS" }
  }

  count
end

def x_mas?(point)
  return unless at(point) == "A"
  x, y = point

  d1 = [at([x - 1, y - 1]), at([x + 1, y + 1])].compact.sort
  d2 = [at([x - 1, y + 1]), at([x + 1, y - 1])].compact.sort

  d1 == %w[M S] && d2 == %w[M S]
end

p1 = p2 = 0

GRID.each_with_index { |row, y|
  row.each_index { |x|
    p1 += xmas_count([x, y])
    p2 += 1 if x_mas?([x, y])
  }
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
