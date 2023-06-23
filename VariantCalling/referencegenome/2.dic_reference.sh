#!/bin/bash -x 
#
#SBATCH --job-name="dic"
#SBATCH --partition=all
#SBATCH --output=/home/adeiturrate/out/dic%j.out  
#SBATCH --error=/home/adeiturrate/error/dics%j.err 
#SBATCH --mem=32G
#SBATCH --cpus-per-task=5
#
#
#
#This script creates the .dic file for the reference which would be necessary for the variant calling

module load gatk/4.1.6
gatk CreateSequenceDictionary -R Triticum_turgidum.Svevo.v1.dna_rm.genomic.fa
module unload gatk/4.1.6