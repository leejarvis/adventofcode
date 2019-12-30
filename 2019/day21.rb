#!/usr/bin/env ruby

require_relative "intcode"

# ran through the program manually via STDIN and then added
# the result here

program = File.read("res/day21.txt").split(",").map(&:to_i)

p Intcode.run(program.dup, <<-IN.chars.map(&:ord)
NOT A J
NOT B T
OR T J
NOT C T
OR T J
AND D J
WALK
END
IN
).last

p Intcode.run(program.dup, <<-IN.chars.map(&:ord)
NOT A J
NOT B T
OR T J
NOT C T
OR T J
AND D J
NOT E T
NOT T T
OR H T
AND T J
RUN
IN
).last
