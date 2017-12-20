# http://adventofcode.com/2017/day/18

defmodule Day18 do
  def solve() do
    %{
      position: 0,
      registers: %{},
      instructions: instructions(),
      frequency: nil,
      done: false,
    } |> run()
  end

  defp run(%{frequency: freq, done: true}) do
    freq
  end

  defp run(state) do
    state |> execute() |> run()
  end

  defp execute(state), do: execute(state, instruction(state))

  defp execute(state, {:set, [reg, v]}) do
    state |> update_register(reg, fn(_) -> reg_value(state, v) end) |> advance()
  end

  defp execute(state, {:mul, [reg, v]}) do
    state |> update_register(reg, fn(rv) -> rv * reg_value(state, v) end) |> advance()
  end

  defp execute(state, {:jgz, [r1, r2]}) do
    if r1 == 0 or reg_value(state, r1) == 0 do
      state |> advance()
    else
      %{state | position: state.position + reg_value(state, r2)}
    end
  end

  defp execute(state, {:add, [r, v]}) do
    state |> update_register(r, fn(rv) -> rv + reg_value(state, v) end) |> advance()
  end

  defp execute(state, {:mod, [r, v]}) do
    state |> update_register(r, fn(rv) -> rem(rv, reg_value(state, v)) end) |> advance()
  end

  defp execute(state, {:snd, [reg]}) do
    %{state | frequency: reg_value(state, reg)} |> advance()
  end

  defp execute(state, {:rcv, _}) do
    %{state | done: true} |> advance()
  end

  defp update_register(state, reg, fun) do
    put_in(state.registers[reg], fun.(reg_value(state, reg)))
  end

  defp advance(state = %{position: pos}), do: %{state | position: pos + 1}

  defp reg_value(%{registers: regs}, reg) do
    if is_integer(reg) do
      reg
    else
      Map.get(regs, reg, 0)
    end
  end

  defp instruction(%{position: pos, instructions: ins}) do
    Enum.at(ins, pos)
  end

  defp instructions() do
    File.stream!("res/day18.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&parse_line/1)
    |> Enum.into([])
  end

  defp parse_line(line) do
    [instruction | args] = String.split(line)
    {String.to_atom(instruction), Enum.map(args, &parse_arg/1)}
  end

  defp parse_arg(arg) do
    case Integer.parse(arg) do
      {int, ""} -> int
      :error -> arg
    end
  end
end

Day18.solve() |> IO.inspect()
