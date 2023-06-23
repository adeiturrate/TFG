#!/bin/bash

#

#SBATCH --job-name="idx"

#SBATCH --cpus-per-task=5

#SBATCH --mem=32G

#SBATCH --partition=all

#SBATCH --output=/home/adeiturrate/out/dwnld_%j.out

#SBATCH --error=/home/adeiturrate/error/dwnld_%j.err

#
#This script creates the indexes for the reference genome which will be necessary for some steps.
module load bwa/0.7.16
bwa index /projects/125-emmer/Wang2022_emmer_fastq/Reference_Genome/Triticum_turgidum.Svevo.v1.dna_rm.genomic.fa
module unload bwa/0.7.16