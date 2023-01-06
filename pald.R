#!/usr/bin/env Rscript
library(pald)
library(ramify)
library(stringr)

path=""

dall2=str_split(readLines(paste(path,"\\dall.csv",sep=""))," ")
dalls3=dall2[[1]]
nn=sqrt(length(dalls3))
dall=resize(lapply(unlist(dalls3),as.numeric),nn,nn)
dall

pdf(paste(path,"\\output.pdf",sep=""))
pald(as.dist(dall))
dev.off()





