#!/usr/bin/env ruby

require "set"
require_relative "intcode"

program = File.read("res/day23.txt").strip.split(",").map(&:to_i)
computers = 50.times.map.with_index { |_, i| Intcode.new(program).tap { |r| r.run(i) } }
queues = 50.times.map { [] }

nat = [0, 0]
seen = Set.new

loop do
  if queues.all?(&:none?) && computers.all? { |c| c.output_items.none? }
    p nat[1] if seen.include?(nat[1])

    seen << nat[1]
    queues[0].concat nat
  end

  50.times do |i|
    computer = computers[i]

    if computer.output_items.size == 3
      c, x, y = computer.output_items
      computer.output_items.clear

      if c == 255
        p y
        nat = [x, y]
      end

      queues[c] << x
      queues[c] << y
    else
      if queues[i].none?
        computer.run -1
      else
        computer.run queues[i].shift
      end
    end
  end
end
