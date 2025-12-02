# rubocop:disable all

def p1_invalid?(str)
  n = str.size
  n.even? && str[0, n/2] == str[n/2, n/2]
end

def p2_invalid?(str)
  n = str.size

  (1...n).each do |m|
    next unless n % m == 0
    return true if str == str[0, m] * (n / m)
  end

  false
end

input = File.read("input/d02.txt").split(",")
p1, p2 = 0, 0
input.each do |range|
  Range.new(*range.split("-").map(&:to_i)).each do |num|
    p1 += num if p1_invalid?(num.to_s)
    p2 += num if p2_invalid?(num.to_s)
  end
end

p [p1, p2]

__END__
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124
