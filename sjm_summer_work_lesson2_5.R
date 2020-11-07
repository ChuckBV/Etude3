# sjm_summer_work_lesson2_5.R

## Lesson 2.5

library(tidyverse)
library(car)

### Problem 1
#-- Use two vectors to make a data frame
x <- c(0,300,500,1000,2000)
y <- c(22,20,13,7,6)
probdf1 <- data.frame(x,y)

#-- Use ggplot2 to plot y vs. x
ggplot(probdf1, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ylim(0,30) +
  xlim(0,3000) +
  theme_bw()

#-- Use base stats to perform linear regression
m1 = lm(y ~ x, data = probdf1)

summary(m1)
# Call:
#   lm(formula = y ~ x, data = probdf1)
# 
# Residuals:
#     1      2      3      4      5 
# 2.145  2.614 -2.740 -4.625  2.605 
#
# Coefficients:
#                Estimate Std. Error t value Pr(>|t|)   
#   (Intercept) 19.854812   2.615528   7.591  0.00474 **
#   x           -0.008230   0.002531  -3.252  0.04742 * 
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 3.963 on 3 degrees of freedom
# Multiple R-squared:  0.779,	Adjusted R-squared:  0.7053 
# F-statistic: 10.57 on 1 and 3 DF,  p-value: 0.04742

#-- Get an ANOVA table from the Anova() function in the CAR package
Anova(m1, type = "II")
# Anova Table (Type II tests)
# 
# Response: y
# Sum Sq Df F value  Pr(>F)  
#x         166.082  1  10.574 0.04742 *
#  Residuals  47.118  3                  
# ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
         
length(domain)
length(rnge)
q()
nn