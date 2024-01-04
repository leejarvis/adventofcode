#!/usr/bin/env ruby

require "set"

NEIGHBOURS = {
  ?| => [[0, 1], [0, -1]],
  ?- => [[1, 0], [-1, 0]],
  ?L => [[1, 0], [0, -1]],
  ?J => [[-1, 0], [0, -1]],
  ?7 => [[-1, 0], [0, 1]],
  ?F => [[1, 0], [0, 1]],
  ?S => [[1, 0], [-1, 0], [0, 1], [0, -1]],
  ?. => [[1, 0], [-1, 0], [0, 1], [0, -1]],
}

map = DATA.readlines.each_with_object({}).with_index do |(line, map), y|
  line.chomp.chars.each_with_index do |c, x|
    map[[x, y]] = c
  end
end
start = map.find { _2 == ?S }.first

def loop(map, start)
  visited, stack = Set.new, [start]

  until stack.empty?
    point = stack.pop

    NEIGHBOURS[map[point]].each do |dx, dy|
      next_point = [point[0] + dx, point[1] + dy]
      break if next_point == start
      next if [".", nil].include?(map[next_point]) || visited.include?(next_point)

      stack << next_point
      visited << next_point
    end
  end

  visited
end

p (loop(map, start).size / 2.0).ceil

__END__
..F7.
.FJ|.
SJ.L7
|F--J
LJ...
