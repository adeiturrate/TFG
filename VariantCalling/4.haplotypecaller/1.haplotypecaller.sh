#!/bin/bash -x 
#
#SBATCH --job-name="rmDupl"
#SBATCH --partition=all
#SBATCH --output=/home/adeiturrate/out/rmDupl%j.out  
#SBATCH --error=/home/adeiturrate/error/rmDupl%j.err 
#SBATCH --mem=32G
#SBATCH --cpus-per-task=3
#
#
#
#load required modules
module load picard/2.22.3
module load gatk/4.1.6
module load samtools/1.9

ALNS=/projects/125-emmer/Wang2022_emmer_fastq/Alignments/

ID=GT0${1}
echo "running haplotype caller on sample ${ID}" 
bash /projects/125-emmer/Wang2022_emmer_fastq/Scripts/call_GATK_variantcall_perChr_scratch.sub $ID
echo "haploypcaller job submitted"

#modules unload
echo "modules unloaded"

module unload gatk/4.1.6
module unload picard/2.22.3
module unload samtools/1.9
