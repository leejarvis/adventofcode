#!/usr/bin/env ruby

i = File.read("res/day2.txt").split(",").map(&:to_i)
k,i[1],i[2],c=0,12,2
c=i[k]
while c != 99
  c=i[k+=i[k+1,3].tap{|l,r,x|i[x]=i[l].send(c==1 ? :+ : :*,i[r])}.size+1]
end
p i[0]
