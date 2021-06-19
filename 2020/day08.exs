# http://adventofcode.com/2020/day/8

defmodule Day8 do
  def solve(input) do
    instructions = load_instructions(input)

    {:error, s1} = run(instructions)
    {:ok, s2} = run_modified(instructions)

    {s1, s2}
  end

  def run(instructions) do
    run(instructions, 0, 0, MapSet.new)
  end

  def run(instructions, ptr, acc, seen) do
    if MapSet.member?(seen, ptr) do
      {:error, acc}
    else
      case instructions[ptr] do
        nil -> {:ok, acc}
        ins -> run(instructions, ins, ptr, acc, MapSet.put(seen, ptr))
      end
    end
  end

  def run(instructions, {"nop", _}, ptr, acc, seen) do
    run(instructions, ptr + 1, acc, seen)
  end

  def run(instructions, {"acc", arg}, ptr, acc, seen) do
    run(instructions, ptr + 1, acc + arg, seen)
  end

  def run(instructions, {"jmp", arg}, ptr, acc, seen) do
    run(instructions, ptr + arg, acc, seen)
  end

  def run_modified(instructions) do
    run_modified(instructions, instructions, 0)
  end

  def run_modified(original, modified, ptr) do
    case run(modified) do
      {:ok, acc} -> {:ok, acc}
      {:error, _} ->
        case modified[ptr] do
          {"acc", _} ->
            run_modified(original, modified, ptr + 1)
          ins ->
            run_modified(original, Map.put(original, ptr, swap(ins)), ptr + 1)
        end
    end
  end

  def swap({"jmp", arg}), do: {"nop", arg}
  def swap({"nop", arg}), do: {"jmp", arg}

  def load_instructions(input) do
    for {ins, idx} <- Enum.with_index(input), into: %{} do
      [op, arg] = String.split(ins)
      {idx, {op, String.to_integer(arg)}}
    end
  end
end

File.read!("input/day08.txt")
|> String.split("\n")
|> Day8.solve()
|> IO.inspect()
