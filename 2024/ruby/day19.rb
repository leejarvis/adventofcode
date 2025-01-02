#!/usr/bin/env ruby

towels, designs = DATA.read.split("\n\n")
towels = towels.split(", ")
mem = { "" => 1 }
possibilities = ->(design) {
  mem[design] ||= towels.reduce(0) {
    _1 + (design.start_with?(_2) ? possibilities.(design[_2.size..]) : 0)
  }
}

possible = designs.split("\n").map(&possibilities)

p1 = possible.count { _1 > 0 }
p2 = possible.sum

puts "P1: #{p1}"
puts "P2: #{p2}"

__END__
r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb
