#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)


my $f = shift @ARGV;
$f =~ /(.*)\.tsv/;
my $n = $1; 
open(F, "<", $f) or die "can't open $f\n";

open(F3, ">", "$n\_35.tsv") or die "can't open $n\_35.tsv";
open(F4, ">", "$n\_45.tsv") or die "can't open $n\_45.tsv";
open(F5, ">", "$n\_55.tsv") or die "can't open $n\_55.tsv";
open(F6, ">", "$n\_65.tsv") or die "can't open $n\_65.tsv";
open(F7, ">", "$n\_75.tsv") or die "can't open $n\_75.tsv";
open(F8, ">", "$n\_85.tsv") or die "can't open $n\_85.tsv";
open(F9, ">", "$n\_95.tsv") or die "can't open $n\_95.tsv";
while(my $l = <F>){
	chomp $l;
	my @t = split("\t", $l);
	if($t[2] > 0.35){
		print  F3 "$l\n";		
		if($t[2] > 0.45){
			print  F4 "$l\n";					
			if($t[2] > 0.55){
				print  F5 "$l\n";									
				if($t[2] > 0.65){
					print  F6 "$l\n";									
					if($t[2] > 0.75){
						print  F7 "$l\n";															
						if($t[2] > 0.85){
							print  F8 "$l\n";															
							if($t[2] > 0.95){
								print  F9 "$l\n";
							}
						}
					}
				}
			}
		}
	}
}
close F;
close F3;
close F4;
close F5;
close F6;
close F7;
close F8;
close F9;
