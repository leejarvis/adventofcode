#!/usr/bin/env ruby

require "set"

input = File.readlines("res/day1.txt").map { |v| [v[0], v[1..-2].to_i] }
part1 = input.reduce(0) { |a, (op, n)| a.send(op, n) }
puts "Part 1: #{part1}"

freq = 0
seen = Set.new
part2 = input.cycle { |(op, n)|
  freq = freq.send(op, n)
  break freq if seen.include?(freq)
  seen << freq
}
puts "Part 2: #{part2}"
