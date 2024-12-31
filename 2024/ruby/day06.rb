#!/usr/bin/env ruby

require "set"
require_relative "grid"

def simulate(grid)
  guard = grid.point("^")
  visited = Hash.new(0)
  visited[guard] = 1
  dir = Direction.north

  while (point = guard.advance(dir))
    case grid.at(point)
    when nil
      break
    when "#"
      dir = dir.turn_right
    when "."
      grid.move(guard, point)
      guard = point
      return if (visited[point] += 1) > 4
    end
  end

  visited
end

grid = Grid.parse(DATA)
visited = simulate(grid)
looped = 0

grid.reset!
visited.each_key { |point|
  next unless grid.at(point) == "."
  grid.put(point, "#")
  looped += 1 unless simulate(grid)
  grid.reset!
}

puts "P1: #{visited.size}"
puts "P2: #{looped}"

__END__
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
