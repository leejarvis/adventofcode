function parse_input()
  local moons = {}

  for line in io.lines("res/day12.txt") do
    x, y, z = string.match(line, "x=([%-%d]+), y=([%-%d]+), z=([%-%d]+)")

    table.insert(
      moons,
      {
        position = { x = tonumber(x), y = tonumber(y), z = tonumber(z) },
        velocity = { x = 0, y = 0, z = 0 }
      }
    )
  end

  return moons
end

function move(moon)
  moon.position.x = moon.position.x + moon.velocity.x
  moon.position.y = moon.position.y + moon.velocity.y
  moon.position.z = moon.position.z + moon.velocity.z
end

function apply_gravity(m1, m2)
  if m1.position.x > m2.position.x then
    m1.velocity.x = m1.velocity.x - 1
  elseif m1.position.x < m2.position.x then
    m1.velocity.x = m1.velocity.x + 1
  end

  if m1.position.y > m2.position.y then
    m1.velocity.y = m1.velocity.y - 1
  elseif m1.position.y < m2.position.y then
    m1.velocity.y = m1.velocity.y + 1
  end

  if m1.position.z > m2.position.z then
    m1.velocity.z = m1.velocity.z - 1
  elseif m1.position.z < m2.position.z then
    m1.velocity.z = m1.velocity.z + 1
  end
end

function apply_gravity_all(moons)
  for i = 1, #moons, 1 do
    m1 = moons[i]

    for j = 1, #moons, 1 do
      m2 = moons[j]

      if m1 == m2 then
        goto next
      else
        apply_gravity(m1, m2)
      end

      ::next::
    end
  end
end

function energy(moon)
  position = math.abs(moon.position.x) + math.abs(moon.position.y) + math.abs(moon.position.z)
  velocity = math.abs(moon.velocity.x) + math.abs(moon.velocity.y) + math.abs(moon.velocity.z)

  return position * velocity
end

function gcd(a, b)
  while b ~= 0 do
    a, b = b, a % b
  end

  return a
end

function lcm(a, b)
  return a * b / gcd(a, b)
end

function step(moons, a)
  for i = 1, #moons, 1 do
    m1 = moons[i]

    for j = 1, #moons, 1 do
      m2 = moons[j]

      d = math.max(math.min(1, m1.position[a] - m2.position[a]), -1)
      m1.velocity[a] = m1.velocity[a] - d
      m2.velocity[a] = m2.velocity[a] - d
    end
  end

  for i = 1, #moons, 1 do
    moon = moons[i]
    moon.position[a] = moon.position[a] + moon.velocity[a]
  end
end

function state_of(m)
  return {m.position.x, m.position.y, m.position.z, m.velocity.x, m.velocity.y, m.velocity.z}
end

function state(moons)
  local s = {}
  for i, m in pairs(moons) do
    s[i] = state_of(m)
  end
  return s
end

function find_loop(moons, a)
  local start = state(moons)
  local c = 0

  while true do
    step(moons, a)
    c = c + 1

    if state(moons) == start then
      return c
    end
  end
end

function part1()
  local moons = parse_input()

  for i = 1, 1000, 1 do
    apply_gravity_all(moons)

    for i = 1, #moons, 1 do
      move(moons[i])
    end
  end

  total = 0

  for i = 1, #moons, 1 do
    total = total + energy(moons[i])
  end

  print(total)
end

function part2()
  local moons = parse_input()

  local x = find_loop(moons, "x")
  local y = find_loop(moons, "y")
  local z = find_loop(moons, "z")

  print(lcm(lcm(x, y), z))
end

part1()
part2()
