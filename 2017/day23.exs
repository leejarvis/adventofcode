# http://adventofcode.com/2017/day/23

defmodule Day23 do
  def solve() do
    state() |> run() |> Map.get(:mult)
  end

  defp run(state) do
    case Enum.at(state.instructions, state.pos) do
      nil -> state
      ins -> state |> run(ins) |> run()
    end
  end

  defp run(state, ["set", reg, val]) do
    update_reg(state, reg, fn(_) -> getval(state, val) end) |> advance()
  end
  defp run(state, ["sub", reg, val]) do
    update_reg(state, reg, fn(v) -> v - getval(state, val) end) |> advance()
  end
  defp run(state, ["mul", reg, val]) do
    update_reg(state, reg, fn(v) -> v * getval(state, val) end) |> mult() |> advance()
  end
  defp run(state, ["jnz", reg, val]) do
    case Map.get(state.registers, reg) do
      0 -> state |> advance()
      _ -> state |> advance(val)
    end
  end

  defp mult(state = %{mult: m}), do: %{state | mult: m + 1}

  defp getval(%{registers: regs}, val), do: Map.get(regs, val, val)

  defp advance(state = %{pos: pos}, v \\ 1), do: %{state | pos: pos + v}

  defp update_reg(state, reg, fun) do
    put_in(state.registers[reg], fun.(Map.get(state.registers, reg, 0)))
  end

  defp state() do
    %{registers: registers(), pos: 0, mult: 0, instructions: instructions()}
  end

  defp registers() do
    for x <- ?a..?h, into: %{}, do: {<<x::utf8>>, 0}
  end

  defp instructions() do
    File.stream!("res/day23.txt")
    |> Stream.map(&parse/1)
    |> Enum.into([])
  end

  defp parse(line), do: String.split(line) |> Enum.map(&parse_arg/1)
  defp parse_arg(arg) do
    case Integer.parse(arg) do
      {int, ""} -> int
      :error -> arg
    end
  end
end

Day23.solve() |> IO.inspect()
