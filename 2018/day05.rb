#!/usr/bin/env ruby

def react(input)
  input.each_char.with_object([]) { |c, s|
    if s.empty?
      s << c
    else
      (s[-1].ord - c.ord).abs == 32 ? s.pop : s.push(c)
    end
  }.size
end

input = File.read("res/day5.txt").chomp

# part 1
puts react(input)

# part 2
puts ('a'..'z').map { |c| react(input.gsub(/#{c}/i, "")) }.min
