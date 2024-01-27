#!/usr/bin/env ruby

class Mapping
  def initialize
    @maps = Hash.new { |h, k| h[k] = {} }
  end

  def add(source, dest, map)
    @maps[source][dest] = map
  end

  def location(seed)
    value = seed
    categories.each do |(source, dest)|
      value = convert(source, dest, value)
    end
    value
  end

  def categories
    @maps.map { |k, v| [k, v.keys.first] }
  end

  def convert(source, dest, value)
    @maps[source][dest].then do |map|
      map.each do |(d, s, r)|
        source_range = (s..(s + r))
        dest_range = (d..(d + r))

        if source_range.include?(value)
          return dest_range.begin + (value - source_range.begin)
        end
      end
    end

    value
  end
end

input = DATA.read
seeds = input.lines.first.scan(/\d+/).map(&:to_i)
mapping = Mapping.new

input.split("\n\n").tap(&:shift).each do |map|
  /(\w+)-to-(\w+) map:\n(.*)/m =~ map
  mapping.add($1, $2, $3.lines.map { _1.split.map(&:to_i) })
end

p seeds.map(&mapping.method(:location)).min

__END__
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
