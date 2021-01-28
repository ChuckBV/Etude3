#===========================================================================#
# script1-compare-now-ddf.R
#
#
#===========================================================================#

library(tidyverse)
library(lubridate)
library(janitor)

### Upload 2019 data
ddf_cimis105_2019 <- read_csv("Y21-01-28-compare-recent-now-degree-days/now-deg-days-fahrenheit-2019-cimis105.csv")
ddf_cimis105_2019 <- clean_names(ddf_cimis105_2019)

### Upload 2020 data
ddf_cimis105_2020 <- read_csv("Y21-01-28-compare-recent-now-degree-days/now-deg-days-fahrenheit-2020-cimis105.csv")
ddf_cimis105_2020 <- clean_names(ddf_cimis105_2020)
ddf_cimis105_2020

### Combine data sets
ddf <- bind_rows(ddf_cimis105_2019,ddf_cimis105_2020)

compare_df_cols(list(ddf_cimis105_2019,ddf_cimis105_2020))

ddf$date <- as.Date(mdy(ddf$date))
ddf
