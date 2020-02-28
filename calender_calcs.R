#-- calender_calcs.R -------------------------------------------------------#

makecal <- function(){
  # create vector of all days of 2019
  y19 <-seq(from = as.Date("2019-01-01"),
            to = as.Date("2019-12-31"),
            by = 1)
  # select only Mondays in 2019
  mon19 <- y19[lubridate::wday(y19) == 2]
  # obtain the epiweek for each monday
  epwk19 <- lubridate::epiweek(mon19)
  # create a data frame containing epiweek and the date Monday
  weeks19 <- data.frame(epwk19,mon19)
  return(weeks19)
}

epiweeks2019 <- makecal()
write.csv(epiweeks2019,"./data/epiweeks2019.csv", row.names = FALSE)
