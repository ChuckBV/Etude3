# read_excel_sheets.R

library(tidyverse)
library(readxl)

### Preliminaries
getwd() # Verify current working directory
# [1] "C:/Users/c_s_b/mygit/Etude3"

# setwd not preferred but used because Etude3 is a essentially a 
# repository containing a lot of little repositories
setwd("./Y20-11-06-multiple-excel-tabs-to-df/")

list.files(pattern = ".xlsx")
# [1] "test.xlsx"

(test_sheets <- excel_sheets("test.xlsx"))

### Create three empty dataframes

# Try one to verify it works
A <- data.frame(Row = as.integer(rep(NA,3)),
                First = as.character(rep(NA,3)),
                Second = as.character(rep(NA,3)),
                Third = as.character(rep(NA,3))
                )
rm(A) # remove it

for (X in c(LETTERS[1:3])){
  print(X)
} # Works as expected

## See https://stackoverflow.com/questions/34832171/using-a-loop-to-create-multiple-data-frames-in-r
## Darn--need to learn lists
## See https://stackoverflow.com/questions/12945687/read-all-worksheets-in-an-excel-workbook-into-an-r-list-with-data-frames

getdfs<- function(sheets){
  
  listofdfs <- list() #Create a list in which you intend to save your df's.
  
  for(i in 1:length(sheets)){ #Loop through the numbers of ID's instead of the ID's
    print(sheets[i])
    sheet <- sheets[i]
    
    ##You are going to use games[i] instead of i to get the ID
    #url<- paste("http://stats.nba.com/stats/boxscoretraditionalv2?EndPeriod=10&
    #            EndRange=14400&GameID=",games[i],"&RangeType=2&Season=2015-16&SeasonType=
    #            Regular+Season&StartPeriod=1&StartRange=0000",sep = "")
    #json_data<- fromJSON(paste(readLines(url), collapse=""))
    #df<- data.frame(json_data$resultSets[1, "rowSet"])
    #names(df)<-unlist(json_data$resultSets[1,"headers"])
    #listofdfs[[i]] <- df # save your dataframes into the list
  }
  
  return(listofdfs) #Return the list of dataframes.
}

getdfs(test_sheets)

gameids<- as.character(c(0021500580:0021500593))
getstats(games = gameids)
