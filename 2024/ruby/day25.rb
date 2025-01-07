#!/usr/bin/env ruby

locks = []
keys = []
count = ->(g) { g.tap(&:shift).map(&:chars).transpose.map { _1.count("#") }}
DATA.read.split("\n\n").each { |input|
  grid = input.split("\n")
  if input.start_with?("#####")
    locks << count.(grid)
  else
    keys << count.(grid.reverse)
  end
}

def fits?(key, lock)
  key.each_with_index { |k, i|
    return false if (k + lock[i]) > 5
  }
  true
end

p1 = 0
keys.each { |key|
  locks.each { |lock|
    p1 += 1 if fits?(key, lock)
  }
}
p p1

__END__
#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
