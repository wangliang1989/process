#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);
use List::Util qw(max);
use Time::Local;

my $pwd = `pwd`;
chop($pwd);
open(OUT, ">> ../station_builder.txt") or die;
open(IND, ">> ../index.txt") or die;
foreach my $dir (glob "*") {
    chdir $dir or next;
    my $stla;
    my $stlo;
    my $stel;
    my $start = -1;
    my $end = -1;
    foreach my $idir (glob "*") {
        chdir $idir or next;
        foreach my $file (glob "*SAC") {
            ($stla, $stlo, $stel) = (split m/\s+/, `saclst stla stlo stel f $file`)[1..3] unless (defined($stla));
            my ($b, $e, $kzdate, $kztime) = (split m/\s+/, `saclst b e kzdate kztime f $file`)[1..4];
            my ($year, $mon, $day) = split "/", $kzdate;
            my ($hour, $min, $sec) = split ":", $kztime;
            # 月份范围为0-11
            $mon -= 1;
            # 计算该时刻与计算机元年的秒数差
            my $time = timegm($sec, $min, $hour, $day, $mon, $year);
            $b = $b + $time;
            $e = $e + $time;
            print IND "$dir $pwd/$dir/$idir/$file $b $e\n";
            $start = $b if ($start == -1);
            $start = min($start, $b);
            $end = max($end, $e);
        }
        chdir "../" or die;
    }
    # 将时间差转换为具体的时刻
    my ($sec0, $min0, $hour0, $day0, $mon0, $year0, $wday0, $yday0, $isdast0) = gmtime($start);
    # 对年份和月份特殊处理
    $year0 += 1900;
    $mon0 += 1;
    # 将时间差转换为具体的时刻
    my ($sec1, $min1, $hour1, $day1, $mon1, $year1, $wday1, $yday1, $isdast1) = gmtime($end);
    # 对年份和月份特殊处理
    $year1 += 1900;
    $mon1 += 1;
    ($mon1, $day1, $hour1, $min1, $sec1, $mon0, $day0, $hour0, $min0, $sec0) =&add_zero ($mon1, $day1, $hour1, $min1, $sec1, $mon0, $day0, $hour0, $min0, $sec0);
    print OUT "CD|$dir|$stla|$stlo|CDUT|${year0}-${mon0}-${day0}T${hour0}:${min0}:${sec0}|${year1}-${mon1}-${day1}T${hour1}:${min1}:${sec1}|\n" if (defined($stlo));
    chdir "../" or die;
}
close(IND);
close(OUT);
sub add_zero(){
    my @in = @_;
    my @out;
    foreach (@in) {
        if (length($_) < 2) {
            push @out, "0$_";
        }else{
            push @out, "$_";
        }
    }
    return @out;
}
