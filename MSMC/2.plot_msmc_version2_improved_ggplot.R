#plot msmc results version 2 with ggplot 
mu <- 6.5e-9
gen <- 1

library(ggplot2)
library(tidyverse)
setwd("C:/Users/xitur/Desktop/MSMC/mergebed")
WSL <- 
WSL1<-read.table("psmc_WSL01.final.txt", header = TRUE)
WSL2<-read.table("psmc_WSL02.final.txt", header = TRUE)
WSL3<-read.table("psmc_WSL04.final.txt", header = TRUE)
WSL4<-read.table("psmc_WSL05.final.txt", header = TRUE)
WSL5<-read.table("psmc_WSL06.final.txt", header = TRUE)
WSL6<-read.table("psmc_WSL07.final.txt", header = TRUE)



a <- ggplot(WSL1, aes(x = left_time_boundary/mu*gen, y = (1/lambda)/(2*mu), colour = "WSL1")) + 
  geom_step() +
  ylim(900000,1550000)+ scale_x_log10(limits = c(15000,45000000), breaks=c(100000, 1000000, 10000000, 100000000), labels=c(10^5, 10^6, 10^7, 10^8)) + 
  theme_classic() +
  xlab("thousand years ago") + ylab("effective population size") +
  scale_color_manual(name='individual', breaks=c('WSL1', 'WSL2', 'WSL3', 'WSL4', 'WSL5','WSL6'), values=c('WSL1'='pink', 'WSL2' = 'blue', 'WSL3' = 'orange', 'WSL4' = 'red', 'WSL5' = 'green', 'WSL6' = 'gray'))+
  geom_step(data=WSL2, aes(x=left_time_boundary/mu*gen, y = (1/lambda)/(2*mu), colour = "WSL2"))+
  geom_step(data=WSL3, aes(x=left_time_boundary/mu*gen, y = (1/lambda)/(2*mu), colour = "WSL3"))+
  geom_step(data=WSL4, aes(x=left_time_boundary/mu*gen, y = (1/lambda)/(2*mu), colour = "WSL4"))+
  geom_step(data=WSL5, aes(x=left_time_boundary/mu*gen, y = (1/lambda)/(2*mu), colour = "WSL5"))+
  geom_step(data=WSL6, aes(x=left_time_boundary/mu*gen, y = (1/lambda)/(2*mu), colour = "WSL6"))
ggsave("msmc.png", a,width = 5,
       height = 3, dpi = 600)

WSL <- read.table("msmc_WSL.final.txt",header=TRUE)
b <- ggplot(WSL, aes(x = left_time_boundary/mu*gen, y = (1/lambda)/(2*mu), colour = "WSL")) + 
  geom_step() +
  ylim(0,360000)+ scale_x_log10(limits = c(15000,45000000), breaks=c(100000, 1000000, 10000000, 100000000), labels=c(10^5, 10^6, 10^7, 10^8)) + 
  theme_classic() +
  xlab("thousand years ago") + ylab("effective population size") +
  scale_color_manual(name='individual', breaks='WSL', values=c('WSL'='black'))

ggsave("msmcall.png", b,width = 5,
       height = 3,dpi = 600)


  
  
  







