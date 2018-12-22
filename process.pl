#!/usr/bin/env perl
use strict;
use warnings;

@ARGV >= 1 or die "Usage: \n\tperl $0 dir1 dir2 ... dirn\n";

my @events;

foreach my $event (@events) {
    system "perl 2.merge.pl $event";
    system "perl 4.synchronize.pl $event";
    system "perl 5.transfer.pl $event";
    system "perl 7.resample.pl $event 0.1";
}
