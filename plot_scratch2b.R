# plot_scratch2b.R

# Create a scatterplot of traps on top of polygons representing Mike Woolf 
# West and East, and determine which traps are taken out by I-5

library(tidyverse)
library(readxl)

# Get trap points
traps <- read_excel("./Y21-06-30-plot-setup/trap_labels_y21_mwoolf.xlsx")
traps
# A tibble: 113 x 6
#   type   trap   row  tree   xft   yft
#   <chr> <dbl> <dbl> <dbl> <dbl> <dbl>
# 1 ppo       1    17    20   323   320
# 2 ppo       2    17    60   323   960

ggplot(traps, aes(x = xft, y = yft, shape = type, color = type)) +
  geom_point()
  # This works for a square 640 acre shape

# Get shapes
parts <- read_excel("./Y21-06-30-plot-setup/polygons.xlsx")
parts
# A tibble: 8 x 3
# Part    Xft   Yft
#   <chr> <dbl> <dbl>
# 1 West      0     0
# 2 West   4055     0
# 3 West    270  5250
# 4 West      0  5250
# 5 East   4425     0
# 6 East   5250     0
# 7 East   5250  5250
# 8 East    520  5250

