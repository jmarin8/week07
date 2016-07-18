#!/usr/bin/perl
$funcname = "returnHash";
my $result = &$funcname();
foreach(keys %$result) { print "$_ : $$result{$_}\n"; }

sub returnHash{
my %data = ('Daryl', 45, 'Jordan', 30, 'Altha', 40, 'Phi', 37);
return \%data;
