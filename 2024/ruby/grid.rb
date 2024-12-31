class Point < Data.define(:x, :y)
  def add(x, y)
    Point[self.x + x, self.y + y]
  end
end

class Grid
  include Enumerable

  def self.parse(data, &block)
    data = data.read if data.respond_to?(:read)
    rows = data.strip.split("\n").map { _1.strip.chars }
    new(rows: rows)
  end

  attr_reader :rows, :height, :width

  def initialize(rows:)
    @rows = rows
    @height = rows.size
    @width = rows[0].size
  end

  def at(*point)
    point = if point.size == 2
      Point[*point]
    else
      point.first
    end

    return if point.x < 0 or point.y < 0
    return unless (row = rows[point.y])
    row[point.x]
  end

  def each(&block)
    rows.each(&block)
  end

  def each_point(&block)
    each_with_index { |row, y|
      row.each_index { |x| yield Point[x, y] }
    }
  end
end
