# Network-Filtering
Our protocol starts by gathering as many TF ChIP-seq experiments, then each TFBS is assigned
to the regulation of likely target genes based on proximity to the transcription start site 
of all genes. In the final step, we employ a random forest-based method and more than nine 
thousand RNA-seq experiments for Drosophila melanogaster to try to select the most likely regulatory 
TFs assigned with the distance threshold for each gene. We employed known TF protein protein 
interactions to estimate the feasibility of regulatory events in our filtered networks. Finally, 
we show how topological characteristics of the networks are improved based on the increase of 
known physical interactions between co-regulatory TFs of each gene. We then employed our GRNs 
to create a network centered on Hr96 to demonstrate how the noise reduction improves the recovery 
of known control mechanisms of gene transcription.

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)


FILE MANIPULATION:

files intended for general file manipulation

- fbid2symbol.pl
changes flybase ids for accepted  gene symbols. Requires the file fbgn_annotation file in the same folder where it is run


APPROACH (GENIE3 can be found here https://github.com/aertslab/GENIE3):

- filterGENIE3out.pl
filters the output of Genie3 to keep only likely edges.

- getonlyTFconnectance.pl
get the connectance between TFs in filtered and in referenfe GRNs

- doimputGENIE3.pl
generates imput files for GENIE3 from asci file with gene counts and a Reference network



ANALYSIS:

- getsubnets_hr96.pl
reads a tsv GRN and gets all hr96 neighbours and the regulations between them

- domitonets.pl
filter networks to keep only mitchondrial genes, requires  TFs.list and mito_genes.tsv in the same folder

- doCORtest.pl
reads correlation matrix and compute mena correlation between genes sharing regulators

- getonlyTFnets.pl
get only TF nets from all genes net

- docornets.pl
filter correlation nets to keep only correlations above certain thresholds

- getTFsubnets.pl
generate nets made of only certain genes

REFERENCE NETWORKS:

- ReferenceNetwork.py 
create reference gene regulatory networks for D. melanogaster combining TFBS information from the ChIP-Seq available at the ENCODE data repository and Flybase

DATA:

- string_interactions.tsv
STRING reported interactiosn between TFs

- TFs.list 
List of all TFs employed in this work

- mito_genes.tsv
genes asocited to mitochondria

 



Protocol followed to generate Gene counts data file from ARCHS4Zoo:

h5dump -d/meta/genes -d /data/expression  -o Drosophila_melanogaster_genecount_v1.asci  -y -w 1000000000 Drosophila_melanogaster_genecount_v1.h5

sed -i "s/\"//g" Drosophila_melanogaster_genecount_v1.asci

sed -i "s/ //g" Drosophila_melanogaster_genecount_v1.asci

first line (empty) deleted with vim


