#!/usr/bin/env ruby

require_relative "intcode"

program = File.read("res/day19.txt").split(",").map(&:to_i)
area = 0

50.times do |y|
  50.times do |x|
    area += Intcode.run(program.dup, [x, y]).first
  end
end

p area

# I don't recommend running this
10_000.times do |y|
  10_000.times do |x|
    if Intcode.run(program.dup, [x + 99, y]).first == 1
      if Intcode.run(program.dup, [x, y + 99]).first == 1
        p x * 10_000 + y
        exit
      end
    end
  end
end
