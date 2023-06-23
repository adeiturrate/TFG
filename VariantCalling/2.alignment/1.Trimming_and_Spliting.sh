#!/bin/bash

#

#SBATCH --job-name="trimming-spliting"

#SBATCH --cpus-per-task=6

#SBTACH --mem=32G

#SBATCH --partition=all

#SBATCH --output=/home/adeiturrate/out/dwnld_%j.out

#SBATCH --error=/home/adeiturrate/error/dwnld_%j.err

#
#This script is use to split the fastq because the BWA aligner cannot be use with large chromosomes 
cd /projects/125-emmer/Wang2022_emmer_fastq/AdapterRemoval
module load adapterremoval/2.3.1

for FILE in /projects/125-emmer/Wang2022_emmer_fastq/*1.fastq.gz 
do
        NAME=$(echo ${FILE}| cut -f 5 -d '/' | cut -f 1 -d '_')
        F1=/projects/125-emmer/Wang2022_emmer_fastq/${NAME}_*1.fastq.gz;
        R2=/projects/125-emmer/Wang2022_emmer_fastq/${NAME}_*2.fastq.gz;
        echo 'removing adapters from sample' ${NAME}
        AdapterRemoval --file1 ${F1} --file2 ${R2} --basename ${NAME}_paired --trimns --trimqualities --collapse --gzip;
        FF=/projects/125-emmer/Wang2022_emmer/AdapterRemoval/${NAME}_paired.pair1.truncated.gz;
		RR=/projects/125-emmer/Wang2022_emmer/AdapterRemoval/${NAME}_paired.pair2.truncated.gz;
		
		echo "splitting ${NAME} forward reads"
		zcat $FF | split -a 4 -d -l 40000000  - ${NAME}'_pair1.truncated.' --filter='gzip>$FILE.gz' > /scratch/125-emmer/Ander/Splits ;  

		echo "splitting ${NAME} reverse reads" ;
		zcat $RR | split -a 4 -d -l 40000000  - ${NAME}'_pair2.truncated.' --filter='gzip>$FILE.gz' > /scratch/125-emmer/Ander/Splits;
	
		echo "splitting file ${NAME} completed"
done  	

module unload adapterremoval/2.3.1