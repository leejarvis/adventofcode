#!/usr/bin/perl -l

sub execute {
  my ($instructions, $input) = @_;
  my @ins = @{$instructions};
  my @inputs = ($input);
  my (@shifts, $pos, $rel) = ((0, 4, 4, 2, 2, 3, 3, 4, 4, 2), 0, 0);

  while ((my $op = $ins[$pos]) != 99) {
    my ($p1, $p2, $p3) = map { ($ins[$pos + $_], $pos + $_, $ins[$pos + $_] + $rel)[int($op / 10 ** ($_ + 1)) % 10] }(1..3);

    $op = $op % 100;
    $pos += $shifts[$op];

    my %subs = (
      1 => sub { $ins[$p3] = $ins[$p1] + $ins[$p2] },
      2 => sub { $ins[$p3] = $ins[$p1] * $ins[$p2] },
      3 => sub { $ins[$p1] = shift(@inputs) },
      4 => sub { push(@inputs, $ins[$p1]) },
      5 => sub { $pos = $ins[$p2] if $ins[$p1] != 0 },
      6 => sub { $pos = $ins[$p2] if $ins[$p1] == 0 },
      7 => sub { $ins[$p3] = ($ins[$p1] < $ins[$p2]) ? 1 : 0 },
      8 => sub { $ins[$p3] = ($ins[$p1] == $ins[$p2]) ? 1 : 0 },
      9 => sub { $rel += $ins[$p1] }
    );

    %subs{$op}->();
  }

  return @inputs;
}

my @instructions = split(/,/, do { local(@ARGV, $/) = "res/day9.txt" ; <>});

print execute(\@instructions, 1);
print execute(\@instructions, 2);
