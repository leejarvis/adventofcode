class Point < Data.define(:x, :y)
  def add(x, y)
    Point[self.x + x, self.y + y]
  end

  def advance(direction, amount = 1)
    Point[x + direction.x * amount, y + direction.y * amount]
  end
end

class Direction < Data.define(:x, :y)
  DIRS = [[0, -1], [1, 0], [0, 1], [-1, 0]]

  def self.north = self[0, -1]
  def self.east = self[1, 0]
  def self.south = self[0, 1]
  def self.west = self[-1, 0]

  def turn_left = turn(-1)
  def turn_right = turn(1)

  def turn(n)
    x, y = DIRS[(index + n) % DIRS.size]
    with(x: x, y: y)
  end

  def index
    DIRS.index([x, y])
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
    @original_rows = Marshal.dump(rows)
    @rows = rows
    @height = rows.size
    @width = rows[0].size
  end

  def reset!
    @rows = Marshal.load(@original_rows)
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

  def point(value)
    each_point { |point|
      return point if at(point) == value
    }
    nil
  end

  def move(p1, p2)
    p1_value = at(p1)
    p2_value = at(p2)

    rows[p2.y][p2.x] = p1_value
    rows[p1.y][p1.x] = p2_value
  end

  def put(point, value)
    rows[point.y][point.x] = value
  end

  def line_of_sight(point, dir)
    line = []

    next_point = point.advance(dir)
    until at(next_point).nil?
      line << next_point
      next_point = next_point.advance(dir)
    end

    line
  end

  def each(&block)
    rows.each(&block)
  end

  def each_point(&block)
    each_with_index { |row, y|
      row.each_index { |x| yield Point[x, y] }
    }
  end

  def display
    each do |row|
      row.each { print _1 }
      puts "\n"
    end
  end
end
