#!/usr/bin/env perl
# vim:ts=4:sw=4:expandtab

use strict;
use warnings;
use v5.10;

# Sieb des Eratosthenes
sub prim {
    my ($zahl) = @_;

    my %sieve = map { ($_, ($_ % 2) == 0) } (2 .. $zahl);
    for my $number (keys %sieve) {
        next if ($sieve{$number} == 1);
        for (my $i = ($number * $number); $i < $zahl; $i += $number) {
            $sieve{$i} = 1;
        }
    }
    return $sieve{$zahl} == 0;
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
my $e = shift;
my $m = shift;

if (!defined($p) || !defined($q) || !defined($e) || !defined($m)) {
    say "Syntax: a24c.pl p q e m";
    exit 1;
}

say "p = $p, q = $q, e = $e, m = $m";

# Bedingungen:
# p != q
# p, q prim
# 1 < e < φ(N) := (p - 1) * (q - 1)

if ($p == $q) {
    say "p == q, Zahlen ungeeignet";
    exit 0;
}

if (!prim($p) || !prim($q)) {
    say "p oder q ist nicht prim, Zahlen ungeeignet";
    exit 0;
}

if ($e <= 1 || $e >= (($p - 1) * ($q - 1))) {
    say "Bedingung 1 < e < φ(N) verletzt, Zahlen ungeeignet";
    exit 0;
}

# 2. RSA-Modul n berechnen:
my $n = $p * $q;
say "N = $p * $q";

# 3. φ(n) = (p - 1) * (q - 1)
my $phi = ($p - 1) * ($q - 1);

say "φ(N) = $phi";
say "e = $e";

my $c = 1;
while ($e > 0) {
    $c = ($c * $m) % $n;
    $e--;
}
say "c = $c";
