#!/usr/bin/env ruby

MAPPING = { ?A => "E", ?K => "D", ?Q => "C", ?J => "B", ?T => "A" }

def type(hand)
  group = hand.chars.tally
  size, max_v = group.size, group.values.max

  return 0 if size == 1
  return 1 if size == 2 && max_v == 4
  return 2 if size == 2 && max_v == 3
  return 3 if size == 3 && max_v == 3
  return 4 if size == 3 && max_v == 2
  return 5 if size == 4 && max_v == 2

  6
end

def compare(h1, h2)
  t1, t2 = type(h1), type(h2)
  return t1 <=> t2 if t1 != t2

  h1.chars.zip(h2.chars).each do |c1, c2|
    if c1 != c2
      return MAPPING.fetch(c2, c2) <=> MAPPING.fetch(c1, c1)
    end
  end
end

input = DATA.readlines.map do
   hand, rank = _1.split
   [hand, rank.to_i]
end

sorted = input.sort { |(ah, _), (bh, _)| -compare(ah, bh) }
result = sorted.each.with_index.reduce(0) do |acc, ((_, rank), i)|
  acc + rank * (i + 1)
end

p result

# p ["AAAAA", type("AAAAA") == :five_of_a_kind]
# p ["AA8AA", type("AA8AA") == :four_of_a_kind]
# p ["23332", type("23332") == :full_house]
# p ["TTT98", type("TTT98") == :three_of_a_kind]
# p ["23432", type("23432") == :two_pair]
# p ["A23A4", type("A23A4") == :one_pair]
# p ["23456", type("23456") == :high_card]

__END__
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
