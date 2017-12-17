# http://adventofcode.com/2015/day/10

defmodule Day10 do
  def solve1(input), do: say(40, input)
  def solve2(input), do: say(50, input)

  defp say(0, prev), do: String.length(prev)
  defp say(n, prev), do: say(n - 1, do_say(prev))

  defp do_say(prev), do: do_say(prev, "")
  defp do_say(<<char::utf8, rest::binary>>, acc),
    do: do_say(rest, char, 1, acc)
  defp do_say(<<char::utf8, rest::binary>>, char, count, acc),
    do: do_say(rest, char, count + 1, acc)
  defp do_say(<<char::utf8, rest::binary>>, prev, count, acc),
    do: do_say(rest, char, 1, acc <> to_string(count) <> <<prev::utf8>>)
  defp do_say("", prev, count, acc),
    do: acc <> to_string(count) <> <<prev::utf8>>
end

Day10.solve1("1113222113")
|> IO.inspect()

Day10.solve2("1113222113")
|> IO.inspect()
