#!/usr/bin/env ruby

require_relative "intcode"

class Game
  ITEMS = [
    "shell", "candy cane", "spool of cat6", "space heater",
    "weather machine", "whirled peas", "space law space brochure"
  ]

  # spoiler: shell, candy cane, weather machine

  def self.run(program, initial_commands)
    new(program, initial_commands).run
  end

  attr_reader :intcode

  def initialize(program, initial_commands)
    @intcode = Intcode.new(program)

    initial_commands.each do |command|
      send_command(command)
    end
  end

  def run
    command = nil

    loop do
      send_command(command)
      command = gets.chomp

      solve if command == "solve"
    end
  end

  private

  def send_command(command)
    command = command.chars.map(&:ord) + [10] if command
    result = intcode.run(command).map(&:chr).join
    puts result
    result
  end

  def solve
    ITEMS.each do |item|
      send_command("drop #{item}")
    end

    (1 << ITEMS.size).times do |n|
      items = ITEMS.size.times.map { |b| ITEMS[b] if (n & (1 << b)) != 0 }.compact

      puts "attempt #{n}: #{items.join(', ')}"
      items.each do |item|
        send_command("take #{item}")
      end

      res = send_command("east")
      return unless res =~ /(lighter|heavier)/

      items.each do |item|
        send_command("drop #{item}")
      end
    end
  end
end

program = File.read("res/day25.txt").split(",").map(&:to_i)
Game.run(program, DATA.readlines.map(&:chomp))

__END__
south
take spool of cat6
west
take space heater
south
take shell
north
north
take weather machine
north
west
west
take whirled peas
east
east
south
west
south
south
take space law space brochure
north
east
take candy cane
west
north
east
south
east
east
south
take hypercube
south
south
