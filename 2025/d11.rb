def paths(devices, current, goal, cache: {})
  if current == goal
    1
  elsif cache[current]
    cache[current]
  else
    paths = devices[current].sum { |n| paths(devices, n, goal, cache:) }
    cache[current] = paths
    paths
  end
end

devices =
  File.readlines("input/d11.txt", chomp: true)
    .map { _1.scan(/\w+/) }
    .each_with_object("out" => []) do |(device, *outputs), graph|
      graph[device] = outputs
    end

p1 = paths(devices, "you", "out")
p2 = paths(devices, "svr", "fft") * paths(devices, "fft", "dac") * paths(devices, "dac", "out")

p [p1, p2]
