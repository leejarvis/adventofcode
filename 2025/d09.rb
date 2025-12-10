def bounds(p1, p2)
  x1, y1 = p1
  x2, y2 = p2
  [[x1, x2].min, [y1, y2].min, [x1, x2].max, [y1, y2].max]
end

def area(rect)
  l, t, r, b = rect
  (r - l + 1) * (b - t + 1)
end

def overlap?(a, b)
  al, at, ar, ab = a
  bl, bt, br, bb = b
  al < br && at < bb && ar > bl && ab > bt
end

input = File.readlines("input/d09.txt", chomp: true).map { _1.scan(/\d+/).map(&:to_i) }
rects = input.combination(2).map { |p1, p2| bounds(p1, p2) }.sort_by { |r| -area(r) }
lines = input.each_cons(2).map { |(p1, p2)| bounds(p1, p2) } + [bounds(input.last, input.first)]
rect = rects.find { |rect| lines.none? { overlap?(rect, _1) } }

p [area(rects.first), area(rect)]
