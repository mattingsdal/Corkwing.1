cd /usit/abel/u1/mortema/software/lamp.x86_64-unknown-linux-gnu.REL_2_5/test
chr=SYMME00023145

plink --bfile ~/vcf/haplotypes_name_sort --chr $chr --within within.plink --freq --allow-extra-chr
awk '$3 == "ard" {print $6}' plink.frq.strat>ard.frq
awk '$3 == "west" {print $6}' plink.frq.strat>west.frq
awk '$3 == "south" {print $6}' plink.frq.strat>south.frq

plink --bfile ~/vcf/haplotypes_name_sort --chr $chr --recode A --out test --allow-extra-chr
plink --bfile ~/vcf/haplotypes_name_sort --chr $chr --recode --out test --allow-extra-chr
awk '{print $4}' test.map >posfile.txt
cut --delimiter=' ' -f7-  test.raw | sed 's/ /\t/g' | sed 1d | sed 's/NA/-1/g' >test.geno
../bin/lamp config.txt

rm -rf tmp/
../bin/generategraph.sh ancestry.txt

