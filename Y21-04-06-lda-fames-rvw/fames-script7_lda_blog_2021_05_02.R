#===========================================================================#
# fames-script7_lda_blog_2021_05_02.R
#
# https://finnstats.com/index.php/2021/05/02/linear-discriminant-analysis/
# (also on r-bloggers.com)
#
# Use Martins code with NOW Fames dataset. This time with NOW from lab
# tree nut sources, not from iris data set
#
# 1. Perform and annotate PCA
# 2. Perform and annotate LDA
# 3. Graphical comparisons of PCA and LDA
#
#===========================================================================#

library(klaR) 
library(psych)
library(MASS)
library(ggord) # https://github.com/fawda123/ggord
library(devtools)

data("iris")
str(iris)

### scatterplot for first four numerical variables
psych::pairs.panels(iris[1:4],
                    gap = 0,
                    bg = c("red","blue","green")[iris$Species],
                    pch = 21)

### Create training data set w 60% obs and test w remaining 40%
set.seed(123)
ind <- sample(2, nrow(iris),
              replace = TRUE,
              prob = c(0.6,0.4))
  # produces a vector of length nrow(iris) (= 50) of 60% 1 and 40% 2
training <- iris[ind == 1, ] # 89 obs
head(training)
#    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1           5.1         3.5          1.4         0.2  setosa
# 3           4.7         3.2          1.3         0.2  setosa
# 6           5.4         3.9          1.7         0.4  setosa
# 7           4.6         3.4          1.4         0.3  setosa
# 9           4.4         2.9          1.4         0.2  setosa
# 10          4.9         3.1          1.5         0.1  setosa

testing <- iris[ind == 2, ] #61 obs

### Generate model with training set
linear <- lda(Species ~ ., training)
linear
# Call:
#   lda(Species ~ ., data = training)
# 
# Prior probabilities of groups:
#    setosa versicolor  virginica 
# 0.3370787  0.3370787  0.3258427 
# 
# Group means:
#            Sepal.Length Sepal.Width Petal.Length Petal.Width
# setosa         4.946667    3.380000     1.443333    0.250000
# versicolor     5.943333    2.803333     4.240000    1.316667
# virginica      6.527586    2.920690     5.489655    2.048276
# 
# Coefficients of linear discriminants:
#                     LD1         LD2
# Sepal.Length  0.3629008  0.05215114
# Sepal.Width   2.2276982  1.47580354
# Petal.Length -1.7854533 -1.60918547
# Petal.Width  -3.9745504  4.10534268
# 
# Proportion of trace:
#    LD1    LD2 
# 0.9932 0.0068 

### Based on the training dataset, 38% belongs to setosa group, 31% belongs to 
### versicolor groups and 30% belongs to virginica groups.
### The first discriminant function is a linear combination of the four 
### variables. Percentage separations achieved by the first discriminant 
### function is 99.37% and second is 0.63%

attributes(linear)
# $names
# [1] "prior"   "counts"  "means"   "scaling" "lev"     "svd"     "N"       "call"    "terms"   "xlevels"
# 
# $class
# [1] "lda"

### Stacked histogram (the cool plot)
p <- predict(linear, training) # linear is the objects, training is the data set
attributes(p)
# $names
# [1] "class"     "posterior" "x"        

MASS::ldahist(data = p$x[,1], # first discriminant function
              g = training$Species) # factor or vector giving groups 
## See plots

