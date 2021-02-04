#===========================================================================#
# klein_nowddf_script1.R
#
# 1. x
#
#===========================================================================#

library(tidyverse) # dplyr used to select and modify common/imp variables
library(lubridate) # for work with date formats
library(janitor)# clean_names and compare_df_cols
library(Hmisc) # for describe()
library(data.table)

#-- 1. Upload NOW degree-day data for study period --------------------------

### Find and list csv files for windrow damage
my_path <- "./Y2021-01-15-klein-now-year-ratings/"
(csv_files <-  list.files(my_path, pattern = ".csv")) # 34 files
(cimis_files <- csv_files[str_detect(csv_files,"ddf")]) # 11 files
# [1] "ddf_2016.csv" "ddf_2017.csv" "ddf_2018.csv" "ddf_2019.csv" "ddf_2020.csv"

(cimis_names <- str_remove(cimis_files, ".csv"))

### Get relevant cimis files into a list of data frames
cimis_files %>%
  purrr::map(function(cimis_files){ # iterate through each file name
    assign(x = str_remove(cimis_files, ".csv"), # Remove file extension ".csv"
           value = read_csv(paste0(my_path, cimis_files)),
           envir = .GlobalEnv)
  }) -> df_list_read # Assign to a list

ddf_2016 <- clean_names(ddf_2016)
ddf_2016

ddnames <- colnames(ddf_2016)
# get good column names w janitor::clean_names() and store in vector

### Impose column names on df for each year
colnames(ddf_2017) <- ddnames
colnames(ddf_2018) <- ddnames
colnames(ddf_2019) <- ddnames
colnames(ddf_2020) <- ddnames

ddf_2016$x <- as.character(ddf_2016$x)
ddf_2017$x <- as.character(ddf_2017$x)
ddf_2018$x <- as.character(ddf_2018$x)
ddf_2019$x <- as.character(ddf_2019$x)
ddf_2020$x <- as.character(ddf_2020$x)

ddf_2016$x1 <- as.character(ddf_2016$x1)
ddf_2017$x1 <- as.character(ddf_2017$x1)
ddf_2018$x1 <- as.character(ddf_2018$x1)
ddf_2019$x1 <- as.character(ddf_2019$x1)
ddf_2020$x1 <- as.character(ddf_2020$x1)

### Consolidate into 1 df
ddf_tranq_5yr <- bind_rows(list(ddf_2016,ddf_2017,ddf_2018,ddf_2019,ddf_2020))
ddf_tranq_5yr
# A tibble: 1,827 x 8
#   station    date       air_min air_max degree_days accumulated_dd x     x1   
#   <chr>      <chr>        <dbl>   <dbl>       <dbl>          <dbl> <chr> <chr>
# 1 TRNQULTY.A 01/01/2016      28      52        0              0    NA    NA   
# 2 TRNQULTY.A 01/02/2016      38      52        0              0    NA    NA   
# 3 TRNQULTY.A 01/03/2016      38      57        0.28           0.28 NA    NA  

ddf_tranq_5yr$date <- as.Date(mdy(ddf_tranq_5yr$date))
ddf_tranq_5yr$yr <- year(ddf_tranq_5yr$date)
ddf_tranq_5yr$julian <- yday(ddf_tranq_5yr$date)

write.csv(ddf_tranq_5yrr,
          "./Y2021-01-15-klein-now-year-ratings/now_deg_days_f_tranquility_2016_to_2020.csv",
          row.names = FALSE)

ddf_tranq_5yr <- ddf_tranq_5yr %>% 
  mutate(now_dmg = ifelse(yr < 2018,"heavy","light"))

fday <- as.Date(c("2020-04-01","2020-05-01","2020-06-01","2020-07-01","2020-08-01","2020-09-01","2020-10-01"))
Date <- c("1-Apr","1-May","1-Jun","1-Jul","1-Aug","1-Sep","1-Oct")
Yday <- yday(fday)
fday
Yday

date_jul <- data.frame(Date,Yday)
date_jul

  
###
p1 <- ggplot() +
  geom_line(data = ddf_tranq_5yr, aes(x = julian, y = accumulated_dd, group = factor(yr), colour = now_dmg))  

p1 <- p1 + geom_text(data = date_jul, aes(x = Yday, y = 0, label = Date))

p1

ggsave("now_ddf_tranq_y16_to_y20.jpg",
       plot = p1,
       device = "jpeg",
       width =  5.83,
       height = 3.5,
       units = "in",
       dpi = 300)
