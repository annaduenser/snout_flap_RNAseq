#
#$ -N merge_nose_lake	# Job name
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

# anna.duenser@gmail.com
# November 2020
# stringtie --merge
## merge .gtf files

stringtie -p 10 --merge -T 1 -F 1 \
./species_gtf_merged/species_gtf_merged.Lt.gtf \
./species_gtf_merged/species_gtf_merged.Tt.gtf \
-o ./species_gtf_merged/merged.LM.nose.gtf

stringtie -p 10 --merge -T 1 -F 1 \
./species_gtf_merged/species_gtf_merged.On.gtf \
./species_gtf_merged/species_gtf_merged.Ov.gtf \
-o ./species_gtf_merged/merged.LT.nose.gtf
