#!/usr/bin/perl
print "Enter temperature to convert :";
my $temp = <STDIN>;
chomp $temp;
my $newtemp = $temp * 1.1;
while(true)
{
   print "In what scale input is entered(C or F) :";
   my $scale = <STDIN>;
   chomp $scale;
   if($scale eq "C"){
          print convertToF($newtemp);
          last;
        }elsif($scale eq "F"){
          print convertToC($newtemp);
          last;
        }
}

sub convertToF(my $temp){
my $convertTemp = $temp * 1.8 + 32;
return "$convertTemp F";
}

sub convertToC(my $temp){
my $convertTemp = ($temp - 32) * 5/9;
return "$convertTemp C";
}
