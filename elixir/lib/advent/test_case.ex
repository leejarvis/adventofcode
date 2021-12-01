defmodule Advent.TestCase do
  defmacro __using__(mod: mod, part1: p1, part2: p2) do
    quote do
      use ExUnit.Case, async: true
      alias unquote(mod)
      doctest unquote(mod)

      test "part 1", do: assert unquote(mod).part1() == unquote(p1)
      test "part 2", do: assert unquote(mod).part2() == unquote(p2)
    end
  end
end
