#!/usr/bin/env ruby

parts = DATA.read.scan(/(mul\((\d+),(\d+)\)|don't\(\)|do\(\))/)
p1 = p2 = 0
enabled = true

parts.each { |(m, a, b)|
  if m == "don't()"
    enabled = false
  elsif m == "do()"
    enabled = true
  else
    sum = a.to_i * b.to_i
    p1 += sum
    p2 += sum if enabled
  end
}

puts "P1: #{p1}"
puts "P2: #{p2}"

__END__
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
