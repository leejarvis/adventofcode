# http://adventofcode.com/2022/day/15

defmodule Day15 do
  def solve(input) do
    network = parse_network([], input)
    # print_network(network)

    count_non_beacon_points(network, 10)
  end

  def count_non_beacon_points(network, row) do
    network
    |> Enum.map(&x_range(&1, row))
    |> Enum.reject(&is_nil/1)
    |> union_ranges()
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
    |> Kernel.-(count_beacons(row, network))
  end

  def count_beacons(y, sensors) do
    sensors
    |> Enum.map(fn sensor -> sensor.beacon end)
    |> Enum.uniq()
    |> Enum.count(fn {_x, by} -> by == y end)
  end

  def x_range(sensor, y) do
    %{sensor: {sx, sy}, distance: distance} = sensor
    length = distance - abs(y - sy)

    if length >= 0 do
      (sx - length)..(sx + length)
    end
  end

  def union_ranges(given_ranges) do
    given_ranges
    |> Enum.sort_by(fn first.._ -> first end)
    |> Enum.reduce([], fn range, ranges ->
      cond do
        ranges == [] ->
          [range]

        Range.disjoint?(range, hd(ranges)) ->
          [range | ranges]

        true ->
          first1..last1 = range
          first2..last2 = hd(ranges)
          [min(first1, first2)..max(last1, last2) | tl(ranges)]
      end
    end)
  end

  defp distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  defp parse_network(network, input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(network, &record_report/2)
  end

  defp record_report(report, network) do
    Regex.scan(~r/(-?\d+)/, report, capture: :all_but_first)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple/1)
    |> then(fn [sensor, beacon] ->
      [%{sensor: sensor, beacon: beacon, distance: distance(sensor, beacon)} | network]
    end)
  end
end

"""
Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3
"""
# File.read!("input/day15.txt")
|> Day15.solve()
|> IO.inspect(charlists: :as_lists)
