#!/usr/bin/env ruby

input = File.readlines("res/day3.txt").map { |line| line.scan(/\d+/).map(&:to_i) }
fabric = {}

input.each do |id, x, y, width, height|
  height.times { |h|
    width.times { |w|
      (fabric["#{x + w}x#{y + h}"] ||= []) << id
    }
  }
end

puts fabric.count { |pos, ids| ids.size > 1 }

input.each do |id, x, y, width, height|
  match = height.times.all? { |h|
    width.times.all? { |w|
      fabric["#{x + w}x#{y + h}"] == [id]
    }
  }

  puts id if match
end
