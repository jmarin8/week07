use Test::Simple tests => 7;
 
use My::Q8 qw(translate_dna);
 
ok( translate_dna(ATG) eq 'M : DNA sequence have a start codon but no stop codon');
ok( translate_dna(atg) eq 'M : DNA sequence have a start codon but no stop codon');
ok( translate_dna(AGTRUYRT) eq '-1: Non-nucleotide character present in DNA sequence!' );
ok( translate_dna(AAGCT) eq '-2: DNA sequence does not contains start codon!' );
ok( translate_dna(ATGGCCAATAGT) eq 'MANS : DNA sequence have a start codon but no stop codon' );
ok( translate_dna(ATGGCCAATAGTCCCTAG) eq MANSP );
ok( translate_dna(AAACCCCATGGCCAATAGTCCCTAG) eq MANSP );
