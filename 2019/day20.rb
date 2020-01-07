#!/usr/bin/env ruby

class Cell
  attr_reader :grid, :x, :y

  def initialize(grid, x, y)
    @grid = grid
    @x = x
    @y = y
  end

  def coords
    [x, y]
  end

  def value
    grid[y] && grid[y][x]
  end

  def portal
    return unless value == "."

    [
      [grid[y - 2][x], grid[y - 1][x]].join,
      [grid[y + 1][x], grid[y + 2][x]].join,
      [grid[y][x - 2], grid[y][x - 1]].join,
      [grid[y][x + 1], grid[y][x + 2]].join,
    ].find { |x| x =~ /[A-Z]{2}/ }
  end
end

class Grid
  DELTA = [[0, -1], [0, 1], [-1, 0], [1, 0]]

  attr_reader :grid, :portals

  def initialize(grid)
    @grid = grid
    @portals = parse_portals
  end

  def each_cell
    grid.each_with_index do |row, y|
      row.each_with_index do |_, x|
        yield Cell.new(self, x, y)
      end
    end
  end

  def [](v); grid[v]; end

  def at(pos)
    x, y = pos
    grid[y] && grid[y][x]
  end

  def start_point
    portals["AA"].first
  end

  def finish_point
    portals["ZZ"].first
  end

  def path(edges, start)
    current = start
    path = []

    while current = edges[current]
      path.unshift current
    end

    path
  end

  def search
    queue = [start_point]
    edges = { start_point => nil }

    while current = queue.shift
      return path(edges, current) if current == finish_point

      DELTA.each do |dx, dy|
        pos = [current[0] + dx, current[1] + dy]

        if at(pos) =~ /[A-Z]/ && links[current]
          pos = links[current]
        end

        if at(pos) == "." && !edges.key?(pos)
          queue << pos
          edges[pos] = current
        end
      end
    end
  end

  private

  def links
    @links ||= portals.values.each_with_object({}) do |(a, b), links|
      if a && b
        links[a] = b
        links[b] = a
      end
    end
  end

  def parse_portals
    portals = Hash.new { |h, k| h[k] = [] }

    each_cell do |cell|
      portal = cell.portal

      portals[portal] << cell.coords if portal
    end

    portals
  end
end


grid = File.readlines("res/day20.txt").map(&:chomp).map { |row| row.split("") }
grid = Grid.new(grid)

path = grid.search

p path.size
