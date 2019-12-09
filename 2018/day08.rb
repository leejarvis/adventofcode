#!/usr/bin/env ruby

R = ->(s) {
  c, mc, *s, mt = s + [0]
  c.times { _, s = R.(s).tap { |t, _| mt += t } }
  [mt + s[0...mc].sum, s[mc..-1]]
}
puts R.(File.read("res/day8.txt").scan(/\d+/).map(&:to_i))
