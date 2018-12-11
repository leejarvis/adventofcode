#!/usr/bin/env ruby

require "set"

all_points = File.readlines("res/day10.txt").map { |s| s.scan(/-?\d+/).map(&:to_i) }
display_points = nil
display_range = Float::INFINITY
secs = 0

loop do
  points = all_points.map { |x0, y0, x1, y1| [x0 + x1 * secs, y0 + y1 * secs] }
  y0, y1 = points.map(&:last).minmax
  current_range = y1 - y0

  break if current_range > display_range

  display_points = points
  display_range = current_range
  secs += 1
end

display_points = display_points.to_set

# part 1
Range.new(*display_points.map(&:last).minmax).each { |y|
  Range.new(*display_points.map(&:first).minmax).each { |x|
    print display_points.include?([x, y]) ? "*" : " "
  }
  puts
}

# part 2
puts secs
