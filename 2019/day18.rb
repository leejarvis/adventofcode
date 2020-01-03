#!/usr/bin/env ruby

class Maze
  DELTA = [[0, -1], [0, 1], [-1, 0], [1, 0]]

  attr_reader :maze

  def initialize(maze)
    @maze = maze

    @key_mapping = create_key_mapping
    @cache = {}
  end

  def start_positions
    maze.select { |_, v| v =~ /[@1-4]/ }
  end

  def keys
    maze.select { |_, v| v =~ /[a-z]/ }
  end

  def fewest_steps(entrypoints = start_positions.values, unlocked = [])
    # Loop through each entrypoint (e.g. @, 1, 2, 3, 4) and separate
    # the distance mapping per robot so they don't clash
    @cache[[entrypoints.sort, unlocked.sort]] ||=
      entrypoints.flat_map { |from| distances(entrypoints, from, unlocked) }.min || 0
  end

  def display
    minx, maxx = maze.keys.map(&:first).minmax
    miny, maxy = maze.keys.map(&:last).minmax

    miny.upto(maxy) do |y|
      minx.upto(maxx) do |x|
        print(maze[[x, y]])
      end
      puts
    end
  end

  private

  def distances(entrypoints, from, unlocked)
    # fetch the key mapping from this current entrypoint and map a distance
    @key_mapping[from].each_with_object([]) { |(key, need, distance), d|
      # ignore this iteration if we've already got everything we need
      next if unlocked.include?(key) || (need - unlocked).any?

      # for the next iteration, replace the current robot process
      # with the next "entrypoint"
      next_positions = entrypoints.dup.tap { |n| n[n.index(from)] = key }

      # god speed
      d << distance + fewest_steps(next_positions, unlocked + [key])
    }
  end

  # For every key location, do a BFS to every other key location for
  # every collected key combination, keeping track of the distance.
  #
  # For example, starting at key `a` and finishing at `d`, if we
  # collect `b` and `c` and hit `d` after 5 moves, then we'll have
  # `{ "a" => [["d", ["b", "c"], 5]] }`
  def create_key_mapping
    start_points = keys.merge(start_positions)

    start_points.each_with_object({}) do |(kpos, key), keymap|
      queue = [[kpos, []]]
      distance = { kpos => 0 }
      collected = []

      while current = queue.shift
        pos, need = current

        DELTA.each do |dx, dy|
          next_pos = [pos[0] + dx, pos[1] + dy]
          c = maze[next_pos]

          next if c == "#" || distance.has_key?(next_pos)
          distance[next_pos] = distance[pos] + 1

          # picked up a key, record the distance to it
          collected << [c, need, distance[next_pos]] if c =~ /[a-z]/

          # It's a door, so we need the key
          if c =~ /[A-Z]/
            queue << [next_pos, need + [c.downcase]]
          else
            # no door,  keep going
            queue << [next_pos, need]
          end
        end
      end

      keymap[key] = collected
    end
  end
end

input = File.readlines("res/day18.txt")
# input = DATA.readlines

maze_input = input.map.with_index.with_object({}) do |(line, y), m|
  line.strip.chars.each_with_index do |c, x|
    m[[x, y]] = c
  end
end

maze = Maze.new(maze_input)
p maze.fewest_steps

y, x = maze.start_positions.keys.first
maze_input[[x, y]] = "#"
maze_input[[x - 1, y]] = "#"
maze_input[[x + 1, y]] = "#"
maze_input[[x, y - 1]] = "#"
maze_input[[x, y + 1]] = "#"

maze_input[[x - 1, y - 1]] = "1"
maze_input[[x + 1, y - 1]] = "2"
maze_input[[x - 1, y + 1]] = "3"
maze_input[[x + 1, y + 1]] = "4"

maze = Maze.new(maze_input)
p maze.fewest_steps


__END__
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################
