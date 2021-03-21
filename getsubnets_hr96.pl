#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)


my $f = shift @ARGV;#mitonetwork

my %n = ();

my %k = ();
my %nk = ();
#~ $k{"cnc"} = 1;
#~ $k{"Eip75B"} = 1;
$k{"Hr96"} = 1;
#~ $k{"Eip78C"} = 1;
#~ $nk{"cnc"} = 1;
#~ $nk{"Eip75B"} = 1;
#~ $nk{"Hr96"} = 1;
#~ $nk{"Eip78C"} = 1;

my $c = join('_', sort keys %k);
$f =~ /(.*)\.tsv/;
my $o = $1;

#~ my $tf = "/home/amartin/Work/papers/yesis_redes/data/TFs.list";
#~ my $mg = "/home/amartin/Work/papers/yesis_redes/data/mito_genes.tsv";

my %n = ();
open(F,"<", $f) or die "can't open $f\n";
while(my $l = <F>){
	chomp $l;
	my @t = split("\t", $l);
	$n{$t[0]}{$t[1]} = 1;
	if(exists $k{$t[0]}){
		$nk{$t[1]} = 1;
	}
}
close F;

open(F, ">", "$o\_$c.tsv") or die "can't open $o\_$c.tsv\n";
for my $i(sort keys %n){
	for my $j(sort keys %{$n{$i}}){
		if (exists $nk{$j}){
			print F "$i\t$j\t1\n";
		}
	}
}
close F;
