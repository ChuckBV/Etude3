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
ddf_cimis105_2019

### Upload 2020 data
ddf_cimis105_2020 <- read_csv("Y21-01-28-compare-recent-now-degree-days/now-deg-days-fahrenheit-2020-cimis105.csv")
ddf_cimis105_2020 <- clean_names(ddf_cimis105_2020)
ddf_cimis105_2020

### Combine data sets
compare_df_cols(list(ddf_cimis105_2019,ddf_cimis105_2020), return = "mismatch")
  # Should work

#ddf <- bind_rows(ddf_cimis105_2019,ddf_cimis105_2020)
  # does not work--too many columns

ddf <- rbind(ddf_cimis105_2019,ddf_cimis105_2020)
  # that works  

ddf$date <- as.Date(mdy(ddf$date))
ddf

kdays19 <- as.Date(c("2019-06-15","2019-07-04","2019-08-01","2019-09-01","2019-10-01"))
kdays20 <- as.Date(c("2020-06-15","2020-07-04","2020-08-01","2020-09-01","2020-10-01"))

kdays <- c(kdays19,kdays20)


ddf %>% 
  mutate(Year = year(date),
         Mnth = month(date, label = TRUE),
         Day = mday(date)) %>% 
  filter(date %in% kdays) %>% 
  select(Mnth,Day,Year,accumulated_dd) %>% 
  pivot_wider(names_from = Year,
                    names_prefix = "yr", 
                    values_from = accumulated_dd)
# A tibble: 5 x 4
# Mnth    Day yr2019 yr2020
# <ord> <int>  <dbl>  <dbl>
# 1 Jun      15  1272.  1261.
# 2 Jul       4  1694.  1677.
# 3 Aug       1  2410.  2369.
# 4 Sep       1  3198.  3122.
# 5 Oct       1  3764.  3717.

  # No big difference