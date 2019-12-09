#!/usr/bin/env ruby

lines = File.readlines("res/day4.txt").sort
timetable = {}
asleep = guard = nil

lines.each do |line|
  minute = line.scan(/\d+/)[4].to_i

  case line
  when /Guard \#(\d+)/
    guard = $1.to_i
    timetable[guard] ||= { total: 0, mins: Hash.new(0) }
  when /falls asleep/
    asleep = minute
  when /wakes up/
    (asleep..minute - 1).each do |min|
      timetable[guard][:total] += 1
      timetable[guard][:mins][min] += 1
    end
  end
end

# part 1
id, stats = timetable.max_by { |g, t| t[:total] }
minute, = stats[:mins].max_by(&:last)
puts id * minute

# part 2
id, stats = timetable.max_by { |g, t| t[:mins].values.max || 0 }
minute, = stats[:mins].max_by(&:last)
puts id * minute
