#!/usr/bin/env ruby

# This is horrible due to lack of priority queue in ruby and also because I
# couldn't be bothered to actually optimize it. So, grab a coffee.

require "set"

GRID = DATA.readlines.each_with_object({}).with_index do |(row, grid), r|
  row.chomp.chars.each_with_index do |val, c|
    grid[[r, c]] = val.to_i
  end
end

def travel(grid)
  queue, visited = [[0, 0, 0, 0, 0]], Set.new
  finish = grid.keys.max
  moves = 3

  until queue.empty?
    queue.sort_by!(&:first)
    heat, r, c, pr, pc = queue.shift
    return heat if [r, c] == finish

    next if visited.include?([r, c, pr, pc])
    visited << [r, c, pr, pc]

    options = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    options.reject! { |dr, dc| [[pr, pc], [-pr, -pc]].include?([dr, dc]) }
    options.each do |dr, dc|
      rr, cc, h = r, c, heat
      moves.times do |i|
        rr += dr
        cc += dc
        if grid.include?([rr, cc])
          h += grid[[rr, cc]]
          queue << [h, rr, cc, dr, dc]
        end
      end
    end
  end
end

p travel(GRID)

__END__
2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533
