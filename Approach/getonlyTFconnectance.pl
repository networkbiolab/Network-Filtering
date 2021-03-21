#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)



my $tff = shift @ARGV;#curated_TFs_net.tsv

my %ppi = ();
my %net = ();
my %res = ();
my %gen = ();
open(F, "<", $tff) or die "can't open $tff\n";
while(my $l = <F>){
	chomp $l;
	my @t = split("\t",  $l);
	$ppi{$t[0]}{$t[1]} = 1;
	$ppi{$t[1]}{$t[0]} = 1;
}
close F;

my $f = '';
my @kn = ();
#only in pairs and genie alwyas first
# genie3_1500uniq.tsv RefNet_1500_gffENCODE_chips_6.32.tsv genie3_2000uniq.tsv RefNet_2000_gffENCODE_chips_6.32.tsv genie3_5000.tsv RefNet_5000_gffENCODE_chips_6.32.tsv
while($f ne ">" && @ARGV){
	$f = shift @ARGV;
	my $si = 0;
	if($f =~ /genie3/){
		$si = 1;
	}
	if(-e $f){
		push(@kn, $f);
		open(F, "<", $f) or die "can't open $f\n";
		while(my $l = <F>){
			chomp $l;
			my @t = split("\t",  $l);
			$net{$t[1]}{$t[0]} = 1;# target TF
		}
		for my $i (sort keys %net){
			my @o = sort keys %{$net{$i}};
			my $n = @o;
			my $pc = $n * ($n-1) * 0.5;
			my $tc = 0;
			$res{$i}{$f} = 0;
			for (my $j = 0; $j < $n; $j++){
				for (my $k = $j+1; $k < $n; $k++){
					if(exists $ppi{$o[$j]}{$o[$k]}){
						$tc++;
					}
				}
			}
			if($n > 2){#more than 2 regulators
				$res{$i}{$f} = sprintf("%.4f",$tc/$pc);
				#~ $res{$i}{$f} = $tc/$pc;
				#~ if($si){$gen{$i}++;}
				$gen{$i}++;
			}
			#~ else{
				#~ $res{$i}{$f} = 0;
			#~ }
		}
		%net = ();
	}
	else{print "$f does not exists\n";}
}


my %res2 = ();
my @g = sort keys %gen;
my $nn = @kn;
print "gene\t" . join ("\t", @kn) . "\n";
for my $i(@g){
	if($gen{$i} >= $nn){#only works for pair of nets
		my $o = "";
		my $con = "";
		for (my $j = 0; $j < @kn; $j += 2){
			if(exists $res{$i}{$kn[$j]} && exists $res{$i}{$kn[$j+1]}){
				$o .= "\t$res{$i}{$kn[$j]}\t$res{$i}{$kn[$j+1]}";
				my $tmp = $res{$i}{$kn[$j]}-$res{$i}{$kn[$j+1]};
				$con .= "\t$tmp";
				if($tmp > 0){
					$res2{$kn[$j]}[0]++;
				}
				elsif($tmp < 0){
					$res2{$kn[$j]}[1]++;
				}
				else{
					$res2{$kn[$j]}[2]++;
				}
				$res2{$kn[$j]}[3]++;
			}
			else{
				$o .= "na\tna";
			}
		}
		print "$i$o$con\n";
	}
}
print "\n";
for (my $j = 0; $j < @kn; $j += 2){
	print "\t$kn[$j]";
}
print "\n";
for my $i (0,1,2,3){
	print "$i";	
	for (my $j = 0; $j < @kn; $j += 2){
		print "\t$res2{$kn[$j]}[$i]";
	}
	print "\n";
}
print "$tff\t$kn[0]\t" . ($res2{$kn[0]}[0]/$res2{$kn[0]}[3]) . "\t" . ($res2{$kn[0]}[1]/$res2{$kn[0]}[3]) . "\t" . ($res2{$kn[0]}[2]/$res2{$kn[0]}[3]) . "\t$res2{$kn[0]}[3]\n";
print "\n";
