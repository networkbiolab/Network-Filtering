#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)



my $f = shift @ARGV;#network file /home/amartin/Work/FLY_NET/RefNet_WEoN/RefNet_1500_gffENCODE_chips_6.32.tsv
my $e = shift @ARGV;#expresion matrix /home/amartin/Work/FLY_NET/DMel/Drosophila_melanogaster_genecount_v1.asci


my %net = ();

open(F, "<", $f) or die "can't open $f\n";
while(my $l = <F>){
	my @t = split("\t", $l);
	$net{$t[1]}{$t[0]} = 1;
}
close F;

#~ my $h = `head -n2 $e|tail -n1`;
my $h = `head -n1 $e`;
chomp $h;
chomp $h;
#~ print "$h\n";
my @n = split(",",$h);
my %o = ();
for (my $i = 0; $i < @n; $i++){
	$o{$n[$i]} = ($i+1);
	#~ print "$i||$n[$i]||$o{$n[$i]}||\n";
}
my @l = sort keys %net;

my $c = 1;


#awk -v OFS="\t" -F"," '{print $1, $2}'
for my $i(@l){
	if(exists $o{$i}){
		my $d = '$' . "$o{$i}";
		#~ print "$d||$o{$i}||$i\n";
		my $cc = 0;
		for my $j (sort keys %{$net{$i}}){
			if(exists $o{$j}){
				$d .= ', $' . "$o{$j}";
				$cc++;
			}
		}
		if($cc > 0){
			#~ print "awk -v OFS=\"\\t\" -F\"\,\" '{print $d}' $e > $c.txt";
			print `awk -v OFS=\"\\t\" -F\"\,\" '{print $d}' $e > $c.txt`;
			$cc = $cc/2;
			open(F, ">", "$c.py") or die "can't open $c.py";
			print F "#!/usr/bin/python3
from GENIE3 import *

data = loadtxt(\'$c.txt\',skiprows=1)
f = open(\'$c.txt\')
gene_names = f.readline()
f.close()
gene_names = gene_names.rstrip(\'\\n\').split(\'\\t\')
regulators = gene_names.copy()
regulators.pop(0)
ntrees = 1000
VIM = GENIE3(data,gene_names=gene_names,regulators=regulators,K=$cc,ntrees=ntrees)
get_link_list(VIM,gene_names=gene_names, regulators=regulators,file_name=\'$c\_out.txt\')";
			close F;
			open(F, ">", "$c.sh") or die "can't open $c.sh";
			print F "python3 $c.py
grep $i $c\_out.txt > $i.out
rm $c.py $c.txt $c\_out.txt $c.sh
";
			close F;
			$c++;
		}
	}
	if($c>1){exit;}
}
