# http://adventofcode.com/2017/day/8

defmodule Day8 do
  def largest_value(file) do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_instruction/1)
    |> Enum.into([])
    |> calculate()
    |> Enum.max()
  end

  defp calculate(instructions) do
    calculate(instructions, %{})
  end

  defp calculate([], store), do: store
  defp calculate([ins | rest], store) do
    case run_cond(ins, store) do
      true  -> calculate(rest, run_ins(ins, store))
      false -> calculate(rest, store)
    end
  end

  defp run_ins({reg, ins, val, _}, store) do
    stored = Map.get(store, reg, 0)
    case ins do
      "inc" -> Map.put(store, reg, stored + val)
      "dec" -> Map.put(store, reg, stored - val)
    end
  end

  defp run_cond({_, _, _, {ins, op, right}}, store) do
    Map.get(store, ins, 0) |> run_cond(op, right)
  end
  defp run_cond(l, ">", r),  do: l > r
  defp run_cond(l, "<", r),  do: l < r
  defp run_cond(l, "==", r), do: l == r
  defp run_cond(l, "!=", r), do: l != r
  defp run_cond(l, "<=", r), do: l <= r
  defp run_cond(l, ">=", r), do: l >= r

  defp parse_instruction([reg, op, val, "if", c_reg, c_op, c_val]) do
    {reg, op, String.to_integer(val), {c_reg, c_op, String.to_integer(c_val)}}
  end
  defp parse_instruction(string) do
    parse_instruction String.split(string)
  end
end

Day8.largest_value("res/day8.txt")
|> IO.inspect()
