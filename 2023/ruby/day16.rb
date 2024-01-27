#!/usr/bin/env ruby

require "set"

GRID = DATA.readlines.each_with_object({}).with_index do |(row, grid), r|
  row.chomp.chars.each_with_index do |val, c|
    grid[[r, c]] = val
  end
end

def energize(grid)
  queue, visited = [[[0, -1], [0, 1]]], Set.new

  until queue.empty?
    point, delta = queue.shift
    point = point.zip(delta).map(&:sum)
    dr, dc = delta

    next if grid[point].nil? || visited.include?([point, delta])
    visited << [point, delta]

    cell = grid[point]

    if cell == "." || (cell == "|" && dc == 0) || (cell == "-" && dr == 0)
      queue << [point, delta]
    elsif cell == "\\"
      queue << [point, [dc, dr]]
    elsif cell == "/"
      queue << [point, [-dc, -dr]]
    else
      queue << [point, [-dc, dr]]
      queue << [point, [dc, -dr]]
    end
  end

  visited.uniq(&:first).size
end

p energize(GRID)

__END__
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....
