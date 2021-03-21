import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-G","--geneFile",help="Genes annotation file in GFF format",required=True)
parser.add_argument("-T","--tfbsFile",help="Output of TFBSs in GFF format",required=True)
parser.add_argument("-D","--DRegion",help="Distance of Regulatory Region",type=int,required=True)
parser.add_argument("-O","--outFile", help="Output file",required=True)

args = parser.parse_args()

Dict = {}
with open(args.geneFile) as file:
    dataGenes = file.readlines()

for line in dataGenes:
    if "##" not in line:
        line = line[:-1]
        line = line.split("\t")
        if "gene" in line[2]:
            attr = line[8].split(";")
            attr[0] = attr[0].replace("ID=","")
            if line[0] not in Dict:
                Dict[line[0]] = {}
            if line[6] not in Dict[line[0]]:
                Dict[line[0]][line[6]] = {}

            Dict[line[0]][line[6]][attr[0]] = (int(line[3]),int(line[4]))

del(dataGenes)

Net = {}
with open(args.tfbsFile) as file:
    dataTFBS = file.readlines()

# aux = 0
out=open(args.outFile,"w")
for line in dataTFBS:
    # if aux == 1 and len(line) > 1 and "#" not in line:
    line = line.split("\t")
    attr = line[8].split(";")
    attr[0] = attr[0].replace("ID=","")
    list = []
    for j in attr:
        if "bound_moiety" in j:
            tmp = j.replace("bound_moiety=","")
            tmp = tmp[:-1]
            if "," in tmp:
                list = tmp.split(",")
            else:
                list.append(tmp)
    list_2 = []
    for x in list:
        aux = x.split(":")
        list_2.append(aux[1])

    if line[0] in Dict:
        for i in Dict[line[0]]:
            for j in Dict[line[0]][i]:
                reg = ""
                if i == "+":
                    if int(line[3]) < Dict[line[0]][i][j][0] and int(line[4]) > Dict[line[0]][i][j][0] - args.DRegion:
                        for y in list_2:
                            reg = y+"\t"+j+"\t"+str(1)+"\t"+line[0]
                            if reg not in Net:
                                coor = []
                                coor.append(line[3]+","+line[4])
                                Net[reg] = coor
                            else:
                                Net[reg].append(";"+line[3]+","+line[4])
                                # print(Net[reg])
                            # out.write(y+"\t"+j+"\t"+str(1)+"\t"+line[3]+","+line[4]+"\t"+line[0]+"\t"+"TFBS"+"\n")
                if i == "-":
                    if int(line[3]) < Dict[line[0]][i][j][1] + args.DRegion and int(line[4]) > Dict[line[0]][i][j][1]:
                        for y in list_2:
                            reg = y+"\t"+j+"\t"+str(1)+"\t"+line[0]
                            if reg not in Net:
                                coor = []
                                coor.append(line[3]+","+line[4])
                                Net[reg] = coor
                            else:
                                Net[reg].append(";"+line[3]+","+line[4])
                            # out.write(y+"\t"+j+"\t"+str(1)+"\t"+line[3]+","+line[4]+"\t"+line[0]+"\t"+"TFBS"+"\n")
# del(dataFimo)
del(dataTFBS)

for key in Net:
    sp_key = key.split("\t")
    out.write(sp_key[0]+"\t"+sp_key[1]+"\t"+sp_key[2]+"\t"+str(Net[key]).replace("[","").replace("]","").replace("'","").replace(" ","").replace(",;",";")+"\t"+sp_key[3]+"\tTFBS\n")

out.close()
