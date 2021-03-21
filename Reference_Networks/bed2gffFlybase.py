#LMS
#leandro.murgas@mayor.cl

import sys
from glob import glob

bedFiles = glob(sys.argv[1]) #Enter the path folder of the files .bed to convert

for bed in bedFiles:
    TF = bed.split("/")[-1][:-4]
    if "_" in TF:
        TF = TF[:-2]
    with open(bed) as file:
        data = file.readlines()
        for line in data:
            sp_line = line.split("\t")[:-1]
            if "chr" in sp_line[0]:
                sp_line[0] = sp_line[0].replace("chr","")
            print(sp_line[0]+"\t"+TF+"\tTF_binding_site\t"+sp_line[1]+"\t"+sp_line[2]+"\t.\t.\t.\t"+"ID=;Name=;Dbxref=;library=;bound_moiety=unknow:"+TF)
