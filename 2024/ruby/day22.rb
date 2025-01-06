#!/usr/bin/env ruby

numbers = DATA.readlines.map.with_index { [_2, _1.to_i] }.to_h
2000.times {
  numbers.each { |i, n|
    n = ((n * 64) ^ n) % 16777216
    n = ((n / 32) ^ n) % 16777216
    n = ((n * 2048) ^ n) % 16777216
    numbers[i] = n
  }
}
p1 = numbers.values.sum

puts "P1: #{p1}"

__END__
1
10
100
2024
