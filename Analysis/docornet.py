#!/usr/bin/python3

#AJMM
#alberto.martin@umayor.cl
#(proteinomano@gmail.com)


from scipy.spatial.distance import pdist
names = []
d = [[]]

with open ( "Drosophila_melanogaster_genecount_v1.asci" , 'r') as f :
	l = f.readline ()
	l = l.rstrip()
	names = l.split(',')
	d = [[] for y in range(len(names))]
	for l in f :
		l = l.rstrip()
		t = l.split(',')
		for i in range (len(names)):
			
			d[i].append(int(t[i]))

dd = pdist(d, 'correlation')
c = 0

fo = open ( "coornet.tsv" , 'w')
for i in range (len(names)):
	for j in range (i+1,len(names)):
		fo.write("{}\t{}\t{:.4f}\n".format(names[i],names[j],1-dd[c]))
		c += 1


fo.close()
