#!/usr/bin/env ruby

def cond?(cond, part)
  var, op, val = cond.split("", 3)
  part[var].to_i.send(op, val.to_i)
end

def build_workflow(pattern)
  conditions = pattern.split(",")
  otherwise = conditions.pop

  lambda do |part|
    conditions.each do |cond|
      c, res = cond.split(":")
      if cond?(c, part)
        return res if res == "A" || res == "R"
        return WORKFLOWS[res].call(part)
      end
    end

    return otherwise if otherwise == "A" || otherwise == "R"
    WORKFLOWS[otherwise].call(part)
  end
end

workflows, parts = DATA.read.split("\n\n")
WORKFLOWS = workflows.lines.each_with_object({}) do |line, w|
  name, wf = line.chomp.split("{")
  w[name] = build_workflow(wf.chop)
end
parts = parts.lines.map { _1.scan(/([xmas])=(\d+)/).to_h }
root_workflow = WORKFLOWS["in"]

sum = parts.reduce do |acc, part|
  if root_workflow.call(part) == "A"
    acc + part.values.map(&:to_i).sum
  else
    acc
  end
end

p sum

__END__
px{a<2006:qkq,m>2090:A,rfg}
pv{a>1716:R,A}
lnx{m>1548:A,A}
rfg{s<537:gd,x>2440:R,A}
qs{s>3448:A,lnx}
qkq{x<1416:A,crn}
crn{x>2662:A,R}
in{s<1351:px,qqz}
qqz{s>2770:qs,m<1801:hdj,R}
gd{a>3333:R,R}
hdj{m>838:A,pv}

{x=787,m=2655,a=1222,s=2876}
{x=1679,m=44,a=2067,s=496}
{x=2036,m=264,a=79,s=2244}
{x=2461,m=1339,a=466,s=291}
{x=2127,m=1623,a=2188,s=1013}
