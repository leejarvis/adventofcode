input = File.readlines("input/d06.txt", chomp: true)
p1 = input.map(&:split).transpose.sum { |*n, o| n.map(&:to_i).reduce(o) }

groups = [[]]
input.map { _1.reverse.split("") }.transpose.each do |col|
  if col.all? { _1 == " " }
    groups << []
    next
  end

  op = col.pop.to_sym if ["+", "*"].include?(col[-1])
  groups.last << col.reject { _1 == " " }.join
  groups.last << op if op
end

p2 = groups.map { |*n, o| n.map(&:to_i).reduce(o) }.sum

p [p1, p2]
