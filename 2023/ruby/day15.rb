#!/usr/bin/env ruby

p DATA.read.chomp.split(",").sum { |word| word.chars.each.reduce(0) { (_1 + _2.ord) * 17 % 256 } }

__END__
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
