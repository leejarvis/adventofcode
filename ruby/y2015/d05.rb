def nice_1?(str)
  return false if %w[ab cd pq xy].any? { |b| str.include?(b) }
  return false unless str.scan(/[aeiou]/).count >= 3

  str.scan(/(.)\1/).any?
end

def nice_2?(str)
  str.scan(/(..).*\1/).any? && str.scan(/(.).\1/).any?
end

input = File.readlines("input/d05.txt", chomp: true)
p1 = input.count { |str| nice_1?(str) }
p2 = input.count { |str| nice_2?(str) }

p [p1, p2]
