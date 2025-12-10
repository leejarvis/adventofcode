def machine(str)
  light, *buttons, joltage = str.split
  [
    light[1..-2].chars.map { _1 == "." ? 0 : 1 },
    buttons.map { _1.scan(/\d+/).map(&:to_i) },
    joltage.scan(/\d+/).map(&:to_i)
  ]
end

def fewest_clicks(goal, buttons)
  queue = [[Array.new(goal.size, 0), []]]
  visited = Set.new

  while (state, path = queue.shift)
    return path.size if state == goal

    buttons.each_with_index do |button, i|
      next_state = state.dup
      button.each { next_state[_1] = 1 - state[_1] }

      unless visited.include?(next_state)
        visited << next_state
        queue << [next_state, path + [i]]
      end
    end
  end

  nil
end

input = File.readlines("input/d10.txt", chomp: true)
p1, p2 = 0, 0
input.each do |line|
  goal, buttons, _joltage = machine(line)
  p1 += fewest_clicks(goal, buttons)
end

p [p1, p2]
