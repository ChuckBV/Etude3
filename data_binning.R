################################# 
### data_binning.R
### Data Binning and Plotting in R
### https://www.jdatalab.com/data_science_and_data_mining/2017/01/30/data-binning-plot.html

library(tidyverse)

data <- read_delim(file = "zipIncome.csv", delim = ',')
v <- data %>% select(MeanEducation,MeanHouseholdIncome) #pick the variable 
v

summary(v)

ggplot(data = v, mapping = aes(x = MeanEducation)) +
  geom_histogram(aes(y = ..density..), fill = "bisque", color = "white", alpha = 0.7) +
  geom_density() +
  geom_rug() + 
  labs(x = 'mean education per house') +
  theme_minimal()
  #theme_bw()

# set up cut-off values 
breaks <- c(0,2,4,6,8,10,12,14,16,18,20)

# specify interval/bin labels
tags <- c("[0-2)","[2-4)", "[4-6)", "[6-8)", "[8-10)", "[10-12)","[12-14)", "[14-16)","[16-18)", "[18-20)")

# bucketing values into bins
group_tags <- cut(v$MeanEducation, 
                  breaks=breaks, 
                  include.lowest=TRUE, 
                  right=FALSE, 
                  labels=tags)
# inspect bins
summary(group_tags)

# make unordered factor into ordered factor
education_groups <- factor(group_tags, 
                           levels = labels,
                           ordered = TRUE)

ggplot(data = as_tibble(group_tags), mapping = aes(x=value)) + 
  geom_bar(fill="bisque",color="white",alpha=0.7) + 
  stat_count(geom="text", aes(label=sprintf("%.4f",..count../length(group_tags))), vjust=-0.5) +
  labs(x='mean education per house') +
  theme_minimal() 

## Second plot of income by education
v <- data %>% select(MeanEducation,MeanHouseholdIncome) #pick the variable 
vgroup <- as_tibble(v) %>% 
  mutate(tag = case_when(
    MeanEducation < 2 ~ tags[1],
    MeanEducation >= 2 & MeanEducation < 4 ~ tags[2],
    MeanEducation >= 4 & MeanEducation < 6 ~ tags[3],
    MeanEducation >= 6 & MeanEducation < 8 ~ tags[4],
    MeanEducation >= 8 & MeanEducation < 10 ~ tags[5],
    MeanEducation >= 10 & MeanEducation < 12 ~ tags[6],
    MeanEducation >= 12 & MeanEducation < 14 ~ tags[7],
    MeanEducation >= 14 & MeanEducation < 16 ~ tags[8],
    MeanEducation >= 16 & MeanEducation < 18 ~ tags[9],
    MeanEducation >= 18 & MeanEducation < 20 ~ tags[10]
  ))
summary(vgroup)

vgroup$tag <- factor(vgroup$tag,
                     levels = tags,
                     ordered = FALSE)
summary(vgroup$tag)

ggplot(data = vgroup, mapping = aes(x=tag,y=log10(MeanHouseholdIncome))) + 
  geom_jitter(aes(color='blue'),alpha=0.2) +
  geom_boxplot(fill="bisque",color="black",alpha=0.3) + 
  labs(x='mean education per house') +
  guides(color=FALSE) +
  theme_minimal() 
