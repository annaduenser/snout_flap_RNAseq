#!/bin/bash

# anna.duenser@gmail.com
# March 2020
# multiqc
#### input: fastqc from initial .fq files, fastqc files after trimmomatic, mapped .bam files
FILE_DIR="/cl_tmp/singh_duenser/Ehsan"

qsub -q all.q -b y -cwd -N multiqc -l h_vmem=4G -pe smp 8 -o "log.multiqc.out" -e "log.multiqc.err" /usr/people/EDVZ/duenser/.local/bin/multiqc \
--interactive $FILE_DIR/fastqc/ $FILE_DIR/trimmomatic/fastqc/ $FILE_DIR/star_assembly/
