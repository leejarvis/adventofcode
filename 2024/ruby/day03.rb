#!/usr/bin/env ruby

parts = DATA.scan(/mul\((\d+),(\d+)\)/)

p parts

__END__
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
