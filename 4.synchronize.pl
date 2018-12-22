#!/usr/bin/env perl
use strict;
use warnings;
use POSIX qw(strftime);

@ARGV == 1 or die "Usage: perl $0 dirname\n";
my ($dir) = @ARGV;

chdir $dir or die;

my $year = substr $dir, 0, 4;
my $month = substr $dir, 4, 2;
my $day = substr $dir, 6, 2;
my $hour = "00";
my $minute = "00";
my $second = "00"
my $jday = strftime("%j", $second, $minute, $hour, $day, $month-1, $year-1900);

open(SAC, "| sac") or die "Error in opening SAC\n";
print SAC "wild echo off \n";
print SAC "r *.SAC \n";
print SAC "synchronize \n";
print SAC "ch o gmt $year $jday $hour $minute $sec $msec \n";
print SAC "ch allt (0 - &1,o&) iztype IO \n";
print SAC "wh \n";
print SAC "q \n";
close(SAC);

open(SAC, "| sac") or die "Error in opening SAC\n";
print SAC "wild echo off \n";
print SAC "cuterr fillz \n";
print SAC "cut 0 86400 \n";
print SAC "r *.SAC \n";
print SAC "w over \n";
print SAC "q \n";
close(SAC);
chdir "..";
