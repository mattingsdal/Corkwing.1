### run ADMIXTURE loop in 100 replications for k 1-10 for relevant bed file
vcf=specify vcf file
convert vcf to plink bed file and generate random SNP snames generating admix_names file to admixture

for i in {50..100}
do
for K in 1 2 3 4 5 6 
do
admixture -j20 --seed $RANDOM --cv admix_names.bed $K |  tee {$i}_log${K}.out
mv "admix_names.${K}.Q" "${i}_admix_names.${K}.Q"
mv "admix_names.${K}.P" "${i}_admix_names.${K}.P"
done
done

vcftools --het $vcf

# zip Q files and submit to CLUMPAK server

R
library(Cairo)

##### K = 2
tbl=read.table("admix.2.Q")
indTable=read.table("pop_info.txt",col.names = c("Sample", "Sex", "Pop"))
tbl2=cbind(tbl,indTable[,1],indTable[,3])

tbl=read.table("admix.3.Q")
indTable=read.table("pop_info.txt",col.names = c("Sample", "Sex", "Pop"))
tbl3=cbind(tbl,indTable[,1],indTable[,3])

het=read.table("corkwing.het.txt",sep="",header=T)
index=c(grep("ARD",het[,1]),grep("SM",het[,1]),grep("NH",het[,1]),grep("ST",het[,1]),grep("EG",het[,1]),grep("AR6",het[,1]),grep("TV",het[,1]),grep("GF",het[,1]))
HET=het[index,]


#### K = 3
index=c(grep("ARD",tbl2[,3]),grep("SM",tbl2[,3]),grep("NH",tbl2[,3]),grep("ST",tbl2[,3]),grep("EG",tbl2[,3]),grep("AR6",tbl2[,3]),grep("TV",tbl2[,3]),grep("GF",tbl2[,3]))

ord2 = tbl2[index,]
ord3 = tbl3[index,]




################ PLOT
Cairo(file="ADMIXTURE.combined.full.pdf",type="pdf",width=160,height=80,units="mm")
par(mfrow=c(3,1),mar = c(3,4,1,0))
barplot(t(as.matrix(ord2)), space = c(0),xlim=c(0,65),col=c("#ffd700","#4169e1"),xlab="", names.arg=ord2[,3],ylab="Ancestry",border=NA,las=2,cex.names=0.3,main="K=2",cex=0.5,cex.main=0.5)
barplot(t(as.matrix(ord3)), space = c(0),xlim=c(0,65),col=c("#ffd700","#ff4500","#4169e1"),xlab="", names.arg=ord3[,4],ylab="Ancestry",border=NA,las=2,cex.names=0.3,main="K=3",cex=0.5,cex.main=0.5,bty="n")
cl=c(rep("#ffd700",7),rep("#ff4500",24),rep("#4169e1",35))
barplot(t(as.matrix(ord4[,5])),space=0,col="black",xlim=c(0,65),ylim=c(-0.6,0.4),ylab="F",las=2,cex.main=0.5,main="Inbreeding coefficient",cex.names=0.3,cex=0.5,border=NA)
dev.off()



