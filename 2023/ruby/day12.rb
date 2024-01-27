#!/usr/bin/env ruby

C = {}

def count_arrangements(springs, numbers)
  return numbers.empty? ? 1 : 0 if springs == ""
  return springs.include?(?#) ? 0 : 1 if numbers.empty?

  if (existing = C[[springs, numbers]])
    return existing
  end

  count = 0
  spring = springs[0]

  if spring == ?. || spring == ??
    count += count_arrangements(springs[1..], numbers)
  end

  return count unless spring == ?# || spring == ??

  n = numbers[0]

  return count if n > springs.size || springs[0...n].include?(?.)
  return count if n != springs.size && springs[n] == ?#

  count += count_arrangements(springs[n+1..].to_s, numbers[1..])

  C[[springs, numbers]] = count
end

p1, p2 = 0, 0

DATA.readlines.each do |row|
  springs, numbers = row.chomp.split
  numbers = numbers.split(",").map(&:to_i)

  p1 += count_arrangements(springs, numbers)
  p2 += count_arrangements(([springs] * 5).join("?"), numbers * 5)
end

p p1
p p2

__END__
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
