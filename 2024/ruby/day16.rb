#!/usr/bin/env ruby

require "set"
require_relative "grid"

def solve(grid)
  start_point, end_point = grid.point("S"), grid.point("E")
  direction = Direction.east
  scores = Hash.new(Float::INFINITY).tap { _1[start_point] = 0 }
  queue = [[start_point, direction]]
  visited = Set.new

  while (pos = queue.shift)
    visited << pos
    point, dir = pos

    return scores[point] if point == end_point

    grid.neighbours(point).each { |neighbour|
      next if grid.at(neighbour) == "#"
      next if visited.member?([neighbour, dir])

      new_dir = neighbour.dir_from(point)
      score = 1
      score += 1000 if new_dir != dir
      new_score = scores[point] + score

      next if scores[neighbour] <= new_score

      scores[neighbour] = new_score
      queue << [neighbour, new_dir]
    }

    # poor-dev's priority queue
    queue.sort_by! { |(point, _)| scores[point] }
  end
end

grid = Grid.parse(DATA)
p1 = solve(grid)

puts "P1: #{p1}"

__END__
###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############
