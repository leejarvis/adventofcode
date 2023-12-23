#!/usr/bin/env ruby

input = DATA.readlines.map { _1.scan(/\d+/).map(&:to_i) }
result = input.transpose.map do
  d = Math.sqrt(_1 ** 2 - 4 * _2)
  min = ((_1 - d) / 2 + 1).floor
  max = ((_1 + d) / 2 - 1).ceil
  max - min + 1
end.reduce(:*)

p result

__END__
Time:        49     97     94     94
Distance:   263   1532   1378   1851
