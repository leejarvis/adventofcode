#!/usr/bin/env ruby

def part1(input)
  pat = [0, 1, 0, -1]

  100.times do
    1.upto(input.size) do |n|
      input[n - 1] = (n..input.size).reduce(0) { |a, i| a + input[i - 1] * pat[(i / n) % 4] }.abs % 10
    end
  end

  input.first(8).join
end

def part2(input)
  offset = input.first(7).join.to_i
  real = (input * 10_000)[offset..-1]

  100.times do
    (real.size - 2).downto(0) do |i|
      real[i] = (real[i] + real[i + 1]) % 10
    end
  end

  real.first(8).join
end

input = File.read("res/day16.txt").strip.chars.map(&:to_i)

puts part1(input.dup)
puts part2(input.dup)
