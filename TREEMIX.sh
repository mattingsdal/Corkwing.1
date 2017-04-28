#####
##### TreeMix & Treepop
##### require the file "within" which denote the population labels for plink stratictifation of SNP frequencies

vcf=freebayes.SNPs.filtered.final.recode.intersect.edit.vcf
plink --vcf $vcf --freq --within within --allow-extra-chr
gzip plink.frq

plink2treemix.py plink.frq.gz treemix.frq.gz

treemix -i treemix.gz -o out -k 1000 -m 2 -root Ard
treepop -i treemix -k 1000
