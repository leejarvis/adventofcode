#!/usr/bin/env ruby

require_relative "grid"

numpad = {
  "7" => Point[0,0], "8" => Point[1,0], "9" => Point[2,0],
  "4" => Point[0,1], "5" => Point[1,1], "6" => Point[2,1],
  "1" => Point[0,2], "2" => Point[1,2], "3" => Point[2,2],
  "0" => Point[1,3], "A" => Point[2,3]
}

dirpad = {
  "^" => Point[1,0], "A" => Point[2,0],
  "<" => Point[0,1], "v" => Point[1,1], ">" => Point[2,1]
}

def path(keypad, from, to)
  paths = { from => [] }
  queue = [from]

  while (key = queue.shift)
    return paths[key].map(&:last) if key == to

    dirs = [[-1, 0, "<"], [0, -1, "^"], [0, 1, "v"], [1, 0, ">"]]
    dirs.each do |(x, y, d)|
      next_key = key.add(x, y)
      next unless keypad.value?(next_key) || !paths.key?(next_key)
      paths[next_key] = paths[key] + [[next_key, d]]
      queue << next_key
    end
  end
end

def enter_code(keypad, code)
  output = ""
  current = "A"

  code.chars.each { |c|
    output += path(keypad, keypad[current], keypad[c]).join
    output += "A"
    current = c
  }

  output
end

p1 = 0
DATA.readlines.map(&:chomp).each { |code|
  s1 = enter_code(numpad, code)
  s2 = enter_code(dirpad, s1)
  s3 = enter_code(dirpad, s2)

  p [code, s3.size, s3]
  p1 += s3.size * code.to_i
}

# ["029A", 68, 29] - correct
# ["980A", 60, 980] - correct
# ["179A", 68, 179] - correct
# ["456A", 64, 456] - correct
# ["379A", 68, 379] - incorrect, 68 should be 64

p p1 #=> 127900 - should be 126384

__END__
029A
980A
179A
456A
379A
