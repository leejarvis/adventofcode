#!/usr/bin/env ruby

ins = DATA.readlines.map { _1.split.first(2) }
rp, cp = 0, 0
edge = 0
grid = {}

ins.each do |d, n|
  rd, cd =
    case d
    when "R" then [0, 1]
    when "L" then [0, -1]
    when "U" then [-1, 0]
    when "D" then [1, 0]
    end

  n.to_i.times do
    rp += rd
    cp += cd
    edge += 1
    grid[[rp, cp]] = "#" # keep for printability
  end
end

# https://en.wikipedia.org/wiki/Shoelace_formula

p grid.keys.each_cons(2).sum { |(r1, c1), (r2, c2)| (r2 * c1 - c2 * r1) }.abs / 2 + (edge / 2 + 1)

__END__
R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)
