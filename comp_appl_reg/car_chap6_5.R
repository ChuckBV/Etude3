#--------------------------------------------------------------------------#
# car_chap6.R
#
# Do exercises for count data
#
#--------------------------------------------------------------------------#
library(car)
library(MASS)
library(carData)

#-- 1. Load and examine Ornstein data set from carData ----------------------
?Ornstein
brief(Ornstein) # p 296, section 6.5
# 248 x 4 data.frame (243 rows omitted)
# assets sector nation interlocks
# [i]    [f]    [f]        [i]
# 1   147670    BNK    CAN         87
# 2   133000    BNK    CAN        107
# 3   113230    BNK    CAN         94
# . . .                                   
# 247    119    AGR    CAN          6
# 248     62    MIN    US           0

  # Output Ornstein to examine in SAS
write.csv(Ornstein,"C:/Users/Charles.Burks/Desktop/ornstein.csv", row.names = FALSE)
  # Obtain frequency distribution
(tab <- xtabs(~ interlocks, data = Ornstein)) # see book

#-- 2. Create Poisson glm for Ornstein data ----------------------
  # Create a glm model for these data
mod.ornstein <- glm(interlocks ~ log2(assets) + nation + sector,
                    family = poisson, data = Ornstein)
  # glm is from base stats
  # log2 is log base 2. S is a car package modification of summary()
S(mod.ornstein)

