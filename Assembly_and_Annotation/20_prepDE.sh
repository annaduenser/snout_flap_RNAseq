#!bin/bash

# anna.duenser@gmail.com
# April 2020
# run prepDE.py

FILE_DIR="/cl_tmp/singh_duenser/Ehsan/count_matrices"

qsub -q all.q -pe smp 12 -l h_vmem=4G -cwd -V -N prepDE_LM \
-o $FILE_DIR/log.prepDE_LM.out -e $FILE_DIR/log.prepDE_LM.err -b y \
/usr/people/EDVZ/duenser/tools/stringtie-2.0.6.Linux_x86_64/prepDE.py -i $FILE_DIR/sample_prepDE_LM.txt \
-g $FILE_DIR/gene_count_matrix_nose_LM.csv -t $FILE_DIR/transcript_count_matrix_nose_LM.csv  -l 125

qsub -q all.q -pe smp 12 -l h_vmem=4G -cwd -V -N prepDE_LT \
-o $FILE_DIR/log.prepDE_LT.out -e $FILE_DIR/log.prepDE_LT.err -b y \
/usr/people/EDVZ/duenser/tools/stringtie-2.0.6.Linux_x86_64/prepDE.py -i $FILE_DIR/sample_prepDE_LT.txt \
-g $FILE_DIR/gene_count_matrix_nose_LT.csv -t $FILE_DIR/transcript_count_matrix_nose_LT.csv  -l 125

echo -e "\n$(date)\n"

