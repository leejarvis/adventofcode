#!/usr/bin/env ruby

require_relative "intcode"

DELTA = [nil, [0, -1], [0, 1], [-1, 0], [1, 0]]

def next_vec(vec, dir)
  dx, dy = DELTA[dir]
  [vec[0] + dx, vec[1] + dy]
end

def bfs(map, start, value)
  queue = [start]
  edges = { start => nil }

  while current = queue.shift
    return dirs(current, edges) if map[current] == value

    # if value
    #   puts "\e[H\e[2J"
    #   puts display(map, current)
    #   sleep 0.05
    # end

    (1..4).each do |dir|
      next_vec = next_vec(current, dir)
      next if map[next_vec] == 0 || edges.key?(next_vec)
      edges[next_vec] = [current, dir]
      queue << next_vec
    end
  end
end

def dirs(vec, edges)
  dirs = []
  while (vec, dir = edges[vec])
    dirs.unshift dir
  end
  dirs
end

def max_fill(map, start)
  queue = [[start, 0]]
  visited = [start]
  max_fill = 0

  while (current, depth = queue.shift)
    max_fill = [depth, max_fill].max

    (1..4).each do |dir|
      next_vec = next_vec(current, dir)
      next if map[next_vec] == 0 || visited.include?(next_vec)
      visited << next_vec
      queue << [next_vec, depth + 1]
    end
  end

  max_fill
end

def display(map, droid)
  minx, maxx = map.keys.map(&:first).minmax
  miny, maxy = map.keys.map(&:last).minmax
  out = ""

  miny.upto(maxy) do |row|
    minx.upto(maxx) do |col|
      if [col, row] == droid
        out << "D"
      else
        case map[[col, row]]
        when 1
          out << "#"
        when 2
          out << "*"
        else
          out << "."
        end
      end
    end
    out << "\n"
  end

  out
end

def explore(intcode, map)
  droid = [0, 0]

  while dirs = bfs(map, droid, nil)
    dirs.each do |dir|
      vec = next_vec(droid, dir)
      command = intcode.run(dir).first
      map[vec] = command
      droid = vec if command != 0 # only move the droid if there's no wall
    end
  end
end

program = File.read("res/day15.txt").split(",").map(&:to_i)
intcode = Intcode.new(program)
map = { [0, 0] => 1 }

explore(intcode, map)

p bfs(map, [0, 0], 2).size
p max_fill(map, map.key(2))
