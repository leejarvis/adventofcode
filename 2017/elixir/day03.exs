# http://adventofcode.com/2017/day/3

# This module actually generates a spiral, the module below
# does the calculation with math instead
defmodule Day3Spiral do
  defmodule Point do
    defstruct [:v, :x, :y, :dir]
  end

  def spiral(limit) do
    start = point(1, 0, 0, :down)
    next_point(save(start), start, limit)
  end

  defp next_point(store, point, limit) do
    case next_point(store, point) do
      {_, %Point{v: ^limit, x: x, y: y}} -> abs(x) + abs(y)
      {store, point} -> next_point(store, point, limit)
    end
  end

  defp next_point(store, %Point{v: v, x: x, y: y, dir: dir}) do
    point = case dir do
      :down  -> point(v + 1, x + 1, y, :right)
      :right -> point(v + 1, x, y + 1, :up)
      :up    -> point(v + 1, x - 1, y, :left)
      :left  -> point(v + 1, x, y - 1, :down)
    end

    point = case saved?(store, point) do
      true -> next_point_continued(point)
      false -> point
    end

    {save(store, point), point}
  end

  # This function is called if the direction can't change, e.g. because
  # there's already a square at this coordinate. The first example is
  # 5. We try to turn down, but 1 exists, so this function is called
  # with down as the dir, and we know the previous direction is left
  # so we revert the x and y coords and take a step back
  defp next_point_continued(%Point{v: v, x: x, y: y, dir: dir}) do
    case dir do
      :down  -> point(v, x - 1, y + 1, :left)
      :left  -> point(v, x + 1, y + 1, :up)
      :up    -> point(v, x + 1, y - 1, :right)
      :right -> point(v, x - 1, y - 1, :down)
    end
  end

  defp point(v, x, y, d), do: %Point{v: v, x: x, y: y, dir: d}

  defp save(point), do: save(%{}, point)
  defp save(store, %Point{v: v, x: x, y: y}), do: Map.put(store, {x, y}, v)

  defp saved?(store, %Point{x: x, y: y}), do: Map.has_key?(store, {x, y})
end

defmodule Day3Math do
  import Integer, only: [mod: 2]

  def count_steps(square) do
    side  = side_length(square)
    steps = (side - 1) / 2
    count = round(square - :math.pow((side - 2), 2))
    offset = mod(count, side - 1)

    steps + abs(offset - steps)
    |> round()
  end

  defp side_length(square) do
    side = square
    |> :math.sqrt()
    |> :math.ceil()
    |> round()

    cond do
      mod(side, 2) == side -> side + 1
      true -> side
    end
  end
end

Day3Spiral.spiral(277678)
|> IO.inspect()

Day3Math.count_steps(277678)
|> IO.inspect()
# 475
# 279138
