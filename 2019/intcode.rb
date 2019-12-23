class Intcode
  def self.run(program, input = nil)
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

  def run(input = nil)
    @input += Array(input)
    @output = []

    while process
    end

    @output
  end

  def process
    return false if opcode == 3 && @input.none?

    case opcode
    when 1; add
    when 2; multiply
    when 3; input
    when 4; output
    when 5; jump_if_true
    when 6; jump_if_false
    when 7; less_than
    when 8; equals
    when 9; adjust_relative_base
    when 99; return false
    end

    true
  end

  def add
    program[p3] = program[p1] + program[p2]
    @pos += 4
  end

  def multiply
    program[p3] = program[p1] * program[p2]
    @pos += 4
  end

  def input
    program[p1] = @input.shift
    @pos += 2
  end

  def output
    @output << program[p1]
    @pos += 2
  end

  def jump_if_true
    if program[p1] != 0
      @pos = program[p2]
    else
      @pos += 3
    end
  end

  def jump_if_false
    if program[p1] == 0
      @pos = program[p2]
    else
      @pos += 3
    end
  end

  def less_than
    program[p3] = (program[p1] < program[p2]) ? 1 : 0
    @pos += 4
  end

  def equals
    program[p3] = (program[p1] == program[p2]) ? 1 : 0
    @pos += 4
  end

  def adjust_relative_base
    @rel += program[p1]
    @pos += 2
  end

  private

  def p1; param(1); end
  def p2; param(2); end
  def p3; param(3); end

  def opcode
    current % 100
  end

  def current
    program[pos]
  end

  def param(n)
    div = [0, 100, 1000, 10_000][n]
    mode = (current / div) % 10

    case mode
    when 1
      pos + n # immediate
    when 2
      program[pos + n] + @rel  # relative
    else
      program[pos + n] # position
    end
  end
end


if $0 == __FILE__
  program = File.read("res/day9.txt").strip.split(",").map(&:to_i)

  p Intcode.run(program, 1)
  p Intcode.run(program, 2)
end
