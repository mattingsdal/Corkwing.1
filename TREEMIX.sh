#####
##### TreeMix & Treepop
##### require the file "within" which denote the population labels for plink stratictifation of SNP frequencies

vcf=freebayes.SNPs.filtered.final.recode.intersect.edit.vcf
# admix_names is vcf file with random SNP files
plink --bfile admix_names --missing --cluster --freq --within within2.txt --allow-extra-chr
gzip plink.frq.strat

plink2treemix.py plink.frq.strat.gz treemix.gz

treemix -i treemix.gz -k 1000 -m 3 -root Ardtoe -o corkwing -se -bootstrap -seed 666

for i in {1..10};do
  treemix -i treemix.gz -o $i -k 1000 -m ${i} -root Ardtoe -se -bootstrap -seed 43;
done

treepop -i treemix -k 1000

source("treemix-1.13/src/plotting_funcs.R")
plot tree("1")
plot_resid("1", "poporder")
