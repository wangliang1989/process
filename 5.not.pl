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
print SAC "bp c 3 8 n 4 p 1\n";
print SAC "w over\n";
print SAC "q\n";
close(SAC);
open(SAC, "| sac") or die "Error in opening sac\n";
print SAC "wild echo off\n";
print SAC "r *BHE*\n";
print SAC "ch cmpinc 90 cmpaz 90\n";
print SAC "wh\n";
print SAC "r *BHN*\n";
print SAC "ch cmpinc 90 cmpaz 0\n";
print SAC "wh\n";
print SAC "r *BHZ*\n";
print SAC "ch cmpinc 0 cmpaz 0\n";
print SAC "mul -1\n";
print SAC "write over\n";
print SAC "q\n";
close(SAC);
