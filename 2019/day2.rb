#!/usr/bin/env ruby

i = File.read("res/day2.txt").split(",").map(&:to_i)
i[1],i[2]=12,2
i.each_slice(4){|d,k,v,o|d==99 ? break : i[o]=i[k].send(d==1 ? :+ : :*,i[v])}
p i[0]
