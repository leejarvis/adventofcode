#!/usr/bin/env ruby

require "set"

connections = DATA.readlines.each_with_object(Hash.new { _1[_2] = Set.new } ) {
  left, right = _1.chomp.split("-")
  _2[left] << right
  _2[right] << left
}

interconns = Set.new
connections.each do |c, cons|
  cons.to_a.combination(2).each do
    set = Set[c, _1, _2]
    interconns.add(set) if connections[_1].include?(_2) && set.grep(/^t/).any?
  end
end

puts "P1: #{interconns.size}"

__END__
kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn
