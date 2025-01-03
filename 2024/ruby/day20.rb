#!/usr/bin/env ruby

require_relative "grid"

def walk(grid)
  start_point, end_point = grid.point("S"), grid.point("E")
  distances = { start_point => 0 }
  queue = [start_point]

  while (point = queue.shift)
    return distances if point == end_point

    grid.neighbours(point).each { |neighbour|
      next if grid.at(neighbour) == "#" || distances.key?(neighbour)
      distances[neighbour] = distances[point] + 1
      queue << neighbour
    }
  end

  distances
end

# Had a few failed attempts before coming to this thanks to a hint from the subreddit.
# I doubt I would have figured this out myself. I tried:
# 1. brute force (removing all walls on each side of the track and then bfs lol)
# 2. removing parts of the wall for which the other side of the wall returned back
#    to our original path. This worked for the example but not for my input
# 3. slamming by head against the desk before looking for hints
# It's still slow but 🤷‍♂️
def time_saved(grid, walked)
  time_saved = 0

  walked.each do |p1, d1|
    walked.each do |p2, d2|
      if p1.manhattan_distance(p2) == 2
        time_saved += 1 if (d1 - d2) > 100
      end
    end
  end

  time_saved
end

grid = Grid.parse(DATA)
p1 = time_saved(grid, walk(grid))

puts "P1: #{p1}"

__END__
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
