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

my $p = shift;
my $q = shift;
my $e = shift;

if (!defined($p) || !defined($q) || !defined($e)) {
    say "Syntax: a24a.pl p q e";
    exit 1;
}

say "p = $p, q = $q, e = $e";

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

say "Zahlen geeignet";
