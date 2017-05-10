cd /usit/abel/u1/mortema/software/lamp-ld
# test is largest contig 5 Mb

# order ped file according to sort.txt file

plink --file test --indiv-sort file sort.txt --make-bed --out test2
plink --bfile test2 --recode --out test2

perl lait.pl lamp 2 test2.map test2.ped out/
cd out
/usit/abel/u1/mortema/software/lamp-ld/bin/lamp/bin/lamp config.txt
rm -rf tmp
/usit/abel/u1/mortema/software/lamp-ld/bin/lamp/bin/generategraph.sh ~/software/lamp-ld/out/ancestry.txt
