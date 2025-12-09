def distance(p1, p2)
  (p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2 + (p1[2] - p2[2]) ** 2
end

circuits = File.readlines("input/d08.txt", chomp: true).map { [_1.scan(/\d+/).map(&:to_i)].to_set }
pairs = circuits.map(&:first).combination(2).sort_by { |a, b| distance(a, b) }
p1, p2 = 0, 0

# reminded about disjoint-set union after completing this.
# should be using that, but this seems fast enough for the problem
pairs.each_with_index do |(a, b), i|
  c1, c2 = nil, nil
  circuits.each do |c|
    c1 = c if c.include?(a)
    c2 = c if c.include?(b)
    break if c1 && c2
  end

  circuits.delete(c1)
  circuits.delete(c2)
  circuits << (c1 | c2)

  if i == 1000
    p1 = circuits.map(&:size).sort.last(3).reduce(:*)
  end

  if circuits.size == 1
    p2 = a[0] * b[0]
    break
  end
end

p [p1, p2]
