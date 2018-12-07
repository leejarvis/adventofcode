#!/usr/bin/env ruby

steps = File.readlines("res/day7.txt").map { |s| s.scan(/[A-Z]\b/) }
order = []
tasks = steps.each_with_object({}) do |(left, right), t|
  (t[right] ||= []) << left
  t[left] ||= []
end

while tasks.any?
  task = tasks.select { |_, v| v.empty? }.keys.min
  tasks.delete(task)
  tasks.each { |k, v| v.delete(task) }
  order << task
end

# part 1
puts order.join

# TODO: part 2
# didn't have time :-(
