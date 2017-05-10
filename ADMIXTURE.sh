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

# zip Q files and submit to CLUMPAK server

R
library(Cairo)

##### K = 2
tbl=read.table("admix.2.Q")
indTable=read.table("pop_info.txt",col.names = c("Sample", "Sex", "Pop"))
tbl2=cbind(tbl,indTable[,1],indTable[,3])
ord2 = tbl2[order(tbl2[,4],tbl2[,3]),]

#### K = 3
tbl=read.table("admix.3.Q")
indTable=read.table("pop_info.txt",col.names = c("Sample", "Sex", "Pop"))
tbl3=cbind(tbl,indTable[,1],indTable[,3])
ord3 = tbl3[order(tbl3[,5],tbl3[,4]),]

################ PLOT
Cairo(file="ADMIXTURE.combined.full.pdf",type="pdf",width=160,height=80,units="mm")
par(mfrow=c(2,1),mar = c(3,4,1,0))
barplot(t(as.matrix(ord2)), space = c(0),xlim=c(0,80),col=c("#ffd700","#4169e1"),xlab="", names.arg=ord2[,3],ylab="Ancestry",border=NA,las=2,cex.names=0.3,main="K=2",cex=0.5,cex.main=0.5)
legend("topright",legend=c("Ard","West","South"),fill=c("#ffd700","#ff4500","#4169e1"),bty="n",cex=0.7)
barplot(t(as.matrix(ord3)), space = c(0),xlim=c(0,80),col=c("#ffd700","#ff4500","#4169e1"),xlab="", names.arg=ord3[,4],ylab="Ancestry",border=NA,las=2,cex.names=0.3,main="K=3",cex=0.5,cex.main=0.5,bty="n")
dev.off()
