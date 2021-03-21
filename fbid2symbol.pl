#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)



#changes flybase ids for accepted  gene symbols 

my $f = shift @ARGV;

my $fblist = "fbgn_annotation_ID_fb_2020_02.tsv";# FlyBase FBgn-Annotation ID Correspondence Table, get it from FlyBase and replace its name here
open(F, "<", $fblist) or die "can't open $fblist\n";
my @d = <F>;
close F;
my %di = ();

shift @d;
shift @d;
shift @d;
shift @d;
shift @d;


#~ print "$d[0]\n";

while(my $l = shift @d){
	chomp $l;
	my @t = split("\t", $l);
	$di{$t[2]} = $t[0];
	my @tt = split(',', $t[3]);
	for my $i (@tt){
		$di{$i} = $t[0];
	}
	#~ print "@tt\n";
}

my $fo = "$f.sym";
if($f =~ /(.*)\.tsv/){
	$fo = "$1_sym.tsv";
}

open(FO, ">", $fo) or die "can't open $fo\n";
open(F, "<", $f) or die "can't open $f\n";
while(my $l = <F>){
	chomp $l;
	my @t = ();
	while($l =~ /(FBgn\d\d\d\d\d\d\d)/g){
		push(@t, $1);
	}
	#~ print @t;
	for my $i (@t){
		if(exists $di{$i}){
			$l =~ s/$i/$di{$i}/g;
		}
	}
	#~ print "$l\n";
	print FO "$l\n";
}
close FO;
close F;
