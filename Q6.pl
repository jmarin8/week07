#!/usr/bin/perl
use warnings;
use strict;

my @arr;
print "Input 10 number (one per line) :";
for (1 .. 10) {
    my $num = <STDIN>;
    chomp $num;
    push @arr, $num;
}
my $max_number = max_num(\@arr);
my $min_number = min_num(\@arr);
print "max number is : $max_number \n";
print "min number is : $min_number \n";
sub max_num{
        my ( $list) = @_;

        my $max= @{$list}[0];
        my $i=1;
        while($i<10){
                if(@{$list}[$i]>$max){
                        $max=@{$list}[$i];
                }
                $i++;
        }
        return $max;
}

sub min_num{
        my ( $list) = @_;

        my $min= @{$list}[0];
        my $i=1;
        while($i<10){
                if(@{$list}[$i]<$min){
                        $min=@{$list}[$i];
                }
                $i++;
        }
        return $min;
}
