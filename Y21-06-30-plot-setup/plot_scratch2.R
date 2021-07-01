# plot_scratch2.R

library(tidyverse)

## TRAP NUMBERS--DESCRIPTION

row_nmbr <- seq(from = 1100, to = 2100, by = 100) # ll rows
prefix <- rep("HR",11) # obtain prefix 
trap_codes <- data.frame(prefix,row_nmbr) # create proto-data frame
trap_codes

trap_nmbrs <- read_csv("./Y21-06-30-plot-setup/trap_nmbrs.csv")

trap_nmbrs$prefix <- "HR"
trap_nmbrs <- trap_nmbrs[,c(3,1,2)]

left_join(trap_codes,trap_nmbrs)
