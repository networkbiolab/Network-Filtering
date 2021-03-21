#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)



my $tf = "TFs.list";
my $mg = "mito_genes.tsv";

my %k = ();
open(F,"<", $tf) or die "can't open $tf\n";
while(my $l = <F>){
	chomp $l;
	$k{$l} = "TF";
}
close F;
open(F,"<", $mg) or die "can't open $mg\n";
while(my $l = <F>){
	chomp $l;
	my @t = split("\t", $l);
	if(!exists $k{$t[0]}){
		$k{$t[0]} = $t[1];
	}
}
close F;

my $f = shift @ARGV;#net file without header

my %n = ();
$f=~ /(.*)\.tsv$/;
my $o = $1;
$o .= "_mito.tsv";

open(F,"<", $f) or die "can't open $f\n";
open(FO,">", $o) or die "can't open $o\n";
while(my $l = <F>){
	chomp $l;
	my @t = split("\t", $l);
	if(exists $k{$t[1]}){
		print FO "$l\n";
	}
}	
close F;
close FO;
