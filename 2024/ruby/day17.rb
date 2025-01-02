#!/usr/bin/env ruby

registers, program = DATA.read.split("\n\n").map { _1.scan(/\d+/).map(&:to_i) }
pointer, output = 0, []

until pointer > program.size
  opcode, operand = program.values_at(pointer, pointer + 1)
  combo = (4..6).include?(operand) ? registers[operand - 4] : operand

  case opcode
  when 0
    registers[0] = registers[0] / (2 ** combo)
  when 1
    registers[1] = registers[1] ^ operand
  when 2
    registers[1] = combo % 8
  when 3
    pointer = operand - 2 unless registers[0] == 0
  when 4
    registers[1] = registers[1] ^ registers[2]
  when 5
    output << combo % 8
  when 6
    registers[1] = registers[0] / (2 ** combo)
  when 7
    registers[2] = registers[0] / (2 ** combo)
  end

  pointer += 2
end

puts "P1: #{output.join(",")}"

__END__
Register A: 62769524
Register B: 0
Register C: 0

Program: 2,4,1,7,7,5,0,3,4,0,1,7,5,5,3,0

