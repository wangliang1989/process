#!/usr/bin/env perl
use strict;
use warnings;
$ENV{SAC_DISPLAY_COPYRIGHT} = 0;

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir;

open(SAC, "| sac") or die "Error in opening sac\n";
print SAC "wild echo off\n";
print SAC "r *SAC\n";
print SAC "rglitches\n";
print SAC "rmean;rtr;taper\n";
print SAC "trans from polezero subtype /data/PZ.ALL to vel freq 0.1 0.2 5 10\n";
print SAC "mul 1.0e7\n";
print SAC "bp c 0.5 4 n 2 p 1\n";
print SAC "w over\n";
print SAC "q\n";
close(SAC);
