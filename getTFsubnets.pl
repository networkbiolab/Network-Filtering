#!/usr/bin/perl
$| = 1;

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)



#1500 Hr96
#~ my %list = ('Dll',1,'Zif',1,'usp',1,'CrebB',1,'CG1233',1,'bigmax',1,'cnc',1,'CG15011',1,'GATAe',1,'Mondo',1,'ERR',1,'dl',1,'MTF-1',1,'Hr96',1);
#2000 Hr96
#~ my %list = ('Mondo',1,'BtbVII',1,'bigmax',1,'usp',1,'Dll',1,'CG15011',1,'ERR',1,'CG1233',1,'dl',1,'CrebB',1,'MTF-1',1,'cnc',1,'GATAe',1,'Hr96',1,'CG9727',1,'Eip93F',1,'Zif',1);
#5000 Hr96
#~ my %list = ('pad',1,'Hr83',1,'Hey',1,'CG1233',1,'CG9727',1,'cnc',1,'usp',1,'Zif',1,'Eip93F',1,'dl',1,'bigmax',1,'Mondo',1,'ERR',1,'GATAe',1,'BtbVII',1,'Dll',1,'MTF-1',1,'CG15011',1,'nom',1,'CrebB',1,'Hr96',1);
#Refseq1500 Hr96
my %list = ('Sry-delta',1,'Eip93F',1,'CG43347',1,'CG8089',1,'CG9727',1,'Zif',1,'pita',1,'phol',1,'CG15011',1,'kay',1,'CG3919',1,'MTF-1',1,'Su(H)',1,'Hr96',1,'Mef2',1,'NK7.1',1,'Dad',1,'ttk',1,'prg',1,'CG4820',1,'usp',1,'scrt',1,'Meics',1,'CG10431',1,'cg',1,'Bdp1',1,'h',1,'CG4707',1,'oc',1,'CG1792',1,'cnc',1,'ERR',1,'BtbVII',1,'CG1647',1,'ovo',1,'Dp',1,'CrebB',1,'BuGZ',1,'mirr',1,'Atf3',1,'Eip74EF',1,'GATAe',1,'pad',1,'dl',1,'fkh',1,'Med',1,'disco',1,'HmgD',1,'MESR4',1,'Camta',1,'cad',1,'Pdp1',1,'p53',1,'her',1,
'sbb',1,'CG12299',1,'Mondo',1,'pzg',1,'gfzf',1,'lilli',1,'NC2alpha',1,'Sox14',1,'CG3281',1,'CHES-1-like',1,'Dll',1,'Six4',1,'CG10147',1,'bigmax',1,'brk',1,'CG34376',1,'D19B',1,'Xbp1',1,'Kah',1,'crp',1,'CG18476',1,'CG10274',1,'bcd',1,'CG1233',1,'Hr38',1,'CrebA',1,'CG45071',1);

my $f = shift @ARGV;
open (F, "<",$f) or die "can't open $f\n";
while (my $l = <F>){
	chomp $l;
	my @t = split ("\t",$l);
	if(exists $list{$t[0]} && exists $list{$t[1]}){
		print "$l\n";
	}
	#~ else{
		#~ print "No\n";
	#~ }
} 
close F;
