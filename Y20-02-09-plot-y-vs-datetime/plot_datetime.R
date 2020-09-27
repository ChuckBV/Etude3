# Plot datetime data

# See https://stackoverflow.com/questions/11748384/formatting-dates-on-x-axis-in-ggplot2

library(tidyverse)
library(lubridate)
library(scales)

df <- structure(list(Month = structure(1:12, .Label = c("2011-07-31", "2011-08-31", "2011-09-30", "2011-10-31", "2011-11-30", "2011-12-31", "2012-01-31", "2012-02-29", "2012-03-31", "2012-04-30", "2012-05-31", "2012-06-30"), class = "factor"), AvgVisits = c(6.98655104580674,7.66045407330464, 7.69761337479304, 7.54387561322994, 7.24483848458728, 6.32001400498928, 6.66794871794872, 7.207780853854, 7.60281201431308, 6.70113837397123, 6.57634103019538, 6.75321935568936)), .Names = c("Month","AvgVisits"), row.names = c(NA, -12L), class = "data.frame")

df

df$Month <- as.Date(df$Month)
ggplot(df, aes(x = Month, y = AvgVisits)) + 
  geom_bar(stat = "identity") +
  theme_bw() +
  labs(x = "Month", y = "Average Visits per User") +
  scale_x_date(labels = date_format("%m-%Y"))

#templog <- read_csv("C:\\Users\\Charles.Burks\\Desktop\\chuck_larvae_tmptr_log_2020_01_30.csv")
templog <- read_csv("./Y20-02-09-plot-y-vs-datetime/chuck_larvae_tmptr_log_2020_01_30.csv")

templog$Reading2 <- mdy_hms(templog$Reading)

ggplot(templog, aes(x = Reading2, y = Values)) + 
  geom_line(stat = "identity") +
  theme_bw() +
  labs(x = "Date/time", y = "degrees Fahrenheit") +
  scale_x_datetime()




date.hour=strptime("2011-03-27 01:30:00", "%Y-%m-%d %H:%M:%S")

date=c("26/10/2016")

time=c("19:51:30")

day<-paste(date,"T", time)

day.time1=as.POSIXct(day,format="%d/%m/%Y T %H:%M:%S",tz="Europe/Paris")

day.time1

day.time1$year
# Error in day.time1$year : $ operator is invalid for atomic vectors

day.time2=as.POSIXlt(day,format="%d/%m/%Y T %H:%M:%S",tz="Europe/Paris")

day.time2
# [1] "2016-10-26 19:51:30 CEST"

day.time2$year
# [1] 116