#!/usr/bin/env ruby

grid = DATA.readlines.map { _1.chomp.chars }
height = grid.count
width = grid.first.count
start = grid.flatten.index(?S).then { [_1 % width, _1 / width] }
visited = { start => 0 }
queue = [[start, 0]]
at = ->(pos) { grid[pos[1]]&.[](pos[0]) }

while queue.any?
  pos, step = queue.shift

  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
    next_pos = dir.zip(pos).map(&:sum)

    next unless (c = at[next_pos])
    next if c == ?#
    next if visited[next_pos]

    visited[next_pos] = step + 1
    queue << [next_pos, step + 1]
  end
end

p visited.select { _2 <= 64 && _2.even? }.count

__END__
...........
.....###.#.
.###.##..#.
..#.#...#..
....#.#....
.##..S####.
.##..#...#.
.......##..
.##.#.####.
.##..##.##.
...........
