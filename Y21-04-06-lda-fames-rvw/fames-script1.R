#===========================================================================#
# fames-script1.R
#
#
#===========================================================================#

library(tidyverse)
library(MASS)

#-- 1. Find/upload/select relevant data sets ----------------------------------

## List of ChuckBV Github repos on his particular computer
repos <- list.files("../")
repos[6]
# [1] "Y18_walnut_famesR"
repos[7]
# [1] "Y19_fig_fatty_acids"
repos[9]
# [1] "Y19_walnut_fatty_acids"

stds_all_now <- read.csv("Y21-04-06-lda-fames-rvw/stds_all_now.csv")

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

head(stds_all_now,2) # 165 obs 
#        Host    C1     C2    C3    C4     C5     C6    C7    C8    C9   C10
# 1    Almond 0.162 14.192 0.472 5.985 48.372 29.147 1.672 0.000 0.000 0.000
# 2    Almond 0.245 23.799 1.092 4.577 43.573 22.443 4.163 0.115 0.000 0.000

## All of these are 10-compound preparations. Last seems most suitable for
## current purposes. Further characerize this data set
stds_all_now %>% 
  group_by(Host) %>% 
  summarise(nObs = n())
# 1 Almond       45
# 2 Fig          50
# 3 Pistachio    25
# 4 Walnut       45

#-- 2. Implement three-category separation as in 2014 r-blogger post --------

# https://www.r-bloggers.com/2014/01/computing-and-visualizing-lda-in-r/

## Examine only Almond, Pistachio, and Walnut
stds_all_now <- stds_all_now[stds_all_now$Host != "Fig",] # drops to 115 obs

threeway <-  lda(formula = Host ~ .,
                 data = stds_all_now)
                 #prior =  the default proportional to obs)
threeway$call
# lda(formula = Host ~ ., data = stds_all_now)
  # default is CV = FALSE

## Confirm prior proportions
threeway$prior
#   Almond Pistachio    Walnut 
# 0.3913043 0.2173913 0.3913043 
  # show that it is indeed proportions
25/sum(45,25,45)
# [1] 0.2173913

### svd, singular values, see ?lda()
threeway$svd
# [1] 50.07964 15.62323


prop = threeway$svd^2/sum(threeway$svd^2)
prop
# [1] 0.91130801 0.08869199
  # Less of between-class var explained than in iris data set example in 
  # r-bloggers (91% vs. 99%)

threeway <-  lda(formula = Host ~ .,
                 data = stds_all_now,
                 CV = TRUE)
threeway$call
# lda(formula = Host ~ ., data = stds_all_now, CV = TRUE)

probs <- data.frame(class = threeway$class, post = threeway$posterior)
head(probs)
#       class  post.Almond post.Pistachio  post.Walnut
# 1    Almond 1.000000e+00   5.322701e-15 5.650204e-56
# 2    Almond 1.000000e+00   2.618597e-09 2.049469e-39
# 3    Almond 9.999791e-01   2.085094e-05 7.214029e-43
# 4    Almond 1.000000e+00   3.268814e-19 3.197427e-64
# 5    Almond 9.999998e-01   2.014784e-07 1.729551e-39
# 6 Pistachio 3.178750e-10   1.000000e+00 4.060929e-32

## 