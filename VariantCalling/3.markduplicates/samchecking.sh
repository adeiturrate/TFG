#! /bin/bash -x
#
##SBATCH --job-name="checksam"
##SBATCH --partition=all
#SBATCH --cpus-per-task=3    
##SBATCH --output=/home/adeiturrate/splitRef_%j.out
##SBATCH --error=/home/adeiturrate/splitRef_%j.err
##
#
#This script is used to check if everything works well
module load samtools/1.9
cd /projects/125-emmer/Wang2022_emmer_fastq/Alignments
echo 'this is a check file' > sambamba_checking.txt
for file in /projects/125-emmer/Wang2022_emmer_fastq/Alignments/*nodupl.RG.bam
do
        echo $file >> sambamba_checking.txt
        header=$(samtools view -H $file)
        echo $header >> sambamba_checking.txt
        echo "sample check DONE \n" >> sambamba_checking.txt
done
module unload samtools/1.9