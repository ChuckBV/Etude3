# datetime_functions.R

library(timechange)

### References
# Handling date-times in R "http://biostat.mc.vanderbilt.edu/wiki/pub/Main/ColeBeck/datestimes.pdf" 
# Converting Time Zones in R "https://blog.revolutionanalytics.com/2009/06/converting-time-zones.html"
# strptime & strftime in R, examples "https://statisticsglobe.com/strptime-strftime-r-example"
# Package 'timechange' "https://cran.r-project.org/web/packages/timechange/timechange.pdf"
# Timezone conversion in R "https://www.r-bloggers.com/timezone-conversion-in-r/"


### Sample output from Farmsense, as read through readr:read_csv
fstimes <- c("2020-07-09 03:50:04 UTC","2020-07-10 13:12:10 UTC","2020-07-11 13:19:40 UTC","2020-07-12 09:11:49 UTC","2020-07-12 09:14:35 UTC","2020-07-12 13:23:13 UTC")

str(fstimes)
# chr [1:6] "2020-07-09 03:50:04 UTC" "2020-07-10 13:12:10 UTC" ...

### Convert from character to datetime
fstimes2 <- strptime(fstimes, format = "%Y-%m-%d %H:%M:%S")

class(fstimes2)
# [1] "POSIXlt" "POSIXt"

fstimes2
# [1] "2020-07-09 03:50:04 PDT" "2020-07-10 13:12:10 PDT" "2020-07-11 13:19:40 PDT"
# [4] "2020-07-12 09:11:49 PDT" "2020-07-12 09:14:35 PDT" "2020-07-12 13:23:13 PDT"

### Find relevant OlsonNames
x <- OlsonNames()
fnd_ths <- c("Angeles","Cape")

x[str_detect(x, "Angeles")]
# [1] "America/Los_Angeles"

x[str_detect(x, "Cape")]
# [1] "Atlantic/Cape_Verde"

#-- Apparently PDT is default based on my locale. Note that this is 
#-- different from OlsonNames() description of "America/Los_Angeles"
#-- That is not correct, these data were given in UCT

### Convert from character to datetime with correct timezone
fstimes2 <- strptime(fstimes, format = "%Y-%m-%d %H:%M:%S", tz = "utc")
fstimes

# [1] "2020-07-09 03:50:04 UTC" "2020-07-10 13:12:10 UTC" "2020-07-11 13:19:40 UTC"
# [4] "2020-07-12 09:11:49 UTC" "2020-07-12 09:14:35 UTC" "2020-07-12 13:23:13 UTC"

### Show farmsence trap data to California time
time_at_tz(fstimes2, tz = "America/Los_Angeles")
# [1] "2020-07-08 20:50:04 PDT" "2020-07-10 06:12:10 PDT" "2020-07-11 06:19:40 PDT"
# [4] "2020-07-12 02:11:49 PDT" "2020-07-12 02:14:35 PDT" "2020-07-12 06:23:13 PDT"

x <- time_at_tz(fstimes2, tz = "America/Los_Angeles")
x[1] # 
# [1] "2020-07-08 20:50:04 PDT"
fstimes2[1]
# [1] "2020-07-09 03:50:04 UTC" 
#-- Note that time_at_tz() converts

### Change farmsence trap data
x <- fstimes2
x[1]
# [1] "2020-07-09 03:50:04 UTC" 

time_force_tz(fstimes2, tz = "America/Los_Angeles") 
# [1] "2020-07-09 03:50:04 PDT" "2020-07-10 13:12:10 PDT" "2020-07-11 13:19:40 PDT"
# [4] "2020-07-12 09:11:49 PDT" "2020-07-12 09:14:35 PDT" "2020-07-12 13:23:13 PDT"
#-- Note that time_force_tz() does NOT convert--it changes the timezone 
#-- without changing the time

### Use minutes after 24:00 at "Atlantic/Cape_Verde" (UTC -1) to get 
### minutes after 18:00 at "America/Los_Angeles"

latimes <- c("2020-07-03 18:00:00","2020-07-03 21:00:00","2020-07-04 00:00:00","2020-07-04 03:00:00","2020-07-04 06:00:00")
latimes <- strptime(latimes, format = "%Y-%m-%d %H:%M:%S", tz = "America/Los_Angeles")
latimes
# [1] "2020-07-03 18:00:00 PDT" "2020-07-03 21:00:00 PDT" "2020-07-04 00:00:00 PDT"
# [4] "2020-07-04 03:00:00 PDT" "2020-07-04 06:00:00 PDT"

time_clock_at_tz(latimes, tz = "Atlantic/Cape_Verde", unit = "hours")
# [1]  0  3  6  9 12

### Bingo! Use to get minutes after 18:00
### Can also use y <- time_at_tz() to start the new day at sunset local time
