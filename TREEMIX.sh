#####
##### TreeMix & Treepop
##### require the file "within" which denote the population labels for plink stratictifation of SNP frequencies

vcf=freebayes.SNPs.filtered.final.recode.intersect.edit.vcf
plink --vcf $vcf --freq --within within --allow-extra-chr
gzip plink.frq

plink2treemix.py plink.frq.gz treemix.frq.gz

for i 1..10};do
  treemix -i treemix.gz -o $i -k 1000 -m $i -root Ard;
done

treepop -i treemix -k 1000
