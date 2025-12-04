require_relative "../grid"

def brightness(ins)
  grid = Grid.new(width: 1000, height: 1000, value: [0, 0])
  re = /on|off|toggle|\d+/

  ins.each do |cmd|
    action, *numbers = cmd.scan(re)
    x1, y1, x2, y2 = numbers.map(&:to_i)

    x1.upto(x2) do |x|
      y1.upto(y2) do |y|
        grid[x, y] = yield action, grid[x, y]
      end
    end
  end

  grid
end

input = File.readlines("input/d06.txt", chomp: true)
grid = brightness(input) do |action, (p1, p2)|
  case action
  when "on"
    [1, p2 + 1]
  when "off"
    [0, p2 == 0 ? 0 : p2 - 1]
  when "toggle"
    [p1 == 0 ? 1 : 0, p2 + 2]
  end
end

p grid.cells.transpose.map(&:sum)
