import sys
from glob import glob

bedFiles = glob("/home/leandro/Desktop/pre_WEoN/TFs_ChIP/W_L3_TF_ENCODE/*.bed")

# with open(sys.argv[1]) as file:
#     data = file.readlines()

for bed in bedFiles:
    TF = bed.split("/")[-1][:-4]
    if "_" in TF:
        TF = TF[:-2]
    # print(TF)
    with open(bed) as file:
        data = file.readlines()
        for line in data:
            sp_line = line.split("\t")[:-1]
            if "chr" in sp_line[0]:
                sp_line[0] = sp_line[0].replace("chr","")
            print(sp_line[0]+"\t"+TF+"\tTF_binding_site\t"+sp_line[1]+"\t"+sp_line[2]+"\t.\t.\t.\t"+"ID=;Name=;Dbxref=;library=;bound_moiety=unknow:"+TF)
            # input(".")
