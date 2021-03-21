#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)


my $f = shift @ARGV;
open(F, "<", $f) or die "can't open $f\n";
my $l = <F>;
chomp $l;
my %n = ();
my %c = ();
my @h = split("\t",$l);
shift @h;
shift @h;
shift @h;
shift @h;
while($l = <F>){
	chomp $l;
	my @t = split("\t",$l);
	shift @t;
	shift @t;
	for (my $i = 0; $i < @h; $i++){
		$n{$t[0]}{$t[1]}{$h[$i]} = $t[$i+2];
		if($t[$i] > 0){
			$t[$i] =~ /^(\d)\.(\d)/;
			$c{$h[$i]}{"$1$2"}++;
			#~ for (my $j = 0; $j < 10; $j++){
				#~ my $th = $j * 0.1;
				#~ if($t[$i] > $th){
					#~ print "";
					#~ $c{$h[$i]}{"0$j"}++;
				#~ }
			#~ }
		}
	}
}
close F;


for (my $i = 0; $i < 10; $i++){
	for (my $j = 0; $j < @h; $j++){
		my $check = $c{$h[$j]}{"0$i"};
		for (my $k = $i+1; $k < @10; $k++){
			$check += $c{$h[$j]}{"0$k"};
		}
		#~ if($c{$h[$j]}{"0$i"} > 10){
		if($check > 1){
			open(F, ">", "$h[$j]_0$i");
			my $t = $i * 0.1;
			for my $n1 (sort keys %n){
				for my $n2 (sort keys %{$n{$n1}}){
					if($n{$n1}{$n2}{$h[$j]} > $t){
						print F "$n1\t$n2\t$n{$n1}{$n2}{$h[$j]}\n";
					}
				}
			}
			close F;
		}
	}
}
