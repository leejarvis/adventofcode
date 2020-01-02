#!/usr/bin/env ruby

class Maze
  DELTA = [[0, -1], [0, 1], [-1, 0], [1, 0]]

  attr_reader :maze

  def initialize(maze)
    @maze = maze

    @key_mapping = create_key_mapping
    @key_distance_cache = {}
  end

  def keys
    @keys ||= maze.select { |_, v| v =~ /[a-z@]/ }
  end

  def distances(from, unlocked = [])
    @key_mapping[from].each_with_object({}) do |(key, needed_keys, distance), keys|
      next if unlocked.include?(key) || (needed_keys - unlocked).any?
      keys[key] = distance
    end
  end

  def min_steps(key, unlocked = [])
    with_key_distance_cache([key, unlocked.sort]) do
       distances(key, unlocked).map do |k, distance|
        distance + min_steps(k, unlocked + [k])
      end.min || 0
    end
  end

  private

  def with_key_distance_cache(key)
    @key_distance_cache[key] || @key_distance_cache[key] = yield
  end

  # For every key location, do a BFS to every other key location for
  # every collected key combination, keeping track of the distance.
  #
  # For example, starting at key `a` and finishing at `d`, if we
  # collect `b` and `c` and hit `d` after 5 moves, then we'll have
  # `{ "a" => [["d", ["b", "c"], 5]] }`
  def create_key_mapping
    keys.each_with_object({}) do |(kpos, key), keymap|
      queue = [[kpos, []]]
      distance = { kpos => 0 }
      collected = []

      while current = queue.shift
        pos, needed_keys = current

        DELTA.each do |dx, dy|
          next_pos = [pos[0] + dx, pos[1] + dy]
          c = maze[next_pos]

          next if c == "#" || distance.has_key?(next_pos)

          distance[next_pos] = distance[pos] + 1

          if c =~ /[a-z]/
            collected << [c, needed_keys, distance[next_pos]]
          end

          if c =~ /[A-Z]/
            queue << [next_pos, needed_keys + [c.downcase]]
          else
            queue << [next_pos, needed_keys]
          end
        end
      end

      keymap[key] = collected
    end
  end
end

input = File.readlines("res/day18.txt")
# input = DATA.readlines

maze = Maze.new(input.map.with_index.with_object({}) do |(line, y), m|
  line.chars.each_with_index do |c, x|
    m[[x, y]] = c
  end
end)

p maze.min_steps("@")

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
