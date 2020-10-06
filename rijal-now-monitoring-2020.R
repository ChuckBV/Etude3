# rijal-now-monitoring-2020.R

library(tidyverse)
library(readxl)
library(lubridate)

### Recreate metadata for each of the three sites
MdTrt <- c("meso","gs")
lure <- c("NOWL2L","NOWeggs","TrecePpoL2","TrecePpo","AlphaL2","Alpha","Peterson")

Rep <- rep(1:4,length(MdTrt)*length(lure)) # Total number of reps
MdTrt <- rep(MdTrt, each = length(Rep)/length(MdTrt)) # Reps per MD treatment
lure = rep(lure, each = 4) # Half the obs
lure = c(lure,lure) # All obs

persite <- data.frame(MdTrt,lure,Rep)

### Obtain data for sites
Sites <- c("Hwy132","Toomes","Miller")

Dates <- read_csv("rijal-dates.csv")
head(Dates,3)
# A tibble: 3 x 4
# StdyWk Hwy132     Toomes     Miller    
#    <dbl> <date>     <date>     <date>    
# 1      1 2020-04-22 2020-04-25 2020-04-23
# 2      2 2020-04-30 2020-05-02 2020-04-28
# 3      3 2020-05-08 2020-05-09 2020-05-08

### create vector of column labels for wide format
prefix <- "StdyWk"
subscript <- 1:22
wks <- paste0(prefix,subscript)

### count data--extract from Excel spreadsheet
# counts_site1 <- read_excel(path = "C:/Users/Charles.Burks/OneDrive - USDA/_Current_projects/Analysis_Trap counts9.20.20.xlsx",
#                            sheet = Sites[1],
#                            range = "D2:Y57",
#                            col_names = wks)
# counts_site1
# write.csv(counts_site1,"counts_site1.csv", row.names = FALSE)
# 
# counts_site2 <- read_excel(path = "C:/Users/Charles.Burks/OneDrive - USDA/_Current_projects/Analysis_Trap counts9.20.20.xlsx",
#                            sheet = Sites[2],
#                            range = "D2:Y57",
#                            col_names = wks)
# counts_site2
# write.csv(counts_site2,"counts_site2.csv", row.names = FALSE)
# 
# counts_site3 <- read_excel(path = "C:/Users/Charles.Burks/OneDrive - USDA/_Current_projects/Analysis_Trap counts9.20.20.xlsx",
#                            sheet = Sites[3],
#                            range = "D2:Y57",
#                            col_names = wks)
# counts_site3
# write.csv(counts_site3,"counts_site3.csv", row.names = FALSE)

### count data--put back together
# counts1
counts1 <- read_csv("counts_site1.csv")
glimpse(counts1)
counts1$StdyWk1 <- as.numeric(counts1$StdyWk1)

meta <- data.frame(MdTrt,lure,Rep)
meta1 <- meta %>% 
  mutate(Site = Sites[1]) %>% 
  select(c(4,1:3))
meta1

Site1 <- cbind(meta1,counts1)

# counts2
counts2 <- read_csv("counts_site2.csv")
glimpse(counts2)
counts2$StdyWk1 <- as.numeric(counts2$StdyWk1)

#meta already created when importing site1
meta2 <- meta %>% 
  mutate(Site = Sites[2]) %>% 
  select(c(4,1:3))
meta2

Site2 <- cbind(meta2,counts2)

# counts3
counts3 <- read_csv("counts_site3.csv")
glimpse(counts3)
#counts3$StdyWk1 <- as.numeric(counts3$StdyWk1)

#meta already created when importing site1
meta3 <- meta %>% 
  mutate(Site = Sites[3]) %>% 
  select(c(4,1:3))
meta3

Site3 <- cbind(meta3,counts3)

### Fix so that correct week is missing in Site 3
Site3$StdyWk22 <- Site3$StdyWk22
Site3$StdyWk22 <- Site3$StdyWk21
Site3$StdyWk21 <- Site3$StdyWk20
Site3$StdyWk20 <- Site3$StdyWk19
Site3$StdyWk19 <- NA

