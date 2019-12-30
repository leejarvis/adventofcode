#!/usr/bin/env ruby

require "set"

def traverse
  5.times do |y|
    5.times do |x|
      yield x, y
    end
  end
end

def neighbugcount(map, x, y)
  [[x, y - 1], [x + 1, y], [x, y + 1], [x - 1, y]].count do |c|
    map[c] == "#"
  end
end

def change(map)
  map.dup.tap do |m2|
    traverse do |x, y|
      if map[[x, y]] == "#"
        m2[[x, y]] = neighbugcount(map, x, y) == 1 ? "#" : "."
      else
        m2[[x, y]] = [1, 2].include?(neighbugcount(map, x, y)) ? "#" : "."
      end
    end
  end
end

map = File.readlines("res/day24.txt").each_with_index.with_object({}) do |(line, y), m|
  line.strip.chars.each_with_index do |c, x|
    m[[x, y]] = c
  end
end

ratings = Set.new

loop do
  map = change(map)
  rating = 0

  traverse do |x, y|
    rating += 2 ** (5 * y + x) if map[[x, y]] == "#"
  end

  if ratings.include?(rating)
    p rating
    exit
  else
    ratings << rating
  end
end
