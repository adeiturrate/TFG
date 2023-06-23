#Load the libraries
library(tidyverse)
library(vcfR)
library(adegenet)
library(gtools)
library(ggplot2)
library(adegenet)
library(RColorBrewer)

#Set working directory
setwd("/home/orocabert/ander")


#read VCF and sample data, check the correspondece of individuals between the two
VCF <- read.vcfR("all_emmer_wgs_NATChr.biallSNPs.hardfiltPASS.NoSin.NOhetpositions.NoOutgroup.infocorrect.90.LDfilt0.1.vcf.gz")
pop.data <-
  read.table("locationswgsDAPC.csv", sep =
               "\t", header = TRUE)
all(colnames(VCF@gt)[-1] == pop.data$SAMPLE)
cbbPalette <- c("#000000","#009E73", "#E69F00","#0072B2", "#CC79A7","#56B4E9","#D55E00","#F0E442" )

glemmer <- vcfR2genlight(VCF)
ploidy(glemmer) <- 2
pop(glemmer) <- pop.data$GEO
cols<-brewer.pal(nPop(glemmer), name = "Dark2")
glemmer

f1 <- function(vec) {
  m <- mean(vec, na.rm = TRUE)
  vec[is.na(vec)] <- m
  return(vec)
}

glemmer2= apply(glemmer,2,f1)
xv<-xvalDapc(glemmer2, glemmer$pop, n.pca.max = 30, training.set = 0.9,
             result = "groupMean", center = TRUE, scale = FALSE, n.pca = NULL, n.rep =
               10, xval.plot = TRUE)
xv

emdapc <- dapc(glemmer, n.pca = 5, n.da = 3)

scatter(emdapc, col = cols, cex = 2, legend = TRUE, clabel = F, posi.leg =
          "topleft", scree.pca = TRUE, posi.pca = "topright", cleg = 0.75,
        cstar=0, cell=0, label.inds = list(air = 0.6, pch = NA),ylim=c(-10,10),xlim=c(-10,10))



