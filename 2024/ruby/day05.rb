#!/usr/bin/env ruby

require "set"

rules, updates = DATA.read.split("\n\n")
updates = updates.split("\n").map { _1.split(",").map(&:to_i) }

RULES = rules.split("\n").map { _1.split("|").map(&:to_i) }.to_set

def fix(update)
  update.each_cons(2).with_index { |pair, i|
    next if RULES.member?(pair)

    update[i], update[i + 1] = update[i + 1], update[i]
    fix(update)
  }
end

p1 = p2 = 0

updates.each { |update|
  if update.each_cons(2).all? { RULES.member?(_1) }
    p1 += update[update.size / 2]
  else
    p2 += fix(update)[update.size / 2]
  end
}

puts "P1: #{p1}"
puts "P2: #{p2}"

__END__
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
