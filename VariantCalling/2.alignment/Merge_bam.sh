#!/bin/bash -x 
#
#SBATCH --job-name="mergebam"
#SBATCH --partition=all
#SBATCH --output=/home/adeiturrate/out/merge%j.out  
#SBATCH --error=/home/adeiturrate/error/merge%j.err 
#SBATCH --mem=32G
#SBATCH --cpus-per-task=5
#
#
#
#This script merge the bam files resulting from the alignment
#load required modules
module load  picard/2.22.3
module load gatk/3.8.0
module load samtools/1.9

#define a random number to be assigned as RGID in AddReplaceGroups; this info depends on sequencing, to distinguish between samples; if this info is not availble, just assign it randomly
rgid=$(((RANDOM % 10000)+1))

#set working directory

cd /projects/125-emmer/Wang2022_emmer_fastq/Alignments
ALNS=/scratch/125-emmer/Wang2022_emmer_fastq/Alignments/
REF=projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome/Triticum_turgidum.Svevo.v1.dna_rm.genomic.fa
splits="/scratch/125-emmer/Ander/Splits_aln"

for FILE in $splits/GT0${1}*_0000.sorted.pe-memDurum.bam
do
	ID=$(echo ${FILE} | cut -f6 -d '/' | cut -f1 -d '_')
	echo 'processing file '$ID
	#samtools merge ${ID}.sorted.merged.se-memDurum.bam ${ID}.sorted.se-memDurum.bam ${ID}.batch2.sorted.se-memDurum.bam #here oly two file to merge, below for multiple bam splits
	samtools merge ${ID}.sorted.merged.pe-memDurum.bam $splits/${ID}*.sorted.pe-memDurum.bam
	#AddOrReplaceGrops: fixes RG fields in bam file: required by following steps. Don't create index for chromosomes longer than 512Mbp (doesn't work), use samtools instead
	java -Xmx32g -Xms32g -jar $PICARDPATH/picard.jar AddOrReplaceReadGroups I=${ID}.sorted.merged.pe-memDurum.bam O=${ID}.sorted.merged.pe-memDurum.RG.bam RGID=$rgid RGLB=lib1 RGPL=Illumina RGPU=unit1 RGSM=${ID} CREATE_INDEX=False
	echo 'done replacing read groups, starting duplicate removal'
done

#modules unload
echo "modules unloaded"

module unload gatk/3.8.0
module unload picard/2.22.3
module unload samtools/1.9
