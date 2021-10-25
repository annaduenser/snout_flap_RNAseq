#!/bin/bash

#pooja.singh09@gmail.com
#RNA star assembles reads into transcripts using a reference genome guide
#March 2020
########### Change '-N' jobname, '-l h_vmem=' (storage), '-pe smp #' (number of cores)
########### mapping to reference O. niloticus reference genome with 5 bioreprs per species 


for i in `cat starinput.txt`;

do

qsub -q all.q -pe smp 8 -l h_vmem=4G -cwd -V -N $i".STAR" -e $i".STAR.err" -o $i".STAR.log" -b y STAR --runThreadN 8 \
 --genomeDir /cl_tmp/singh_duenser/reference \
 --readFilesCommand gunzip -c \
 --readFilesIn ./trimmomatic/$i".1.paired.fq.gz" ./trimmomatic/$i".2.paired.fq.gz" \
 --outSAMtype BAM SortedByCoordinate \
 --twopassMode None \
 --outFileNamePrefix ./star_assembly/$i"." \
 --quantMode GeneCounts \
 --outSAMstrandField intronMotif \
 --outSAMattrIHstart 1 \
 --outSAMattributes NH HI AS nM NM MD MC jM jI ch XS \
 --outSAMprimaryFlag OneBestScore \
 --outSAMmapqUnique 60 \
 --outSAMunmapped Within  \
 --outFilterIntronStrands RemoveInconsistentStrands \
 --outBAMsortingBinsN 50  \
 --limitBAMsortRAM 4000000000 &

done
