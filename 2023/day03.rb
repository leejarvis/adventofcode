#!/usr/bin/env ruby

input = DATA.readlines.map(&:chomp)
numbers = input.each_with_object([]).with_index do |(r, n), y|
  r.scan(/\d+/) { n << [_1, y, $~.offset(0)[0]] }
end

def symbol?(value)
  !value.nil? && value != "." && value !~ /\d+/
end

def part_number?(input, y, x)
  (y-1..y+1).any? { |y| (x-1..x+1).any? { |x| symbol?(input[y] && input[y][x]) } }
end

sum = numbers.select do |n, y, x|
  (x..(x+n.size)).any? { |dx| input[y][dx] =~ /\d+/ && part_number?(input, y, dx) }
end.map(&:first).sum(&:to_i)
p sum

__END__
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
