#!/usr/bin/env ruby

require_relative "grid"

SIZE = 7 # 71 for real input
BYTES = 12 # 1024 for real input

def solve(grid)
  distances = { grid.first_point => 0 }
  queue = [grid.first_point]

  while (point = queue.shift)
    return distances[point] if point == grid.last_point

    grid.neighbours(point).each { |neighbour|
      next unless grid.at(neighbour) == "." && !distances.key?(neighbour)
      distances[neighbour] = distances[point] + 1
      queue << neighbour
    }
  end
end

points = DATA.readlines.map { _1.scan(/\d+/).map(&:to_i) }.map {|(x, y)| Point[x, y] }

Grid.square(SIZE, ".").tap do |grid|
  points.first(BYTES).each { grid.put(_1, "#") }

  puts "P1: #{solve(grid)}"

  grid.reset!

  # lol whatever
  points.each do |point|
    grid.put(point, "#")
    if solve(grid).nil?
      puts "P2: #{point}"
      break
    end
  end
end

__END__
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
