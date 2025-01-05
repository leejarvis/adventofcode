class Point < Data.define(:x, :y)
  def add(x, y)
    Point[self.x + x, self.y + y]
  end

  def north
    Point[self.x, self.y - 1]
  end

  def south
    Point[self.x, self.y + 1]
  end

  def east
    Point[self.x + 1, self.y]
  end

  def west
    Point[self.x - 1, self.y]
  end

  def advance(direction, amount = 1)
    Point[x + direction.x * amount, y + direction.y * amount]
  end

  def manhattan_distance(other)
    (x - other.x).abs + (y - other.y).abs
  end

  def neighbours
    [[0, -1], [1, 0], [0, 1], [-1, 0]].map { |(x, y)|
      add(x, y)
    }
  end

  def to_s
    "(#{x}, #{y})"
  end

  # What direction is this point from the other point?
  def dir_from(other)
    dx = x - other.x
    dy = y - other.y

    case [dx, dy]
      when [0, -1] then Direction.north
      when [1, 0] then Direction.east
      when [0, 1] then Direction.south
      when [-1, 0] then Direction.west
    end
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

  def to_s
    case self
    when Direction.north then "N"
    when Direction.east then "E"
    when Direction.south then "S"
    when Direction.west then "W"
    end
  end
end

class Grid
  include Enumerable

  def self.parse(data, &block)
    data = data.read if data.respond_to?(:read)
    rows = data.strip.split("\n").map { _1.strip.chars }
    new(rows: rows)
  end

  def self.square(size, value = 0)
    new(rows: Array.new(size) { Array.new(size, value) })
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

  def first_point
    @first_point ||= Point[0, 0]
  end

  def last_point
    @last_point ||= Point[height - 1, width - 1]
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

  def neighbours(point)
    [[0, -1], [1, 0], [0, 1], [-1, 0]].map { |(x, y)|
      point.add(x, y)
    }
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

  def each_point(matching: nil, &block)
    return enum_for(:each_point) unless block_given?

    each_with_index { |row, y|
      row.each_with_index { |c, x|
        yield Point[x, y] if matching.nil? || matching == c
      }
    }
  end

  def display
    each do |row|
      row.each { print _1 }
      puts "\n"
    end
  end
end
