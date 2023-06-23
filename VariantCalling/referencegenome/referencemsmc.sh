#!/bin/bash -x
#
#SBATCH --job-name="ref"
#SBATCH --partition=all
#SBATCH --cpus-per-task=3    
#SBATCH --output=/scratch/125-emmer/Ander/output/ref%j.out
#SBATCH --error=/scratch/125-emmer/Ander/error/ref%j.err
cd /projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome
module load conda
conda activate 
module load bioconda
for FILE in Triticum_turgidum.Svevo.v1.dna_rm.chromosome*
do
	seqkit subseq -r 1:100000000, -r -100000000:-1  $FILE >> Triticum_turgidum.Svevo.v1.dna_rm.genomic.msmc.fa
done
module load bioconda
conda deactivate
module unload conda