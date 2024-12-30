#!/usr/bin/env ruby

def safe?(report)
  inc = nil

  report.each_cons(2) { |(left, right)|
    return false unless (1..3).include?((left - right).abs)

    if inc.nil?
      inc = left > right
    else
      return false if inc != (left > right)
    end
  }

  true
end

def dampened(report)
  report.size.times.map { |n|
    report.dup.tap { _1.tap { |r| r.delete_at(n) } }
  }
end

reports = DATA.readlines.map { _1.scan(/\d+/).map(&:to_i) }
reports.count { safe?(_1) }.then { puts "P1: #{_1}" }
reports.count { safe?(_1) or dampened(_1).any?(&method(:safe?)) }.then { puts "P2: #{_1}" }

__END__
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
