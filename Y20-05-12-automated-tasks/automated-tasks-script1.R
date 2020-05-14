#===========================================================================#
# automated-tasks-script1.R
#
#
#
#===========================================================================#

# From https://theautomatic.net/2020/05/12/how-to-schedule-r-scripts/?utm_source=rss&utm_medium=rss&utm_campaign=how-to-schedule-r-scripts&subscribe=many_pending_subs#blog_subscription-3

### Get package
install.packages("taskscheduleR")
library(taskscheduleR)

### Create sample R script
nums <- sample(1000,100)
getwd()
# [1] "C:/Users/Charles.Burks/MyGit/Etude3"
write(nums,"sample_numbs.txt")
### appears in location above

# Next, in order to schedule the script to run automatically, we need to use 
# the taskscheduler_create function. This function takes several arguments, 
# which can be seen below.

taskscheduler_create(taskname = "test_run", rscript = "./create_file.R", 
                     schedule = "ONCE", starttime = format(Sys.time() + 50, "%H:%M"))


# > taskscheduler_create(taskname = "test_run", rscript = "./create_file.R", 
#                        +                      schedule = "ONCE", starttime = format(Sys.time() + 50, "%H:%M"))
# [1] "SUCCESS: The scheduled task \"test_run\" has successfully been created."
# > taskscheduler_create(taskname = "test_run", rscript = "./create_file.R", 
#                        +                      schedule = "ONCE", starttime = format(Sys.time() + 50, "%H:%M"))
# [1] "WARNING: The task name \"test_run\" already exists. Do you want to replace it (Y/N)? "
# attr(,"status")
# [1] 1
# Warning message:
#   In system(cmd, intern = TRUE) :
#   running command 'schtasks /Create /TN "test_run" /TR "cmd /c C:/R/R-40~1.0/bin/Rscript.exe \"./create_file.R\"  >> \"./create_file.log\" 2>&1" /SC ONCE /ST 11:18 ' had status 1
# > 

# Firstly, we need to give a name to the task we want to create. In this 
# case, we’ll just call our task “test_run”. Next, we need to specify the R 
# script we want to automatically run. Third, we add the schedule parameter, 
# which denotes how frequently we want to run this script. There are several 
# options here, including WEEKLY, DAILY, MONTHLY, HOURLY, and MINUTE. For 
# example, if we want our script to run every day, we would modify our 
# function call like this:
  
taskscheduler_create(taskname = "test_run", rscript = "/path/to/file/create_file.R", 
                     schedule = "DAILY", starttime = format(Sys.time() + 50, "%H:%M"))

# The other parameter we need to select is start time. In our examples, we’re 
# setting the task to start in 50 seconds from the current time.

# In addition to these arguments, taskscheduler_create also has a parameter 
# called “modifier”. This allows us to modify the schedule frequency. For 
# example, what if we want to run the task every 2 hours? In this case, we 
# would just set modifier = 2.

taskscheduler_create(taskname = "test_run", rscript = "/path/to/file/create_file.R", 
                     schedule = "HOURLY", starttime = format(Sys.time() + 50, "%H:%M"), modifier = 2)
