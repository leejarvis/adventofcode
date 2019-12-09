#!/usr/bin/env ruby

class Circle
  def initialize(items)
    @left, @right = items, []
  end

  def rotate(n)
    n.abs.times {
      if n > 0
        @right, @left = @left, [] if @right.empty?
        push @right.shift
      else
        @left, @right = @right, [] if @left.empty?
        @right.unshift @left.pop
      end
    }
  end

  def push(v)
    @left.push v
  end

  def pop
    @left.empty? ? @right.pop : @left.pop
  end
end

def play(players, marbles)
  scores = Array.new(players, 0)
  circle = Circle.new([0])

  1.upto(marbles) { |marble|
    if marble % 23 == 0
      circle.rotate(-7)
      scores[marble % players] += marble + circle.pop
      circle.rotate(1)
    else
      circle.rotate(1)
      circle.push(marble)
    end
  }

  scores.max
end

puts play(439, 71307)
puts play(439, 71307 * 100)
