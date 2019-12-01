#!/usr/bin/env ruby

puts File.readlines("res/day1.txt").map { |x| (x.to_i / 3).to_i - 2 }.sum
