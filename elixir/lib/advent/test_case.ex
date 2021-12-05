defmodule Advent.TestCase do
  defmacro __using__(mod: mod, part1: p1, part2: p2) do
    quote do
      use ExUnit.Case, async: true
      alias unquote(mod)
      doctest unquote(mod)

      def parsed_input do
        unquote(mod).parse_input(unquote(mod).input)
      end

      test "part 1", do: assert(unquote(mod).part1(parsed_input()) == unquote(p1))
      # test "part 2", do: assert(unquote(mod).part2(parsed_input()) == unquote(p2))
    end
  end
end
