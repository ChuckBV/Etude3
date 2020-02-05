# anova-demo-random-mixed.R

library(tidyverse)
library(DescTools)
library(lme4)

# https://stat.ethz.ch/~meier/teaching/anova/random-and-mixed-effects-models.html#random-effects-models

#-- 1. Completely Randomized model ---------------------------------------------

## Create data set ####
weight <- c(61, 100,  56, 113,  99, 103,  75,  62,  ## sire 1
            75, 102,  95, 103,  98, 115,  98,  94,  ## sire 2
            58,  60,  60,  57,  57,  59,  54, 100,  ## sire 3
            57,  56,  67,  59,  58, 121, 101, 101,  ## sire 4
            59,  46, 120, 115, 115,  93, 105,  75)  ## sire 5
sire    <- factor(rep(1:5, each = 8))
animals <- data.frame(weight, sire)
str(animals)

## Visualize data ##
stripchart(weight ~ sire, vertical = TRUE, pch = 1, xlab = "sire", data = animals)

### Note remarks about random intercept and random slope

fit.sire <- lmer(weight ~ (1 | sire), data = animals)
summary(fit.sire)
## Linear mixed model fit by REML ['lmerMod']
## Formula: weight ~ (1 | sire)
##    Data: animals
## 
## REML criterion at convergence: 358.2
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -1.9593 -0.7459 -0.1581  0.8143  1.9421 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  sire     (Intercept) 116.7    10.81   
##  Residual             463.8    21.54   
## Number of obs: 40, groups:  sire, 5
## 
## Fixed effects:
##             Estimate Std. Error t value
## (Intercept)   82.550      5.911   13.96

### See more examples of random effects models

#-- 2. Mixed model ANOVA ---------------------------------------------------

data("Machines", package = "nlme")
## technical detail for nicer output:
Machines[, "Worker"] <- factor(Machines[, "Worker"], levels = 1:6, ordered = FALSE)
str(Machines, give.attr = FALSE) ## give.attr in order to shorten output
## Classes 'nffGroupedData', 'nfGroupedData', 'groupedData' and 'data.frame':   54 obs. of  3 variables:
##  $ Worker : Factor w/ 6 levels "1","2","3","4",..: 1 1 1 2 2 2 3 3 3 4 ...
##  $ Machine: Factor w/ 3 levels "A","B","C": 1 1 1 1 1 1 1 1 1 1 ...
##  $ score  : num  52 52.8 53.1 51.8 52.8 53.1 60 60.2 58.4 51.1 ...

### Let us first visualize the data (R code for interested readers only).

ggplot(Machines, aes(x = Machine, y = score, group = Worker, col = Worker)) + 
  geom_point() + stat_summary(fun.y = mean, geom = "line")

## classical interaction plot would be 
with(Machines, interaction.plot(x.factor = Machine, trace.factor = Worker, 
                                response = score))
