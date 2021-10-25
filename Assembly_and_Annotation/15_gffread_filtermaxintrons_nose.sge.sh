#
#$ -N gffread	        # Job name
#$ -S /bin/bash         # Set shell to bash
#
#$ -l h_vmem=2G         # Request Max. Virt. Mem.
#
#$ -cwd                 # Change to current working directory
#$ -V                   # Export environment variables into script
#$ -pe smp 2    # Select the parallel environment
#
#$ -o log.$JOB_NAME.$JOB_ID.out      # SGE-Output File
#$ -e log.$JOB_NAME.$JOB_ID.err      # SGE-Error File

#print some info to log
echo "Running under shell '${SHELL}' in directory '`pwd`' using $NSLOTS slots"
echo "Host: $HOSTNAME"
echo "Job: $JOB_ID"

#get going
echo -e "\n$(date)\n"

########### '-N' jobname, '-l h_vmem=' (Speicher), '-pe smp number' (number of cores)

# anna.duenser@gmail.com
# April 2020
# gffread
## use gffread to filter out introns longer than in the reference (200000)

FILE_DIR="/cl_tmp/singh_duenser/Ehsan"

for i in `ls $FILE_DIR/gffcompare/filtered.*.annotated.gtf | cut -d "/" -f 6`;

do 

gffread $FILE_DIR/gffcompare/$i -o $FILE_DIR/gffread/"gffread."$i -i 200000 -T

done


