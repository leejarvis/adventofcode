#!/usr/bin/env ruby

input = DATA.readlines.map { _1.split.map(&:to_i) }

def build(history)
  [history].tap do |all|
    until history.uniq == [0]
      history = history.each_cons(2).map { _2 - _1 }
      all << history
    end
  end
end

p input.sum { build(_1).map(&:last).sum }

__END__
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
