#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)



my $co = 'allDM3_net_sym.tsv';#corr net
my %con = ();
open(F, "<", $co) or die "can't open $co\n";
while(my $l = <F>){
	chomp $l;
	my @t = split("\t", $l);
	$con{$t[1]}{$t[0]} = $t[2];#node2 node1 cor
}
close F;

#net1
my $f = shift @ARGV;#REFseq
%n = ();
%node = ();
%tf = ();
open(F, "<", $f) or die "can't open $f\n";
while(my $l = <F>){
	chomp $l;
	my @t = split("\t", $l);
	$n{$t[1]}{$t[0]} = 1;#node target
	$node{$t[1]}++;
	$tf{$t[0]}++;
}
close F;

#net2
my $f2 = shift @ARGV;#GENIE3
%n2 = ();
%node2 = ();
%tf2 = ();
open(F, "<", $f2) or die "can't open $f2\n";
while(my $l = <F>){
	chomp $l;
	my @t = split("\t", $l);
	$n2{$t[1]}{$t[0]} = 1;#node target
	$node2{$t[1]}++;
	$tf2{$t[0]}++;
}
close F;

#sort nodes by indegree
my @list = sort { $node{$a} <=> $node{$b} } keys %node;
my @resa = ();#average
my @resn = ();#number
my @ress = ();#std dev
my $max = $node{$list[$#list]};
#~ print "$max\n";
for (my $i = 0; $i <= $max; $i++){
	$resa[$i] = 0;
	$resn[$i] = 0;
	$ress[$i] = 0;
}
#go over list
for (my $t = 2; $t <= $max; $t++){
	while($node{$list[0]} < $t){
		my $l = shift @list;
		#regulators of l
		my @k = keys %{$n{$l}};
		#~ print "@k\n";
		#check if share $t -1 tfs 
		for my $i (@list){
			my $c = 0;
			#check how many TFs shared
			for my $j (@k){
				if(exists $n{$i}{$j}){
					$c++;
				}
			}
			if($c > 0){
				#~ for (my $k = 1; $k <= $c; $k++){
					if(exists $con{$l}{$i} && $con{$l}{$i} ne 'nan'){
						$resa[$c] += $con{$l}{$i};
						$resn[$c]++;
						$ress[$c]  .= "$con{$l}{$i} ";
						#~ delete $con{$l}{$i};
					}
					elsif(exists $con{$i}{$l}  && $con{$l}{$i} ne 'nan'){
						$resa[$c] += $con{$i}{$l};
						$resn[$c]++;
						$ress[$c]  .= "$con{$i}{$l} ";
						#~ delete $con{$i}{$l};
					}
				#~ }
				#~ print "$c\n";
			}
		}
		%{$n{$l}} = ();
		delete $n{$l};
	}
}

$f = `basename $f`;
chomp $f;
print "$f\n";
for (my $i = 1; $i < $max; $i++){
	my $a = 0;
	if($resn[$i] > 0){
		$a = sprintf('%.3f',$resa[$i]/$resn[$i]);
		chop $ress[$i];
		my @t = split(' ', $ress[$i]);
		my $s = 0;
		open (FO, ">", "$f\_$i\_counts") or die "can't open $f\_$i\_counts";
		print FO "$ress[$i]";
		close FO;
		for my $j(@t){
			$s += (($j -$a) * ($j -$a));
		}
		#~ $s /= $resn[$i];
		#~ $s = sprintf('%.3f',$s/$resn[$i]);
		$s = $s/$resn[$i];
		print "$i\t$a\t$s\t$resn[$i]\n";
	}
	else{
		print "$i\t$a\t0\t0\n";
	}
}


#sort nodes by indegree
my @list2 = sort { $node2{$a} <=> $node2{$b} } keys %node2;
my @resa2 = ();#average
my @resn2 = ();#number
my @ress2= ();#std dev
my $max2 = $node2{$list2[$#list2]};
#~ print "$max\n";
for (my $i = 0; $i <= $max2; $i++){
	$resa2[$i] = 0;
	$resn2[$i] = 0;
	$ress2[$i] = 0;
}
#go over list
for (my $t = 2; $t <= $max2; $t++){
	while($node2{$list2[0]} < $t){
		my $l = shift @list2;
		#regulators of l
		my @k = keys %{$n2{$l}};
		#~ print "@k\n";
		#check if share $t -1 tfs 
		for my $i (@list2){
			my $c = 0;
			#check how many TFs shared
			for my $j (@k){
				if(exists $n2{$i}{$j}){
					$c++;
				}
			}
			if($c > 0){
				#~ for (my $k = 1; $k <= $c; $k++){
					if(exists $con{$l}{$i} && $con{$l}{$i} ne 'nan'){
						$resa2[$c] += $con{$l}{$i};
						$resn2[$c]++;
						$ress2[$c]  .= "$con{$l}{$i} ";
						delete $con{$l}{$i};
					}
					elsif(exists $con{$i}{$l}  && $con{$l}{$i} ne 'nan'){
						$resa2[$c] += $con{$i}{$l};
						$resn2[$c]++;
						$ress2[$c]  .= "$con{$i}{$l} ";
						delete $con{$i}{$l};
					}
				#~ }
				#~ print "$c\n";
			}
		}
		%{$n2{$l}} = ();
		delete $n2{$l};
	}
}


$f2 = `basename $f2`;
chomp $f2;
print "$f2\n";
for (my $i = 1; $i < $max2; $i++){
	my $a = 0;
	if($resn2[$i] > 0){
		$a = sprintf('%.3f',$resa2[$i]/$resn2[$i]);
		chop $ress2[$i];
		my @t = split(' ', $ress2[$i]);
		open (FO, ">", "$f2\_$i\_counts") or die "can't open $f2\_$i\_counts";
		print FO "$ress2[$i]";
		close FO;
		my $s = 0;
		for my $j(@t){
			$s += (($j -$a) * ($j -$a));
		}
		#~ $s /= $resn[$i];
		#~ $s = sprintf('%.3f',$s/$resn[$i]);
		$s = $s/$resn2[$i];
		print "$i\t$a\t$s\t$resn2[$i]\n";
	}
	else{
		print "$i\t$a\t0\t0\n";
	}
}



