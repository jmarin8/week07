#!/usr/bin/perl

my $olig;
while(true)
{
   print "Enter an oligomer: ";
   $olig = <STDIN>;
   chomp $olig;
   $olig= uc($olig);
   if($olig =~/^[ATCG]+$/){
	last;
   }
   print "Invalid oligomer\n";
}
my $countA = $olig =~ tr/A//;
my $countT = $olig =~ tr/T//;
my $countC = $olig =~ tr/C//;
my $countG = $olig =~ tr/G//;
my $temp = ($countA+$countT)*2 +($countC+$countG)*4;
my $percentage = (($countC+$countG)*100)/($countC+$countG+$countA+$countT);
print "Annealing temperature of oligomer is $temp C\n";
print "Percent of G or C in the oligo is $percentage %";
