#! /bin/bash -x
#
##SBATCH --job-name="SplitRef"
##SBATCH --partition=all
#SBATCH --cpus-per-task=3    
##SBATCH --output=/home/adeiturrate/splitRef_%j.out
##SBATCH --error=/home/adeiturrate/splitRef_%j.err
##
#
#This script creates a reference genome with the artificial chromosomes to work in the step in which the VCF files have artificial chromosomes too.
cd /projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome/DurumRef_split
ref=/projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome/Triticum_turgidum.Svevo.v1.dna_rm.genomic.fa

split_fasta_dir=/projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome/DurumRef_split
module load samtools/1.9
awk '{print $1 "\t" $2}' ${ref}.fai > Svevo1_chr_names_lengths.txt

while read line ; do
  chr=$(echo $line | awk '{print $1}')
  length=$(echo $line | awk '{print $2}')
  echo $chr
  echo $length
  samtools faidx $ref ${chr}:1-400000000 > ${split_fasta_dir}/Svevo1_${chr}_1.fa &
  samtools faidx $ref ${chr}:400000001-${length} > ${split_fasta_dir}/Svevo1_${chr}_2.fa &
done < Svevo1_chr_names_lengths.txt

cat ${split_fasta_dir}/*.fa >> Triticum_turgidum_Svevo.v1_genomic.artificial_chrom_split.fa
module unload samtools/1.9
