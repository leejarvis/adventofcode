require_relative "grid"

def remove_rolls(grid)
  grid.each_cell
    .filter_map { |x, y, c| [x, y] if c == "@" && grid.adjacent_values(x, y).count { _1 == "@" } < 4 }
    .each { |x, y| grid[x, y] = "R" }
end

grid = Grid.parse(File.read("input/d04.txt"))
removed = remove_rolls(grid)
p1 = p2 = removed.size
p2 += removed.size while (removed = remove_rolls(grid)).any?

p [p1, p2]

__END__
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
