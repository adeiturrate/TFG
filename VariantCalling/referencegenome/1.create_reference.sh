#!/bin/bash

#

#SBATCH --job-name="merchr"

#SBATCH --cpus-per-task=3

#SBATCH --partition=all

#SBATCH --output=/home/adeiturrate/out/dwnld_%j.out

#SBATCH --error=/home/adeiturrate/error/dwnld_%j.err

#
#This script combines the fastq of the chromosomes to create the reference with all the chromosomes 
module load samtools/1.9
cd /projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome/

for FILE in /projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome/*.fa
do
	cat $FILE >> Triticum_turgidum.Svevo.v1.dna_rm.genomic.fa
done
faidx genomic.fa
module unload samtools/1.9