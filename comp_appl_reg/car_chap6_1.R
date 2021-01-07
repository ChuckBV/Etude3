#----------------------------------------------------------------------------
# car_chap6_1.R
#
#
#
#----------------------------------------------------------------------------

library(car)
library(carData)
library(effects)


### GLMs for binary data
### 6.34.1 Women's Labor Force Participation, 
summary(Mroz)
head(Mroz)
#   lfp k5 k618 age  wc hc       lwg    inc
# 1 yes  1    0  32  no no 1.2101647 10.910
# 2 yes  0    2  30  no no 0.3285041 19.500
# 3 yes  1    3  35  no no 1.5141279 12.040
# 4 yes  0    3  34  no no 0.0921151  6.800
# 5 yes  1    2  31 yes no 1.5242802 20.100
# 6 yes  0    0  54  no no 1.5564855  9.859

write.csv(Mroz,"./comp_appl_reg/mroz.csv", row.names = FALSE)

mroz.mod <- glm(lfp ~ k5 + k618 + age + wc + hc + lwg + inc,
                family = binomial, data = Mroz)

  # due to default, equivalent to 
# mroz.mod <- glm(lfp ~ k5 + k618 + age + wc + hc + lwg + inc,
#                 family = binomial, data = Mroz)

S(mroz.mod)

plot(predictorEffects(mroz.mod))

     