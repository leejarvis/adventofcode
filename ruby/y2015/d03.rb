require "set"

DIRS = { ">" => [1, 0], "<" => [-1, 0], "^" => [0, 1], "v" => [0, -1] }
def DIRS.chdir(v) = DIRS[v]

def visit(moves)
  moves.reduce([[x = 0, y = 0]].to_set) do |seen, m|
    dx, dy = DIRS.chdir(m)
    seen.add([x += dx, y += dy])
  end
end

input = File.read("input/d03.txt").chomp.chars
p1 = visit(input).size
p2 = input.partition.with_index { |_, i| i.even? }.map(&method(:visit)).reduce(:+).size

p [p1, p2]
