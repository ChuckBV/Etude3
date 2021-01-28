#-- Program: central-limits-thereom.r --------------------------------------#

# Uses data and discussion of the central limt thereom in chapters 6 and 7 
# of:
# Sokal RR and Rohlf FJ. 1995. Biometry: the principles and practice of 
#   statistics in biological research. 3rd ed. Freeman and Co., New York
# The data is Table 6.1 in the book and present fly wing lengths in mm and
# milk yields in units of 100 pounds. The fly wing data have a very 
# bell curve like form, and the milk data not so much. The Central Limit
# thereom states that: "as sample size increases, the means of samples 
# drawn from a population of any distribution will approach the normal
# distribution". In chapter 7, the authors bootstrap with samples of
# 5 and 35 observations to demonstrate this point.

library(tidyverse)
#-- Get data as a vector from the internet ----------------------------------

# https://people.sc.fsu.edu/~jburkardt/datasets/sokal_rohlf/sokal_rohlf03.txt
# sokal_rohlf03.txt

#-- Convert the data to a data frame ----------------------------------------
x <- scan(text = "1 36 51 2 37 51 3 38 51 4 38 53 5 39 53 6 39 53 7 40 54 8 40 55 9 40 55 10 40 56 11 41 56 12 41 56 13 41 57 14 41 57 15 41 57 16 41 57 17 42 57 18 42 57 19 42 57 20 42 57 21 42 58 22 42 58 23 42 58 24 43 58 25 43 58 26 43 58 27 43 58 28 43 58 29 43 58 30 43 58 31 43 58 32 44 59 33 44 59 34 44 59 35 44 60 36 44 60 37 44 60 38 44 60 39 44 60 40 44 61 41 45 61 42 45 61 43 45 61 44 45 61 45 45 61 46 45 62 47 45 62 48 45 62 49 45 62 50 45 63 51 46 63 52 46 63 53 46 64 54 46 65 55 46 65 56 46 65 57 46 65 58 46 65 59 46 67 60 46 67 61 47 67 62 47 67 63 47 68 64 47 68 65 47 69 66 47 69 67 47 69 68 47 69 69 47 69 70 48 69 71 48 70 72 48 72 73 48 73 74 48 73 75 48 74 76 48 74 77 48 74 78 49 74 79 49 75 80 49 76 81 49 76 82 49 76 83 49 79 84 49 80 85 50 80 86 50 81 87 50 82 88 50 82 89 50 82 90 50 82 91 51 83 92 51 85 93 51 87 94 51 88 95 52 88 96 52 89 97 53 93 98 53 94 99 54 96 100 55 98")

x2 <- matrix(x, nrow = 100, ncol = 3, byrow = TRUE)
x2

x3 <- as.data.frame(x2)

x3 <- x3[ ,2:3]
colnames(x3) <- c("mm","cwt")

### Fly data as mm and number of observations
xmm <- x3 %>% 
  group_by(mm) %>% 
  summarise(Count = n())

### Milk data as mm and number of observations
milk <- x3 %>% 
  group_by(cwt) %>% 
  summarise(Count = n())
milk

### Present fly and milk data sets as a vertical bar chart
ggplot(xmm, aes(x = mm, y = Count)) +
  geom_col()

ggplot(milk, aes(x = cwt, y = Count)) +
  geom_col()
