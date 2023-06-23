#!/bin/bash -x 
#
#SBATCH --job-name="rmDupl"
#SBATCH --partition=all
#SBATCH --output=/home/adeiturrate/out/rmDupl%j.out  
#SBATCH --error=/home/adeiturrate/error/rmDupl%j.err 
#SBATCH --mem=70G
#SBATCH --cpus-per-task=7
#
#
#
#This script is use to mark and removed duplicate (add -r in the line) for the bam file. This script is just done for one sample. In this case as the files are very big we need to include the --overflow-list-size 600000 --hash-table-size 60000000 but if it is not big it is not necessary.
#load required modules
module load sambamba/0.8.0
module load picard/2.22.3
module load gatk/3.8.0
module load samtools/1.9

#define a random number to be assigned as RGID in AddReplaceGroups; this info depends on sequencing, to distinguish between samples; if this info is not availble, just assign it randomly
rgid=$(((RANDOM % 10000)+1))

#set working directory

cd /scratch/125-emmer/Ander/Alignments
ALNS=/projects/125-emmer/Wang2022_emmer_fastq/Alignments
REF=projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome/Triticum_turgidum.Svevo.v1.dna_rm.genomic.fa
splits="/scratch/125-emmer/Ander/Splits_aln"

ID=GT024
echo 'done replacing read groups, starting duplicate removal'
sambamba markdup --tmpdir=/scratch/125-emmer/Ander/Sambamba --overflow-list-size 600000 --hash-table-size 60000000 -t 8 $ALNS/GT024.sorted.merged.pe-memDurum.RG.bam ${ID}.sorted.merged.pe-memDurum.nodupl.RG.bam
#Index using samtools to create a .csi index (required if chromosomes are longer than 512Mbp)
samtools index -c ${ID}.sorted.merged.pe-memDurum.nodupl.RG.bam
samtools stats ${ID}.sorted.merged.pe-memDurum.nodupl.RG.bam > ${ID}.sorted.merged.pe-memDurum.nodupl.RG.stats
echo 'done processing file' $ID


module unload sambamba/0.8.0
module unload gatk/3.8.0
module unload picard/2.22.3
module unload samtools/1.9
