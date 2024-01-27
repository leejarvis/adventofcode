#!/usr/bin/env ruby

require_relative "intcode"

def part1(program)
  Intcode.run(program).each_slice(3).count { |x| x[2] == 2 }
end

def part2(program)
  program[0] = 2
  intcode = Intcode.new(program)
  paddle = score = 0

  output = intcode.run

  while output.any?
    output.each_slice(3) do |x, y, t|
      if x == -1 && y == 0
        score = t
      elsif t == 3
        paddle = x
      elsif t == 4
        if paddle < x
          output = intcode.run(1)
        elsif paddle > x
          output = intcode.run(-1)
        else
          output = intcode.run(0)
        end
      end
    end

    p score
  end

  score
end

program = File.read("res/day13.txt").strip.split(",").map(&:to_i)

p part1(program.dup)
p part2(program.dup)
