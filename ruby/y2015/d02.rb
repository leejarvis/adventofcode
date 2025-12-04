def area(l, w, h)
  sides = [l*w, w*h, h*l]
  sides.map { 2 * _1 }.sum + sides.min
end

def ribbon(l, w, h)
  [l+w, w+h, h+l].min * 2 + l*w*h
end

input = File.readlines("input/d02.txt", chomp: true)
p1, p2 = 0, 0

input.each do |present|
  parts = present.split("x").map(&:to_i)
  p1 += area(*parts)
  p2 += ribbon(*parts)
end

p [p1, p2]
