#!/bin/bash -x
#
################# PARALLELIZE BWA MEM ALIGNMENT OF SAMPLE(S) BY RUNNING IT SIMULTANOUSLY ON ALL THE SLPITTED FASTQ OF THAT SAMPLE(S) #####################
# This script takes one sample fastq, counts the number of splits in which the sample was previosly divided (split_fastq.sub) and defines a job
# array of N=MAX jobs, where MAX is the number of splits for that specific sample.    
# Then it calls the script bwa_mem_splits.sub for the array, aligning in parallel all  split of the sample (one by one).
########################################################################################################################################################## 
#
#
PROJECT="/projects/125-emmer/"
SCRATCH="/projects/125-emmer/Wang2022_emmer_fastq/AdapterRemoval"
SPLITS="/scratch/125-emmer/Ander/Splits"


for FILE in $(ls $SCRATCH/GT0${1}*paired.pair1.truncated.gz |  cut -f6 -d'/' | cut -f1 -d'_') #getSampleID 
        do
		echo "${FILE}"
                MAX=$(ls -lh $SPLITS/${FILE}_pair1.truncated*.gz | wc -l)
                echo "##Launching "$MAX" alignments for "$FILE"."
                sbatch --array 1-$MAX -o /home/adeiturrate/$FILE"_bwa_memD_%a.out" -e /home/adeiturrate/$FILE"_bwa_memD_%a.err" --exclude=huberman,node001,node002,node012,node021 /projects/125-emmer/Wang2022_emmer_fastq/Scripts/bwa_mem_splits230221.sub $FILE
        done


