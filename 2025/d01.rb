# rubocop:disable all

input = File.readlines("input/d01.txt")
dial, p1, p2 = 50, 0, 0

input.each do |ins|
  ins[1..].to_i.times do
    dial += ins[0] == "R" ? 1 : -1
    dial = 99 if dial == -1
    dial = 0 if dial == 100
    p2 += 1 if dial == 0
  end
  p1 += 1 if dial == 0
end

p [p1, p2]

__END__
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
