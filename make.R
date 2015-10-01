#!/usr/bin/env Rscript
buildPlots <- function(userName, userMonth){
	#Build plots, pretty simple.
	source('plotmaker.R')
	plotmaker(user = userName, month = userMonth) 
}

userName=(commandArgs(TRUE)[1])
userMonth=(commandArgs(TRUE)[2])
#print(userName)
#print(userMonth)
buildPlots(userName, userMonth) #start
