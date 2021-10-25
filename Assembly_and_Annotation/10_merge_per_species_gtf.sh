#!bin/bash

# anna.duenser@gmail.com
# April 2020
# stringtie_merge
## merge the .gtf files originated from single .bam files (and then merged) and the ones from merged .bam files


FILE_DIR="/cl_tmp/singh_duenser/Ehsan"

for i in `ls $FILE_DIR/stringtie_merged_bam/*.gtf | cut -d "/" -f 6 | cut -d "." -f1`;

do

qsub -pe mpi 10 -l h_vmem=10G -b y -cwd -N "all_gtf_merge."$i \
-e $FILE_DIR/all_gtf_merged/"all_gtf_merged."$i".err" -o $FILE_DIR/all_gtf_merged/"all_gtf_merged."$i".out" \
/usr/people/EDVZ/duenser/tools/stringtie-2.0.6.Linux_x86_64/stringtie --merge -F 1.0 -T 1.0 \
$FILE_DIR/stringtie_single/stringtieMerge_single/"stringtieMerge_single."$i".gtf" \
$FILE_DIR/stringtie_merged_bam/$i".MergedBam.gtf" \
-o $FILE_DIR/species_gtf_merged/"species_gtf_merged."$i".gtf" &

echo "yesyesyes"
sleep 1

done

