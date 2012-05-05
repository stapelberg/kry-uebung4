#!/usr/bin/env perl
# vim:ts=4:sw=4:expandtab

use strict;
use warnings;
use v5.10;

sub ggt {
    my ($a, $b) = @_;
    return $a if $b == 0;
    return $b if $a == 0;
    my $rest = ($b % $a);
    return $a if $rest == 0;
    return ggt($rest, $a);
}

sub erweiterter_euklid {
    my ($a, $b) = @_;
    return [ $a, 1, 0 ] if $b == 0;
    my $rest = ($a % $b);
    my $recursed = erweiterter_euklid($b, $rest);
    return [ $recursed->[0], $recursed->[2], $recursed->[1] - int($a / $b) * $recursed->[2] ];
}

my $p = shift;
my $q = shift;
my $c = shift;

if (!defined($p) || !defined($q) || !defined($c)) {
    say "Syntax: a24d.pl p q c";
    exit 1;
}

# 2. RSA-Modul n berechnen:
my $n = $p * $q;
say "N = $p * $q";

# 3. φ(n) = (p - 1) * (q - 1)
my $phi = ($p - 1) * ($q - 1);

say "φ(N) = $phi";

# 4. Eine zu φ(n) teilerfremde Zahl e wählen mit 1 < e < φ(n)
my $e;
for ($e = 2; $e < $phi; $e++) {
    last if ggt($phi, $e) == 1;
}

say "e = $e";

my (undef, $d, undef) = @{erweiterter_euklid($e, $phi)};
$d += $phi if ($d < 0);
say "d = $d";

# decrypt:
#my $m = ($c ** $d) % $n;
my $m = 1;
while ($d > 0) {
    $m = ($m * $c) % $n;
    $d--;
}
say "m = $m";
