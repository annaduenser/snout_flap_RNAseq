#!/bin/bash

# anna.duenser@gmail.com
# nose flap samples 
# ! copy TrueSeq3-PE-2.fa to cwd

########### trim adapters and drop reads shorter than 70 bp

for i in `ls *.fq.gz | grep .1.fq.gz | cut -f -2 -d"."`;

do


qsub -q all.q -b y -cwd -N trim -l h_vmem=4G -pe smp 8 -o $i".trim.log" -e $i".trim.err" /usr/bin/java -jar /cl_tmp/singh_duenser/tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 8 /cl_tmp/singh_duenser/Ehsan/$i".1.fq.gz" /cl_tmp/singh_duenser/Ehsan/$i".2.fq.gz" /cl_tmp/singh_duenser/Ehsan/trimmomatic/$i".1.paired.fq.gz" /cl_tmp/singh_duenser/Ehsan/trimmomatic/$i".1.unpaired.fq.gz" /cl_tmp/singh_duenser/Ehsan/trimmomatic/$i".2.paired.fq.gz" /cl_tmp/singh_duenser/all_adult/trimmomatic/$i".2.unpaired.fq.gz" ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10:8:keepBothReads SLIDINGWINDOW:4:28 MINLEN:70 &

done
