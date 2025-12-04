# 2d grid represented as a single continuous array
class Grid
  def self.parse(input)
    cells = input.split("\n").map(&:chars)
    width = cells.first.size
    height = cells.size

    new(width: width, height: height).tap do |grid|
      cells.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          grid[x, y] = cell
        end
      end
    end
  end

  attr_reader :width, :height, :cells

  def initialize(width:, height:, value: nil)
    @width = width
    @height = height
    @cells = Array.new(width * height, value)
  end

  def [](x, y)
    return if x < 0 || y < 0 || x >= width || y >= height

    cells[y * width + x]
  end

  def []=(x, y, value)
    cells[y * width + x] = value
  end

  def each_cell(&block)
    return enum_for(:each_cell) unless block

    cells.each_with_index do |cell, i|
      block.call(i % width, i / width, cell)
    end
  end

  def adjacent_values(x, y)
    [
      [x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
      [x - 1, y], [x + 1, y],
      [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]
    ].filter_map { |nx, ny| self[nx, ny] }
  end
end
