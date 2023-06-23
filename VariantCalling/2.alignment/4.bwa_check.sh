#! /bin/bash -x
#
##SBATCH --job-name="checkbam"
##SBATCH --partition=all
#SBATCH --cpus-per-task=3    
##SBATCH --output=/home/adeiturrate/splitRef_%j.out
##SBATCH --error=/home/adeiturrate/splitRef_%j.err
##
#
#This script creates files to check the alignment works well
module load samtools/1.9
cd /projects/125-emmer/Wang2022_emmer_fastq/Alignments
echo 'this is a check file' > bam_checking.txt
for file in /projects/125-emmer/Wang2022_emmer_fastq/Alignments/*sorted.merged.pe-memDurum.bam
do
        echo $file >> bam_checking.txt
        header=$(samtools view -H $file)
        echo $header >> bam_checking.txt
        echo "sample check DONE \n" >> bam_checking.txt
done
module unload samtools/1.9
