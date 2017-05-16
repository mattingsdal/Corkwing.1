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


Ardtoe=c(-5.88232,56.76745)
Smola=c(8.00687,63.38657)
Norheimsund=c(6.14564,60.37089)
Stavanger=c(5.73311,58.96998)
Egersund=c(5.99980,58.45142)
Arendal=c(8.77245,58.46176)
Tvedestrand=c(8.93140,58.62228)
Gullmarn=c(11.43333,58.25)

index=c("A","B","C","D","E","F","G","H")
col=c("#ffd700","#ff4500","#ff4500","#ff4500","#4169e1","#4169e1","#4169e1","#4169e1")

tmp=data.frame(rbind(Ardtoe,Smola,Norheimsund,Stavanger,Egersund,Arendal,Tvedestrand,Gullmarn))
loc=cbind(tmp,index,col)

################ PLOT

Cairo(file="ADMIXTURE.combined.full.pdf",type="pdf",width=160,height=80,units="mm")
nf=layout(matrix(c(1,2,3,4,4,4),3,2),widths=c(5,5))
#par(mfrow=c(3,1),mar = c(3,4,1,0))
par(mar=c(2,2,0.5,0))
barplot(t(as.matrix(ord2)), space = c(0),xlim=c(0,65),col=c("#ffd700","#4169e1"),xlab="", names.arg=ord2[,3],ylab="Ancestry",border=NA,las=2,cex.names=0.3,cex=0.5,cex.main=0.5)
par(mar=c(2,2,0.5,0))
barplot(t(as.matrix(ord3)), space = c(0),xlim=c(0,65),col=c("#ffd700","#ff4500","#4169e1"),xlab="", names.arg=ord3[,4],ylab="Ancestry",border=NA,las=2,cex.names=0.3,cex=0.5,cex.main=0.5,bty="n")
cl=c(rep("#ffd700",7),rep("#ff4500",24),rep("#4169e1",35))
par(mar=c(2,2,0,0))
barplot(t(as.matrix(ord4[,5])),space=0,col="black",xlim=c(0,65),ylim=c(-0.6,0.4),ylab="F",las=2,cex.main=0.5,cex.names=0.3,cex=0.5,border=NA)

par(mar=c(2,2,0.5,1))
plot(loc[,1],loc[,2],col=as.character(loc[,4]),pch=19,cex=1,ylim=c(56,63.5),xlim=c(-6.5,11))
text(8,60,label="Norway",col="grey80",cex=0.5,font=3)
text(-3.5,57,label="Scotland",col="grey80",cex=0.5,font=3)
text(9.5,56.3,label="Denmark",col="grey80",cex=0.5,font=3)
map(add = T, interior = F, col = "grey80")
points(loc[,1],loc[,2],col="black",pch=19,cex=1,ylim=c(56,63.5))
text(loc[,1]-0.5,loc[,2],label=c("ARD","SM","NH","ST","EG","AR","TV","GF"),pos=3,cex=0.5)
dev.off()



