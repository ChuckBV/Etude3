################################# 
### data_binning.R
### Data Binning and Plotting in R
### https://www.jdatalab.com/data_science_and_data_mining/2017/01/30/data-binning-plot.html

library(tidyverse)

data <- read_delim(file = "../data/zipIncome.csv", delim = ',')
v <- data %>% select(MeanEducation,MeanHouseholdIncome) #pick the variable 
