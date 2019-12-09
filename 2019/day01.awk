#!/usr/bin/env awk

# awk -f day1.awk res/day1.txt

function calc(n) { return int(n / 3) - 2 }

# one
{ s1 += calc($0) }

# two
{
  fuel = calc($0);
  while (fuel > 0) {
    s2 += fuel;
    fuel = calc(fuel);
  }
}

END {
  print(s1)
  print(s2)
}
