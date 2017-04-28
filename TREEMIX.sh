#####
##### TreeMix & Treepop
##### require the file "within" which denote the population labels for plink stratictifation of SNP frequencies

vcf=freebayes.SNPs.filtered.final.recode.intersect.edit.vcf
plink --vcf $vcf --missing --cluster --freq --within within --allow-extra-chr
gzip plink.frq

plink2treemix.py plink.frq.gz treemix.frq.gz

treemix -i treemix.frq.gz -k 1000 -m 3 -root ard -o corkwing -se -bootstrap -seed 666

for i 1..10};do
  treemix -i treemix.gz -o $i -k 1000 -m $i -root Ard;
done

treepop -i treemix -k 1000


source("src/plotting funcs.R")
plot tree("1")
plot_resid("1", "poporder")
