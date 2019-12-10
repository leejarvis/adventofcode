#!/usr/bin/perl -l

use experimental qw(switch);

sub execute {
  my ($instructions, $input) = @_;
  my @ins = @{$instructions};
  my @inputs = ($input);
  my @shifts = (0, 4, 4, 2, 2, 3, 3, 4, 4, 2);
  my $pos = $rel = 0;

  while ((my $op = $ins[$pos]) != 99) {
    my ($p1, $p2, $p3) = map { ($ins[$pos + $_], $pos + $_, $ins[$pos + $_] + $rel)[int($op / 10 ** ($_ + 1)) % 10] }(1..3);

    $op = $op % 100;
    $pos += $shifts[$op];

    given($op) {
      when(1) { $ins[$p3] = $ins[$p1] + $ins[$p2] }
      when(2) { $ins[$p3] = $ins[$p1] * $ins[$p2] }
      when(3) { $ins[$p1] = shift(@inputs) }
      when(4) { push(@inputs, $ins[$p1]) }
      when(5) { $pos = $ins[$p2] if $ins[$p1] != 0 }
      when(6) { $pos = $ins[$p2] if $ins[$p1] == 0 }
      when(7) { $ins[$p3] = ($ins[$p1] < $ins[$p2]) ? 1 : 0 }
      when(8) { $ins[$p3] = ($ins[$p1] == $ins[$p2]) ? 1 : 0 }
      when(9) { $rel += $ins[$p1] }
    }
  }

  return @inputs;
}

my @instructions = split(/,/, do { local(@ARGV, $/) = "res/day9.txt" ; <>});

print execute(\@instructions, 1);
print execute(\@instructions, 2);
