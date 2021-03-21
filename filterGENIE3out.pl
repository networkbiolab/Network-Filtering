#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)



my $thres = 0.01;

my $f = shift @ARGV;
$f =~ /(FBgn\d\d\d\d\d\d\d)\.out/;
my $name = $1;

open (F, "<", $f) or die "can't open $f";
my $l = <F>;
chomp $l;
my @t = split("\t", $l);
my $max = $t[2];
open (FO, ">", "$f". "f" ) or die "can't open $f\f\n";

if($t[1] eq $name && ($t[2]/$max) >= $thres && $t[0] ne $t[1]){
	print FO "$t[0]\t$t[1]\t1\n";
}
while(my $l = <F>){
	chomp $l;
	my @t = split("\t", $l);
	if($t[1] eq $name && ($t[2]/$max) >= $thres  && $t[0] ne $t[1]){
		my $tmp = sprintf("%.3f",($t[2]/$max));
		print FO "$t[0]\t$t[1]\t$tmp\n";
	}
}
close F;
close FO;
