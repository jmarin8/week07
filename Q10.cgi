#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use DBI;

use CGI ( ':standard' );
  
my $gene = param( 'gene' );
my $org  = param( 'organism' );
my $tissue  = param( 'tissue' );
my $start = param( 'start' );
my $stop = param( 'stop' );
my $level = param( 'level' );

my $title = 'Fasta Database';

print header,
    start_html( $title ),
    h1( $title ),
    p( "Gene Name"),
    p( "Organism Name"),
    p( "Tissue Type"),
    p( "Start Codon"),
    p( "Stop Codon"),
    p( "Expression Level"),
    '<ul>';
  
  foreach(  ) {
    print li( $_ );
  }
  
  print '</ul>',
    end_html;

my $db_file   = './data.db';
my $data_file = './data.fasta';

my @sequence_records = _read_and_parse_data_file( $data_file );

my $dbh = DBI->connect( "DBI:SQLite:dbname=$db_file" , "" , "" ,
                        { PrintError => 0 , RaiseError => 1 } )
  or die DBI->errstr;

my %lookups;
foreach ( qw/ organism tissue gene / ) {
  $lookups{$_} = _create_lookup_table( $dbh , $_ , @sequence_records );
}

my $gene_org_sth =
  $dbh->prepare( "INSERT INTO gene_organism VALUES ( ? , ? , ? , ? , ? , ?)" );

my $expression_sth =
  $dbh->prepare( "INSERT INTO gene_organism_expression VALUES( NULL , ? , ? , ? )" );

my $count = 1;
foreach my $rec ( @sequence_records ) {
  $gene_org_sth->execute(
    $count ,
    $lookups{gene}{ $rec->{gene} } ,
    $lookups{organism}{ $rec->{organism} } ,
    $rec->{sequence} ,
    $rec->{start} ,
    $rec->{stop} ,
  );

  $expression_sth->execute(
    $count ,
    $lookups{tissue}{ $rec->{tissue} } ,
    $rec->{level} ,
  );

  $count++;
}



sub _read_and_parse_data_file {
  my $file = shift;

  open( my $IN , '<' , $file )
    or die( "Unable to open $file : $!" );

  my( $defline , $seq , @seqs );

  chomp( $defline = <$IN> );
  while ( my $line = <$IN> ) {
    chomp $line;
    if ( $line =~ /^>/ ) {
      my $record = _parse_defline_to_record( $defline );
      $record->{sequence} = $seq;
      push @seqs , $record;

      # and reset for the next round
      $defline = $line
    }
    else { $seq .= $line }
  }

  close( $IN );

  # and finish parsing the last record
  my $record = _parse_defline_to_record( $defline );
  $record->{sequence} = $seq;
  push @seqs , $record;

  return @seqs;
}

sub _parse_defline_to_record {
  my $defline = shift;

  my( $gene , $org , $tissue , $start , $stop , $level )
    = split /\|/ , $defline;

  $gene =~ s/^>//;

  return {
    gene     => $gene ,
    organism => $org ,
    tissue   => $tissue ,
    start    => $start ,
    stop     => $stop ,
    level    => $level ,
  };

}

sub _create_lookup_table {
  my( $dbh , $table , @records ) = @_;

  my %records = map { $_->{$table} => 1 } @records;

  my $sth = $dbh->prepare( "INSERT INTO $table VALUES( ?, ?)" );

  my $count = 1;
  foreach ( keys %records ) {
    $records{$_} = $count;
    $sth->execute( $count++ , $_ );
  }

  return \%records;
}
