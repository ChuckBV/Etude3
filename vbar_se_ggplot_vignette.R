# vbar_se_ggplot_vignette.R

# From https://stackoverflow.com/questions/44872951/how-do-i-add-se-error-bars-to-my-barplot-in-ggplot2

library(ggplot2)

ggplot(diamonds, aes(cut, price, fill = color)) +
  stat_summary(geom = "bar", fun.y = mean, position = "dodge") +
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge")

## or

library(tidyverse)
pdata <- diamonds %>% 
  group_by(cut, color) %>% 
  summarise(new = list(mean_se(price))) %>% 
  unnest(new)


pdata %>% 
  ggplot(aes(cut, y = y, fill = color)) +
  geom_col(position = "dodge") +
  geom_errorbar(aes(ymin = ymin, ymax = ymax), position = "dodge")

