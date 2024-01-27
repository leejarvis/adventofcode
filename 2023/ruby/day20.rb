#!/usr/bin/env ruby

flip_flop = {}
conjunctions = Hash.new { |h, k| h[k] = Hash.new(0) }

modules = DATA.readlines.each_with_object({}) do
  name, dests = _1.chomp.split(" -> ")
  flip_flop[name[1..]] = 0 if name[0] == "%"
  conjunctions[name[1..]] = {} if name[0] == "&"
  _2[name.sub(/[%&]/, "")] = dests.split(", ")
end

low = 0
high = 0

1000.times do
  low += 1
  queue = modules["broadcaster"].map { ["broadcaster", _1, 0] }

  until queue.empty?
    src, dest, signal = queue.pop
    signal == 0 ? low += 1 : high += 1
    new_dests = modules[dest]

    if signal == 0 && flip_flop.key?(dest)
      out = flip_flop[dest] = 1 - flip_flop[dest]
    elsif conjunctions.key?(dest)
      conjunctions[dest][src] = signal
      out = conjunctions[dest].values.include?(0) ? 1 : 0
    else
      next
    end

    modules[dest].each { queue << [dest, _1, out] }
  end
end

p low * high

__END__
broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a
