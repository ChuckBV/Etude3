# excel_purrr_vignette.R

# From https://www.r-bloggers.com/2019/06/vignette-write-read-multiple-excel-files-with-purrr/
# Posted on June 27, 2019 by Martin Chan in R bloggers

library(tidyverse)
library(readxl)
library(writexl)

#-- 1. Write a data set as an Excel file and as csv files -------------------

### Look at iris data set
iris %>% head(3)
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa

### Meet dprly::group_split()
# One data frame per species
list_of_dfs <- iris %>% 
  dplyr::group_split(Species) 

class(list_of_dfs)
# [1] "list"

list_of_dfs
# Gives first 10 for dfs for Species setosa, versicolor, and virginica (3 df)

list_of_dfs %>%
  purrr::map(~pull(.,Species)) %>% # Pull out Species variable
  purrr::map(~as.character(.)) %>% # Convert factor to character
  purrr::map(~unique(.)) -> names(list_of_dfs) # Set this as names for list members
names(list_of_dfs)

### Output as a single Excel file with three sheets
list_of_dfs %>%
  writexl::write_xlsx(path = "./Y20-11-14-read-write-excel-purrr/datasets/test-excel/test-excel.xlsx")

### Output again as three separate csv files
# Step 1
# Define a function for exporting csv with the desired file names and into the right path
output_csv <- function(data, names){ 
  folder_path <- "./Y20-11-14-read-write-excel-purrr/datasets/test-excel/"
  write_csv(data, paste0(folder_path, "test-excel-", names, ".csv"))
}

# Step 2
list(data = list_of_dfs,
     names = names(list_of_dfs)) %>% 
# Step 3
  purrr::pmap(output_csv)   

### Trust but verify
list.files("./Y20-11-14-read-write-excel-purrr/datasets/test-excel")
# [1] "test-excel-setosa.csv"     "test-excel-versicolor.csv" "test-excel-virginica.csv"  "test-excel.xlsx"       

#-- 2. Read multiple sheets into global environment -------------------

### NB See https://www.datamentor.io/r-programming/environment-scope/ for 
### more on local and Global environment if the distinction is unfamilair


### Read multiple sheets from the Excel doc into global environemnt

# Point to the Excel file created in the previous section
wb_source <- "./Y20-11-14-read-write-excel-purrr/datasets/test-excel/test-excel.xlsx"

# Assign sheets names to a character vector and output contents
(wb_sheets <- readxl::excel_sheets(wb_source)) 
# [1] "setosa"     "versicolor" "virginica"

# Load everything into the Global Environment
wb_sheets %>%
  purrr::map(function(sheet){ # iterate through each sheet name
    assign(x = sheet,
           value = readxl::read_xlsx(path = wb_source, sheet = sheet),
           envir = .GlobalEnv)
  })

### Note that map() always returns a list, but in this case we do not need a
### list returned and only require the “side effects”, i.e. the objects being
### read in to be assigned to the Global Environment. If you prefer you can
### use lapply() instead of map(), which for this purpose doesn’t make a big
### practical difference.

### Read multiple csv files from a directory into global environemnt

file_path <- "./Y20-11-14-read-write-excel-purrr/datasets/test-excel/"
list.files(file_path)
# [1] "test-excel-setosa.csv"     "test-excel-versicolor.csv" "test-excel-virginica.csv"  "test-excel.xlsx" 

# assign and print csv files
(file_path %>%
  list.files() %>%
  .[str_detect(., ".csv")] -> csv_file_names
)
# [1] "test-excel-setosa.csv"     "test-excel-versicolor.csv" "test-excel-virginica.csv" 

### Load everything into the Global Environment

### The next part is similar to what we’ve done earlier, using map(). Note
### that apart from replacing the value argument with read_csv() (or you can
### use fread() to return a data.table object rather than a tibble), I also
### removed the file extension in the x argument so that the variable names
### would not contain the actual characters “.csv”:
csv_file_names %>%
  purrr::map(function(file_name){ # iterate through each file name
    assign(x = str_remove(file_name, ".csv"), # Remove file extension ".csv"
           value = read_csv(paste0(file_path, file_name)),
           envir = .GlobalEnv)
  })

#-- 2. Read multiple sheets into a list -------------------

# Load everything into the Global Environment
wb_sheets
# [1] "setosa"     "versicolor" "virginica" 
wb_source
# [1] "./Y20-11-14-read-write-excel-purrr/datasets/test-excel/test-excel.xlsx"

### Read Excel sheets into a list

### You can then use map() again to run operations across all members of the 
### list, and even chain operations within it:
wb_sheets %>%
  purrr::map(function(sheet){ # iterate through each sheet name
    readxl::read_xlsx(path = wb_source, sheet = sheet)
  }) -> df_list_read # Assign to a list

df_list_read

### Read csv into a list

### Remember these
file_path
# [1] "./Y20-11-14-read-write-excel-purrr/datasets/test-excel/"

csv_file_names %>%
  purrr::map(function(file_name){ # iterate through each file name
    read_csv(paste0(file_path, file_name))
  }) -> df_list_read2 # Assign to a list

df_list_read2

### One last question:
### Can I simply make the list back into a data frame by coercing it?

iris2 <- as.data.frame(df_list_read2)
dim(iris2)
# [1] 50 15
# I was hoping for 150 by 5. This did closer to cbind instead of rbind

(x <- rbind(wb_sheets))
#            [,1]     [,2]         [,3]       
# wb_sheets "setosa" "versicolor" "virginica"

class(x)
# [1] "matrix" "array"

paste(wb_sheets, sep = ",", collapse = ",")

# https://itsalocke.com/blog/r-quick-tip-collapse-a-lists-of-data.frames-with-data.table/
