#!bin/bash

# anna.duenser@gmail.com
# fastqc on trimmed reads
# November 2020
########### Change '-N' jobname, '-l h_vmem=' (storage), '-pe smp #' (number of cores)
########### fastqc of trimmed reads


for i in `cat samples_fastqc_trim.txt`;

do

qsub -q all.q -pe smp 8 -l h_vmem=4G -cwd -V -N $i".fastqc" -o ./trimmomatic/fastqc"log."$i".fastqc.out" -e ./trimmomatic/fastqc"log."$i".fastqc.err" -b y fastqc -t 12 \
-o /cl_tmp/singh_duenser/Ehsan/trimmomatic/fastqc /cl_tmp/singh_duenser/Ehsan/trimmomatic/$i".paired.fq.gz" &

done
