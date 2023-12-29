#!/usr/bin/env ruby

steps, map = DATA.read.split("\n\n")
steps = steps.chars.map { |c| c == ?L ? 0 : 1 }
map = map.lines.map do
  key, *values = _1.scan(/[A-Z]+/)
  [key, values]
end.to_h

pos = "AAA"
finish = "ZZZ"
count = 0

steps.cycle do |step|
  count += 1
  pos = map.fetch(pos)[step]
  break if pos == finish
end

p count

__END__
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
