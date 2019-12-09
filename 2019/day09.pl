#!/usr/bin/perl -l

use strict;
use warnings;

sub execute {
  my $instructions = shift;
  my @instructions = @{$instructions};

  my $input = shift;
  my @inputs = ($input);

  my $pos = 0;
  my $relative = 0;

  while ($instructions[$pos] != 99) {
    my $op = $instructions[$pos];
    my ($p1, $p2, $p3);

    my $p1mode = int($op / 100) % 10;
    my $p2mode = int($op / 1000) % 10;
    my $p3mode = int($op / 10000) % 10;

    if ($p1mode == 0) {
      $p1 = $instructions[$pos + 1];
    } elsif ($p1mode == 1) {
      $p1 = $pos + 1
    } elsif ($p1mode == 2) {
      $p1 = $instructions[$pos + 1] + $relative;
    }

    if ($p2mode == 0) {
      $p2 = $instructions[$pos + 2];
    } elsif ($p2mode == 1) {
      $p2 = $pos + 2
    } elsif ($p2mode == 2) {
      $p2 = $instructions[$pos + 2] + $relative;
    }

    if ($p3mode == 0) {
      $p3 = $instructions[$pos + 3];
    } elsif ($p3mode == 1) {
      $p3 = $pos + 3
    } elsif ($p3mode == 2) {
      $p3 = $instructions[$pos + 3] + $relative;
    }

    $op = substr("$op", -1);

    if ($op == "1") {
      $instructions[$p3] = $instructions[$p1] + $instructions[$p2];
      $pos += 4;
    } elsif ($op == "2") {
      $instructions[$p3] = $instructions[$p1] * $instructions[$p2];
      $pos += 4;
    } elsif ($op == "3") {
      $instructions[$p1] = shift(@inputs);
      $pos += 2;
    } elsif ($op == "4") {
      push(@inputs, $instructions[$p1]);
      $pos += 2;
    } elsif ($op == "5") {
      ($instructions[$p1] == 0) ? ($pos += 3) : ($pos = $instructions[$p2]);
    } elsif ($op == "6") {
      ($instructions[$p1] == 0) ? ($pos = $instructions[$p2]) : ($pos += 3);
    } elsif ($op == "7") {
      $instructions[$p3] = ($instructions[$p1] < $instructions[$p2]) ? 1 : 0;
      $pos += 4;
    } elsif ($op == "8") {
      $instructions[$p3] = ($instructions[$p1] == $instructions[$p2]) ? 1 : 0;
      $pos += 4;
    } elsif ($op == "9") {
      $relative += $instructions[$p1];
      $pos += 2;
    } else {
      die "Unknown op `$op`";
    }
  }

  return @inputs;
}

open(FH, "res/day9.txt");
my @instructions = map { int($_) } split(/,/, <FH>);
close(FH);

print execute(\@instructions, 1);
print execute(\@instructions, 2);
