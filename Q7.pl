#!/usr/bin/perl
#use warnings;
use strict;

my @arr;
print "Input 9 words to insert in 3*3 Array (one word per line) :";
for(my $i=0; $i<3; $i++){
    for(my $j=0; $j<3; $j++){
                my $input = <STDIN>;
                chomp $input;
        $arr[$i][$j] = $input;
    }
}
print "\nInput is :\n";
print "@$_\n" for @arr;
my $result = transpose(\@arr);
print "\nOutput is :\n";
print "@$_\n" for @$result;

sub transpose{
        my ( $list) = @_;

        my @transposed;
        for my $row (@{$list}) {
                for my $column (0 .. $#{$row}) {
                        push(@{$transposed[$column]}, $row->[$column]);
                }
        }

        return \@transposed;
}
