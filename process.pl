#!/usr/bin/env perl
use strict;
use warnings;

@ARGV >= 1 or die "Usage: \n\tperl $0 event1 event2 ... eventn\n\tperl $0 events.info\n";

my @events;

if (@ARGV == 1 and -f $ARGV[0]) {
    open(IN, "< $ARGV[0]");
    foreach (<IN>) {
        my ($event) = split /\s+/;
        push @events, $event;
    }
    close(IN);
} else {
    @events = @ARGV;
}

foreach my $event (@events) {
    system "perl 2.merge.pl $event";
    system "perl 4.synchronize.pl $event";
    system "perl 5.transfer.pl $event";
    system "perl 7.resample.pl $event 0.1";
}
