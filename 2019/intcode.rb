class Intcode
  def self.run(program, input)
    new(program).run(input)
  end

  attr_reader :program, :pos

  def initialize(program)
    @program = program
    @pos = 0
    @rel = 0
    @input = []
    @output = []
  end

  def run(input = [])
    @input += Array(input)
    @output = []
    shifts = [0, 4, 4, 2, 2, 3, 3, 4, 4, 2]

    while (op = program[pos]) != 99 do
      p1, p2, p3 = (1..3).map { |i|
        [
          program[pos + i],
          pos + i,
          program[pos + i].to_i + @rel,
        ][(op / 10 ** (i + 1).to_i % 10)]
      }

      op = op % 100
      return @output if op == 3 && @input.none?

      @pos += shifts[op]

      case op
      when 1; program[p3] = program[p1] + program[p2]
      when 2; program[p3] = program[p1] * program[p2]
      when 3; program[p1] = @input.shift
      when 4; @output.push(program[p1])
      when 5; @pos = program[p2] if program[p1] != 0
      when 6; @pos = program[p2] if program[p1] == 0
      when 7; program[p3] = program[p1] < program[p2] ? 1 : 0
      when 8; program[p3] = program[p1] == program[p2] ? 1 : 0
      when 9; @rel += program[p1]
      else  ; raise "Unknown opcode `#{op}'"
      end
    end

    @output
  end
end

if $0 == __FILE__
  program = File.read("res/day9.txt").strip.split(",").map(&:to_i)

  p Intcode.run(program, 1)
  p Intcode.run(program, 2)
end
