#-- Program: Y19-rif-on-spurgeon-2019a.R -----------------------------------#

# Creates a sample data set to examine the scenarios described by Dale 
# Spurgeon in American Entomol. 2019:16-18, "Common statistical mistakes in
# entomology: pseudoreplication

# https://www.math.csi.cuny.edu/Statistics/R/simpleR/stat007.html
# http://www.cookbook-r.com/Numbers/Generating_random_numbers/

library(dplyr)

### Create an indexed (tidy) data set corresponding to Fig. 1 of 
### Spurgeon 2019a as described in that article. The experimental
### arrangement is three categorical treatemnts (A,B,C) and 
### three replicate blocks (1,2,3) with 10 subsamples in each of
### the resultant 9 cells. Will generate a data set in which
### values are more similar between treatments a and b, and 
### more different for C. Conveniently, all three treatments
### will have the same standard deviation

block = rep(1:3, each = 30)
# Desired grid:
#   b,a,c
#   b,c,a
#   a,b,c
treatment = c(rep("b",10),rep("a",10),rep("c",10),
              rep("b",10),rep("c",10),rep("a",10),
              rep("a",10),rep("b",10),rep("c",10))

### Create a plot designation that describes arrangment in Fig 1
plot <- c(rep("x1",10),rep("y1",10),rep("z1",10),
          rep("x2",10),rep("y2",10),rep("z2",10),
          rep("x3",10),rep("y3",10),rep("z3",10))

# Central tendencies of faked data
#  Treatments: a, mean = 20
#              b, mean = 30
#              c, mean = 60
# Rep effects: 1, mean - 5
#              2, mean
#              3, mean + 5
# standard deviation = 8

# rnorm(n, mean = 0, sd = 1)
#  n = number of observations

b1 <- rnorm(10,25,8)
a1 <- rnorm(10,15,8)
c1 <- rnorm(10,55,8)
b2 <- rnorm(10,30,8)
c2 <- rnorm(10,60,8)
a2 <- rnorm(10,20,8)
a3 <- rnorm(10,25,8)
b3 <- rnorm(10,35,8)
c3 <- rnorm(10,65,8)

resp <- c(b1,a1,c1,b2,c2,a2,a3,b3,c3)

rcb1 <- data.frame(block,plot,treatment,resp)

### Verify data set
head(rcb1,3)
#   block plot treatment     resp
# 1     1   x1         b 34.20852
# 2     1   x1         b 20.21768
# 3     1   x1         b 17.95965

rcb1 %>% 
  group_by(block,plot,treatment) %>% 
  summarise(nObs = n())
# A tibble: 9 x 4
# Groups:   block, plot [9]
#   block plot  treatment  nObs
#   <int> <fct> <fct>     <int>
# 1     1 x1    b            10
# 2     1 y1    a            10
# 3     1 z1    c            10
# 4     2 x2    b            10
# 5     2 y2    c            10
# 6     2 z2    a            10
# 7     3 x3    a            10
# 8     3 y3    b            10
# 9     3 z3    c            10

### In R, both block and treatment should be factors. However, save as a
### csv, then access and specifivy appropriately in both R and SAS
write.csv(rcb1,"./Y19-10-02-spurgeon-data-simulation/data1.csv", row.names = FALSE)
