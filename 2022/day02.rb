#!/usr/bin/env ruby

moves = {
  ["A", "Y"] => [2 + 6, 1 + 3],
  ["B", "X"] => [0 + 1, 0 + 1],
  ["C", "Z"] => [3 + 3, 6 + 1],
  ["B", "Y"] => [3 + 2, 3 + 2],
  ["A", "Z"] => [0 + 3, 6 + 2],
  ["B", "Z"] => [6 + 3, 6 + 3],
  ["C", "Y"] => [0 + 2, 3 + 3],
  ["C", "X"] => [6 + 1, 0 + 2],
  ["A", "X"] => [3 + 1, 0 + 3],
}

File.readlines("input/day02.txt")
  .map { _1.strip.chars.tap { |e| e.delete_at(1) } }
  .tap { p _1.reduce(0) { |a, s| a + moves[s][0] } }
  .tap { p _1.reduce(0) { |a, s| a + moves[s][1] } }
