#!/usr/bin/perl
my %codon_table = (TTT=>F, TTC=>F, TTA=>L, TTG=>L, CTT=>L, CTC=>L, CTA=>L, CTG=>L, ATT=>I, ATC=>I, ATA=>I, ATG=>M,GTT=>V, GTC=>V, GTA=>V, GTG=>V,TCT=>S, TCC=>S, TCA=>S, TCG=>S, CCT=>P, CCC=>P, CCA=>P, CCG=>P,ACT=>T, ACC=>T, ACA=>T, ACG=>T,GCT=>A, GCC=>A, GCA=>A, GCG=>A,TAT=>Y, TAC=>Y, TAA=>Stop, TAG=>Stop,CAT=>H, CAC=>H, CAA=>Q, CAG=>Q,AAT=>N, AAC=>N, AAA=>K, AAG=>K,GAT=>D, GAC=>D, GAA=>E, GAG=>E,TGT=>C, TGC=>C, TGA=>Stop, TGG=>W, CGT=>R, CGC=>R, CGA=>R, CGG=>R, AGT=>S, AGC=>S, AGA=>R, AGG=>R, GGT=>G, GGC=>G, GGA=>G, GGG=>G);

print "Enter DNA sequence: ";
my $dna = <STDIN>;
chomp $dna;
$dna= uc($dna);
translate_dna($dna);

sub translate_dna{
	my ($dna_input) = @_;
	
	$dna_input= uc($dna_input);
	if($dna_input =~/^[ATCG]+$/){
		my $index = index($dna_input, ATG);
		my $len = length $dna_input;
		my $result;
		if($index != -1) {
			$dna_input = substr $dna_input, $index, $len;
			$len = $len - $index;
			my $i=0;
			while($i+3 <= $len){
				my $r = substr $dna_input, $i, 3;
				my $x = $codon_table{substr $dna_input, $i, 3};
				if($x eq Stop){
					print "Predicted protein sequence is ".$result."\n";
					return $result;
				}
				$result = $result.$x;
				$i=$i+3;
			}
			print "Predicted protein sequence is ".$result."\n";
			print "DNA sequence has start codon but no stop codon\n";
			return "$result : DNA sequence has start codon but no stop codon";
		}else{
			print "Error: DNA sequence does not contain start codon!\n";
			return "-2: DNA sequence does not contain start codon!";
		}
	}else{
		print "Error: Non-nucleotide character present in DNA sequence!\n";
		return "-1: Non-nucleotide character present in DNA sequence!";
	}
}
