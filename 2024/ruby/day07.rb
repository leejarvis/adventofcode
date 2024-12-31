#!/usr/bin/env ruby

p1_sum = p2_sum = 0

DATA.readlines.map { _1.scan(/\d+/).map(&:to_i) }.each { |sum, *eq|
  p1 = p2 = eq[..0]

  eq[1..].each do |n|
    p1 = p1.flat_map { [_1 + n, _1 * n] }
    p2 = p2.flat_map { [_1 + n, _1 * n, (_1.to_s + n.to_s).to_i] }
  end

  p1_sum += sum if p1.include?(sum)
  p2_sum += sum if p2.include?(sum)
}

puts "P1: #{p1_sum}"
puts "P2: #{p2_sum}"

__END__
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
