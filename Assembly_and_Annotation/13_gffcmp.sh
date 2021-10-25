#!bin/bash

# anna.duenser@gmail.com
# November 2020
# gffcompare
## annotate .gtf files

# -r comparing with a reference annotation - will produce class codes: https://ccb.jhu.edu/software/stringtie/gffcompare.shtml
# -e Maximum distance (range) allowed from free ends of terminal exons of reference transcripts when assessing exon accuracy. By default, this is 100.
# -d Maximum distance (range) for grouping transcript start sites, by default 100.

FILE_DIR="/cl_tmp/singh_duenser/Ehsan"

qsub -pe mpi 10 -l h_vmem=10G -b y -cwd -N gffcmp.stepwise \
-e $FILE_DIR/gffcompare/gffcmp.nose.stepwise.err -o $FILE_DIR/gffcompare/gffcmp.nose.stepwise.out \
/usr/people/EDVZ/duenser/tools/gffcompare-0.11.2.Linux_x86_64/gffcompare -r /cl_tmp/singh_duenser/reference/O_niloticus_UMD_NMBU.99.gff3 -e 100 -d 100 \
$FILE_DIR/species_gtf_merged/all_gtf_merged/merged.nose.gtf -o $FILE_DIR/gffcompare/gffcmp.stringtieMerge_stepwise.nose
