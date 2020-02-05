# anova-demo.R

### Basic demonstration of ANOVA with CRD and RCBD

library(tidyverse)
library(DescTools)
library(emmeans)

# From: https://www.statmethods.net/stats/anova.html

# In the following examples lower case letters are numeric 
# variables and upper case letters are factors.

#-- 1. Fit a one-way anova (completely randomized design) -------------------

### Use example suggested by 
### http://www.sthda.com/english/wiki/one-way-anova-test-in-r

my_data <- as_tibble(PlantGrowth) # 30 obs
my_data
# A tibble: 30 x 2
# weight group
#     <dbl> <fct>
#  1   4.17 ctrl 
#  2   5.58 ctrl 
#  3   5.18 ctrl 
#  4   6.11 ctrl 
#  5   4.5  ctrl 
#  6   4.61 ctrl 
#  7   5.17 ctrl 
#  8   4.53 ctrl 
#  9   5.33 ctrl 
# 10   5.14 ctrl 
# ... with 20 more rows

### Quick first pass at data (non-parametric & box plots)
Desc(weight ~ group, data = my_data) 

### apply 1-way ANOVA
fit <- aov(weight ~ group, data = my_data)

### Get summary of results
summary(fit)
#             Df Sum Sq Mean Sq F value Pr(>F)  
# group        2  3.766  1.8832   4.846 0.0159 *
# Residuals   27 10.492  0.3886                 
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

### multiple comparisons
TukeyHSD(fit)
# Tukey multiple comparisons of means
# 95% family-wise confidence level
# 
# Fit: aov(formula = weight ~ group, data = my_data)
# 
# $group
#             diff        lwr       upr     p adj
# trt1-ctrl -0.371 -1.0622161 0.3202161 0.3908711
# trt2-ctrl  0.494 -0.1972161 1.1852161 0.1979960
# trt2-trt1  0.865  0.1737839 1.5562161 0.0120064

#-- 1. Fit a two-way anova (randomized complete block design) ---------------

# from: https://stat.ethz.ch/~meier/teaching/anova/block-designs.html#randomized-complete-block-designs

# coupon == experimental unit == blocking factor
tip    <- factor(rep(1:4, each = 4)) # Do different tips show different hardness?
coupon <- factor(rep(1:4, times = 4)) # Does the metal sample being tested contribute to variation?
y <- c(9.3, 9.4, 9.6, 10,
       9.4, 9.3, 9.8, 9.9,
       9.2, 9.4, 9.5, 9.7,
       9.7, 9.6, 10, 10.2)
hardness <- data.frame(y, tip, coupon)

Desc(y ~ tip, data = hardness)

fit <- aov(y ~ factor(coupon) + factor(tip), data = hardness) 
summary(fit) # factor necessary above for Tukey to work as intended
# Df Sum Sq Mean Sq F value   Pr(>F)    
# coupon       3  0.825 0.27500   30.94 4.52e-05 ***
# tip          3  0.385 0.12833   14.44 0.000871 ***
# Residuals    9  0.080 0.00889                     
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# See also https://www.r-bloggers.com/examples-using-r-randomized-block-design/
TukeyHSD(fit, which = 'factor(tip)', ordered = TRUE)
# 
# $`factor(tip)`
#      diff         lwr       upr     p adj
# 1-3 0.125 -0.08311992 0.3331199 0.3027563
# 2-3 0.150 -0.05811992 0.3581199 0.1815907
# 4-3 0.425  0.21688008 0.6331199 0.0006061
# 2-1 0.025 -0.18311992 0.2331199 0.9809005
# 4-1 0.300  0.09188008 0.5081199 0.0066583
# 4-2 0.275  0.06688008 0.4831199 0.0113284