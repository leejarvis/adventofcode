#!/usr/bin/env ruby

File.readlines("res/day1.txt").map(&:to_i).tap do |i|
  # one
  p i.sum { |mod| (mod / 3).to_i - 2 }

  # two
  p (f = 0) && i.each { |m| loop { ((m = (m / 3).to_i - 2) && m > 0) ? f += m : break } } && f
end
