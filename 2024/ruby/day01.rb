#!/usr/bin/env ruby

left, right = DATA.readlines.map { _1.scan(/\d+/).map(&:to_i) }.transpose

left.sort.zip(right.sort).reduce(0) { |sum, (a, b)|
  sum += (a - b).abs
}.then { puts "P1: #{_1}" }

left.zip(right).reduce(0) { |sum, (a, b)|
  sum += a * right.count(a)
}.then { puts "P2: #{_1}" }

__END__
3   4
4   3
2   5
1   3
3   9
3   3
