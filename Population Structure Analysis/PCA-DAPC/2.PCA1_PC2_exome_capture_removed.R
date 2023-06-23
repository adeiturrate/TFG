library(tidyverse)

cbbPalette <- c("#000000","#009E73", "#E69F00","#0072B2", "#CC79A7","#56B4E9","#D55E00","#F0E442" )

#1. Read the files containing containing eigenvectors (tab-separated table) and eigenvalues (list of values)
pca <- read_tsv("/home/orocabert/ander/all_emmer_wgs_NATChr.biallSNPs.hardfiltPASS.NoSin.NOhetpositions.NoOutgroup.infocorrect.90.LDfilt0.1.eigenvec")
eigenval <- scan("/home/orocabert/ander/all_emmer_wgs_NATChr.biallSNPs.hardfiltPASS.NoSin.NOhetpositions.NoOutgroup.infocorrect.90.LDfilt0.1.eigenval")

#2.a Modify the data in order to: a)delete the first column (sample name repeated twice) and b)specify sample features (e.g. domestic or wild, location) 
pca <- pca[,-1]

#2.b Make two list of length = number of individuals : one with WILD or DOMESTIC based on the sample name (eg sampleW or sampleD) and one reporting the samples provenience (IMPORTANT! in the text file the sample locations MUST be in the same order as the samples in the pca table)
spp <- rep(NA, length(pca$IID))
spp[grep("W", pca$IID)] <- "WILD"
spp[grep("D", pca$IID)] <- "DOM"
loc <- read_lines("/home/orocabert/ander/locationwgs.csv") 

# This info can be merged to get a new column with both status and location of the sample
spp_loc <- paste0(spp,"_", loc)

#3. Make a new table that comprises the added info
PCAinfo<-as_tibble(data.frame(pca, spp, loc, spp_loc))

#4. Derive and plot the % of variance explained by the PCs: first convert to % the eigenvalues, then plot
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)
pveplot <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
pveplot + ylab("Percentage variance explained") + theme_light()

#5. Plot the PCA
pcaplot<- ggplot(pca, aes(PC1, PC2, col = loc, shape = spp)) + geom_point(size = 3) + coord_equal() + theme_light() + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)")) + coord_cartesian(xlim = c(-0.4, 0.4), ylim = c(-0.4, 0.4))
pcaplot

#6. Since the resulting plot has too many colors, it would be helpful to group the locations by broader geographical classifications
geo<-rep(NA, length(PCAinfo$IID))
geo[grep("DOM_Iran_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("DOM_Turkey_MD", PCAinfo$spp_loc)] <- "D-MD"
geo[grep("DOM_Syria_MD", PCAinfo$spp_loc)] <- "D-MD"
geo[grep("DOM_Spain_MD", PCAinfo$spp_loc)] <- "D-MD"
geo[grep("DOM_Croatia_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("DOM_Turkey_SE", PCAinfo$spp_loc)] <- "D-SE"
geo[grep("DOM_India_SE", PCAinfo$spp_loc)] <- "D-SE"
geo[grep("DOM_Georgia_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("DOM_Turkey_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("DOM_Israel_MD", PCAinfo$spp_loc)] <- "D-MD"
geo[grep("DOM_Italy_MD", PCAinfo$spp_loc)] <- "D-MD"
geo[grep("DOM_Slovenia_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("DOM_Bosnia and Herzegovina_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("DOM_Oman_SE", PCAinfo$spp_loc)] <- "D-SE"
geo[grep("DOM_Israel_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("DOM_Armenia_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("DOM_Ukraine_NW", PCAinfo$spp_loc)] <- "D-NW"
geo[grep("WILD_Israel_SL", PCAinfo$spp_loc)] <- "W-SL"
geo[grep("WILD_Turkey_NL", PCAinfo$spp_loc)] <- "W-NL"
geo[grep("WILD_Lebanon_SL", PCAinfo$spp_loc)] <- "W-SL"
geo[grep("WILD_Syria_SL", PCAinfo$spp_loc)] <- "W-SL"
geo[grep("WILD_Iraq_NL", PCAinfo$spp_loc)] <- "W-NL"
PCAinfo2<-as_tibble(data.frame(pca, spp,loc, spp_loc, geo))

#7. Re-plot 
pcaplot2<- ggplot(PCAinfo2, aes(PC1, PC2, col = geo, shape = spp)) + geom_point(size = 2) + coord_equal() + theme_light() + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)")) + scale_colour_manual(values=cbbPalette) + coord_cartesian(xlim = c(-0.4, 0.4), ylim = c(-0.4, 0.4)) + ggtitle("GROUPS") + theme(plot.title = element_text(hjust = 0.5))
pcaplot2

#8. Better look into the samples distribution
pcaplot3<- ggplot(PCAinfo2, aes(PC1, PC3, col = geo, shape = spp)) + geom_point(size = 2) + coord_equal() + theme_light() + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC3 (", signif(pve$pve[2], 3), "%)")) + scale_colour_manual(values=cbbPalette) + coord_cartesian(xlim = c(-0.4, 0.4), ylim = c(-0.4, 0.4)) + ggtitle("GROUPS") + theme(plot.title = element_text(hjust = 0.5))
pcaplot2

pcaplot4<- ggplot(PCAinfo2, aes(PC1, PC4, col = geo, shape = spp)) + geom_point(size = 2) + coord_equal() + theme_light() + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC4 (", signif(pve$pve[2], 3), "%)")) + scale_colour_manual(values=cbbPalette) + coord_cartesian(xlim = c(-0.4, 0.4), ylim = c(-0.4, 0.4)) + ggtitle("GROUPS") + theme(plot.title = element_text(hjust = 0.5))
pcaplot2


