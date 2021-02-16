#===========================================================================#
# script1_traps_rptd_measures.R
#
# Uses data from "ms-now-ppo-kairomone-2017-2yr" to explore the effect of
# placing variables as fixed vs random factors in a mixed-model ANOVA
#
# NB: https://thestatsgeek.com/2020/12/30/mixed-model-repeated-measures-mmrm-in-stata-sas-and-r/
#
#===========================================================================#

library(tidyverse)
library(lubridate)

### Weekly means and Std Error plotted from repo above
getwd()
list.files("./Y21-02-15-trap-dates-repeated-measures/")
# [1] "y18-lures-wkly-alm-nomd.jpg" "y18_alm_nomd.csv"  


# View("./Y21-02-15-trap-dates-repeated-measures/y18-lures-wkly-alm-nomd.jpg")
    # This does not work

alm_nomd <- read_csv("./Y21-02-15-trap-dates-repeated-measures/y18_alm_nomd.csv")
alm_nomd
# A tibble: 240 x 11
#   TrtCode Treatment    Rep TrapID Site      Crop  MD    Count  Male EndDate    StartDate 
#   <chr>   <chr>      <dbl>  <dbl> <chr>     <chr> <chr> <dbl> <dbl> <date>     <date>    
# 1 A       NowBiolure     1    312 Kettleman Alm   No       88    88 2018-04-27 2018-04-10
# 2 A       NowBiolure     2    323 Kettleman Alm   No       94    94 2018-04-27 2018-04-10

unique(alm_nomd$TrtCode) #  5 levels 
# [1] "A" "B" "C" "D" "E"

unique(alm_nomd$Rep) #  8 levels
# [1] 1 2 3 4 5 6 7 8 

unique(alm_nomd$EndDate) # 6 levels
# [1] "2018-04-27" "2018-05-04" "2018-05-16" "2018-05-25" "2018-05-29" "2018-06-07"

alm_nomd %>% 
  filter(is.na(Count))
# A tibble: 2 x 11
#   TrtCode Treatment   Rep TrapID Site      Crop  MD    Count  Male EndDate    StartDate 
#   <chr>   <chr>     <dbl>  <dbl> <chr>     <chr> <chr> <dbl> <dbl> <date>     <date>    
# 1 D       StopNow       2    322 Kettleman Alm   No       NA    NA 2018-04-27 2018-04-10
# 2 D       StopNow       2    322 Kettleman Alm   No       NA    NA 2018-05-04 2018-04-27
   # 2 of 240 w NA in response. Both in Trt D, Rep 2

### Drop Rep 2, Trt D. Now not balanced, but no Rep w NA

alm_nomd2 <- alm_nomd %>% 
  filter(!(TrtCode == "D" & Rep == 2))

write.csv(alm_nomd2,"./Y21-02-15-trap-dates-repeated-measures/alm_nomd2.csv", row.names = FALSE)

alm_nomd3 <- alm_nomd2 %>% 
  group_by(TrtCode,Rep) %>% 
  summarise(nObs = sum(!is.na(Count)),
            Total = sum(Count))

write.csv(alm_nomd3,"./Y21-02-15-trap-dates-repeated-measures/alm_nomd3.csv", row.names = FALSE)

