#===========================================================================#
# fames-script1.R
#
#
#===========================================================================#

library(tidyverse)

#-- 1. Find and upload relevant data sets ----------------------------------

## List of ChuckBV Github repos on his particular computer
repos <- list.files("../")
repos[6]
# [1] "Y18_walnut_famesR"
repos[7]
# [1] "Y19_fig_fatty_acids"
repos[9]
# [1] "Y19_walnut_fatty_acids"

## Used gui copy and past to get fig data files to present repo subdir
datfiles <- list.files("./Y21-04-06-lda-fames-rvw/", pattern = "csv")
datfiles
# [1] "fame_stds_10cmpd.csv"    "fatty_acid_names.csv"    "field_fame_fig_2019.csv" "fig_stds.csv"           
# [5] "stds_all_now.csv"

datfiles <- paste0("./Y21-04-06-lda-fames-rvw/",datfiles)

## Get relevant files into Global Envirnment
fame_stds_10cmpd <- read.csv(datfiles[1])
fatty_acid_names <- read.csv(datfiles[2])
fig_stds <- read.csv(datfiles[4])
stds_all_now <- read.csv(datfiles[5])


## file description from README in "Y19_fig_fatty_acids"
#  - fame_stds_10cmpd.csv -- Profiles for all individuals from known sources, 
#    used 
#    as input for LDA classification
#  - field_fame_fig_2019.csv -- Profiles for individuals taken from traps in 
#    figs in 2019
#  - fatty_acid_names.csv -- names and formulae of fatty acids, useful for data 
#    display
#  - fig_stds.csv -- Subset of fame_stds_10cmpd.csv that is from either almond 
#    or fig
#  - stds_all_now.csv -- subset generalized by host of walnut, pistachio almond, 
#    or fig

head(fame_stds_10cmpd,2) # 207 obs
#   Rep       Id    Sex    C1     C2     C3    C4     C5     C6    C7    C8    C9   C10               GC.ENTRY
# 1   1 Lab_diet Female 0.434 31.894  7.538 6.981 32.493 13.709 6.151 0.244 0.000 0.556  1_10_17_NOW_DIET_F_S3
# 2   2 Lab_diet Female 0.518 29.657  8.900 6.518 32.595 14.770 6.277 0.210 0.000 0.555  1_11_17_NOW_DIET_F_S4


head(fatty_acid_names,2) # 10 obs
#   CmpdID cmpd_label   fa_name formula
# 1      1         C1 Myristate   C14:0
# 2      2         C2 Palmitate   C16:0

head(stds_all_now,2) # 165 obs 
#        Host    C1     C2    C3    C4     C5     C6    C7    C8    C9   C10
# 1    Almond 0.162 14.192 0.472 5.985 48.372 29.147 1.672 0.000 0.000 0.000
# 2    Almond 0.245 23.799 1.092 4.577 43.573 22.443 4.163 0.115 0.000 0.000

## All of these are 10-compound preparations. Last seems most suitable for
## current purposes.