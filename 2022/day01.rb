#!/usr/bin/env ruby

File.read("input/day01.txt")
  .split("\n\n")
  .map { _1.split("\n").map(&:to_i).sort.sum }
  .sort
  .tap { p _1.last }
  .then { p _1.last(3).sum }
