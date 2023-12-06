#!/usr/bin/env ruby

input = DATA.readlines.map(&:chomp)

def parse_game(input, games)
  id, game = input.match(/Game (\d+): (.+)/).captures
  games[id.to_i] = game.split("; ").map do |handful|
    handful.split(", ").each_with_object({}) do |str, cubes|
      n, cube = str.split
      cubes[cube] = n.to_i
    end
  end
end

def possible?(game)
  max = ->(c) { game.map { _1[c] || 0 }.max }
  max["red"] <= 12 && max["green"] <= 13 && max["blue"] <= 14
end

p input
  .each_with_object({}, &method(:parse_game))
  .select { possible?(_2) }.keys.sum

__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
