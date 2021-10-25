#!bin/bash

# anna.duenser@gmail.com
# September 2020
# stringtie
## Run stringtie with the new annotations
# -M to reduce multimapping, -e to only allow transcripts in the hopefully soon filtered annotation file, --rf strand info, -B ballgown files

FILE_DIR_STAR="/cl_tmp/singh_duenser/Ehsan/star_assembly"
FILE_DIR_OUT="/cl_tmp/singh_duenser/Ehsan/count_matrices"
FILE_DIR_ANNO="/cl_tmp/singh_duenser/Ehsan/gffread"

for i in `cat samples_samtools_idx.txt`;
 
do

qsub -q all.q -pe smp 8 -l h_vmem=4G -cwd -V -N $i".stringtie.all" \
-o $FILE_DIR_OUT/"log.stringtie.all.out" -e $FILE_DIR_OUT/"log.stringtie.all.err" -b y \
/usr/people/EDVZ/duenser/tools/stringtie-2.0.6.Linux_x86_64/stringtie -M 0.0 -e -B -G \
$FILE_DIR_ANNO/final.filtered.gffread.gffcmp.nose.annotated.gtf \
--rf  -o $FILE_DIR_OUT/$i/transcripts.gtf \
-A $FILE_DIR_OUT/$i/gene_abundance.tsv \
$FILE_DIR_STAR/$i".Aligned.sortedByCoord.out.bam"

sleep 1

done 

