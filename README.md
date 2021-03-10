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
