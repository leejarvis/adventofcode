def merge(ranges)
  ranges.sort_by(&:first).each_with_object([]) do |(s, e), m|
    if m.empty? || s > m.last[1]
      m << [s, e]
    else
      m.last[1] = [m.last[1], e].max
    end
  end
end

ranges, ids = File.read("input/d05.txt").split("\n\n")
ranges = ranges.split("\n").map { _1.scan(/\d+/).map(&:to_i) }
ids = ids.scan(/\d+/).map(&:to_i)

p1 = ids.count { |id| ranges.any? { id >= _1 && id <= _2 } }
p2 = merge(ranges).sum { _2 - _1 + 1 }

p [p1, p2]

__END__
3-5
10-14
16-20
12-18

1
5
8
11
17
32
