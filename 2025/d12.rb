# it's a trap

*, regions = File.read("input/d12.txt").split("\n\n")
p1 = regions.split("\n").count do |region|
  w, h, *nums = region.scan(/\d+/).map(&:to_i)
  (w * h) > nums.sum * 7
end

p p1
