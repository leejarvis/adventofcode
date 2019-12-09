#!/usr/bin/env ruby

require "set"

D = ->(x, y, px, py) { (x - px).abs + (y - py).abs }

points = File.readlines("res/day6.txt").map { |s| s.scan(/\d+/).map(&:to_i) }
x_min, x_max = points.map(&:first).minmax
y_min, y_max = points.map(&:last).minmax
counter = Hash.new(0)

(y_min..y_max).each do |y|
  (x_min..x_max).each do |x|
    distances = points.map.with_index { |p, i| [D.(x, y, *p), i] }.sort

    if distances[0][0] != distances[1][0]
      d = distances[0][1]

      if x == x_min || y == y_min || x == x_max || y == y_max
        counter.delete d
      else
        counter[d] += 1
      end
    end
  end
end

# part 1
puts counter.values.max

# part 2
inc = 0
(y_min..y_max).each do |y|
  (x_min..x_max).each do |x|
    inc += 1 if points.sum { |p| D.(x, y, *p) } < 10_000
  end
end
puts inc
