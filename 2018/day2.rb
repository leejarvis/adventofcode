#!/usr/bin/env ruby

require "set"

lines = File.readlines("res/day2.txt")
two = three = 0
set = Set.new
part2 = nil

lines.each do |line|
  chars = line.split("")
  nums = chars.map { |c| chars.count(c) }

  two += 1 if nums.include?(2)
  three += 1 if nums.include?(3)

  line.length.times { |x|
    alt = line.dup.tap { |l| l[x] = " " }
    part2 = alt if set.include?(alt)
    set << alt
  }
end

puts two * three
puts part2.delete(" ")
