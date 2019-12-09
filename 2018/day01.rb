#!/usr/bin/env ruby

require "set"

lines = File.readlines("res/day1.txt")
puts lines.sum(&:to_i)

n = 0
seen = Set.new
puts lines.cycle { |x|
  n += x.to_i
  break n if seen.include?(n)
  seen << n
}
