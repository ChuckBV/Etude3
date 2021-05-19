---
title: "My Hello World"
author: "Jenny  Bryant"
date: "5/18/2021"
output: 
  html_document:
    keep_md: true
---



Trying on my own. Working with the iris data set and tidyverse. Start with loading tidyverse and examining the structure of the iris data set.


```r
library(tidyverse)
str(iris)
```

```
## 'data.frame':	150 obs. of  5 variables:
##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

Now head the iris data set.


```r
head(iris,2)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
```

Now use dplyr to get summary information


```r
iris %>% 
  group_by(Species) %>% 
  summarise(nObs = n(),
            Sepal.Length = mean(Sepal.Length, na.rm = TRUE),
            Sepal.Width = mean(Sepal.Width, na.rm = TRUE))
```

```
## # A tibble: 3 x 4
##   Species     nObs Sepal.Length Sepal.Width
##   <fct>      <int>        <dbl>       <dbl>
## 1 setosa        50         5.01        3.43
## 2 versicolor    50         5.94        2.77
## 3 virginica     50         6.59        2.97
```
