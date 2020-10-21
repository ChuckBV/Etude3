################################# 
### fehb2021.R
### Examine health plans from a table copied from the OPM web site and
### pasted into Excel
### https://www.opm.gov/healthcare-insurance/healthcare/plan-information/plans/premiums/2021/hmo/non-postal

library(dplyr)
library(readxl)
library(stringr)

vars <- read_excel("fehb2021.xlsx",
           sheet = 2)
vars
# A tibble: 12 x 2
#    var_name                var_description                                         
#    <chr>                   <chr>                                                   
#  1 plan_opt                Plan - Option                                           
#  2 code                    Enrollment Code                                         
#  3 prem20_total            2020 Total Biweekly Premium                             
#  4 prem21_total            2021 Biweekly Premium Rates - Total Premium             
#  5 prem21_gov              2021 Biweekly Premium Rates - Government Pays           
#  6 prem21_empl             2021 Biweekly Premium Rates - Employee Pays             
#  7 prem21_increase         2021 Biweekly Premium Rates - Change in Employee Payment
#  8 prem20_monthly_total    2020 Total Monthly Premium                              
#  9 prem21_monthly_total    2021 Monthly Premium Rates - Total Premium              
# 10 prem21_monthly_gov      2021 Monthly Premium Rates - Government Pays            
# 11 prem21_monthly_empl     2021 Monthly Premium Rates - Employee Pays              
# 12 prem21_monthly_increase 2021 Monthly Premium Rates - Change in Employee Payment 

plans <- read_excel("fehb2021.xlsx",
          sheet = 1,
          range = "A2:L2077",
          col_names = vars$var_name)

write.csv(plans,"febh_hmo_2021.csv", row.names = FALSE)

cal_plans <- plans %>% 
  filter(str_detect(plan_opt,"California") & str_detect(plan_opt,"Family"))
# 21 plans

cal_plans <- cal_plans %>% 
  filter(str_detect(plan_opt,"Kaiser"))

select(cal_plans,1:2)

my_plan <- cal_plans %>% 
  filter(code == "NZ5")

glimpse(my_plan)
