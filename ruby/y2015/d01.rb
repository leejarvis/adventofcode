input = File.read("input/d01.txt").chomp.chars
p1, p2 = 0, 0

input.each_with_index do |c, i|
  p1 += (c == "(" ? 1 : -1)
  p2 = i if p2 == 0 && p1 == -1
end

p [p1, p2]
