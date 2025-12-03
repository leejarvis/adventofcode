# rubocop:disable all

def joltage(bank, battery_size:)
  size = bank.size - battery_size
  battery = []

  bank.each_char.lazy.map(&:to_i).each do |n|
    battery.pop && size -= 1 while size > 0 && battery[-1] && battery[-1] < n
    battery << n
  end

  battery[0...battery_size].join.to_i
end

input = File.readlines("input/d03.txt", chomp: true)
p1, p2 = 0, 0
input.each do |bank|
  p1 += joltage(bank, battery_size: 2)
  p2 += joltage(bank, battery_size: 12)
end

p [p1, p2]

__END__
987654321111111
811111111111119
234234234234278
818181911112111
