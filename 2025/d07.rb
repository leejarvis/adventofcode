input = File.readlines("input/d07.txt", chomp: true).map(&:chars)
p1, ways = 0, Array.new(input[0].size, 0)

input.each do |row|
  row.each_with_index do |ch, x|
    if ch == "S"
      ways[x] = 1
    elsif ch == "^" && ways[x] > 0
      p1 += 1
      ways[x-1] += ways[x]
      ways[x+1] += ways[x]
      ways[x] = 0
    end
  end
end
p2 = ways.sum

p [p1, p2]
