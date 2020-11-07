# read_excel_sheets2.R

## See https://rpubs.com/tf_peterson/readxl_import

library(readxl)  # install.packages("readxl") or install.packages("tidyverse")
library(plyr)
library(tibble)

readxl_example()
# [1] "clippy.xls"    "clippy.xlsx"   "datasets.xls"  "datasets.xlsx" "deaths.xls"    "deaths.xlsx"   "geometry.xls" 
# [8] "geometry.xlsx" "type-me.xls"   "type-me.xlsx" 

xl_data <- "C:\\Users\\c_s_b\\R\\win-library\\4.0\\readxl\\extdata\\datasets.xlsx"

# Before reading data, we will return the names of the sheets for later use:
excel_sheets(path = xl_data)
# [1] "iris"     "mtcars"   "chickwts" "quakes"  

# We will now read in just the quakes data. First, specifying by sheet name, then by number

df_quakes_name <- read_excel(path = xl_data, sheet = "quakes")

df_quakes_number <- read_excel(path = xl_data, sheet = 4)

identical(df_quakes_name, df_quakes_number)
# [1] TRUE

## We may want to import all sheets from a workbook. We will do this via 
## lapply(), iterating over the names (or range) of our sheets; passing 
## read_excel() as our function. The resulting object should be a list of 
## four (4) data frames; one (1) per tab.
tab_names <- excel_sheets(path = xl_data)

list_all <- lapply(tab_names, function(x) read_excel(path = xl_data, sheet = x))

str(list_all)
# List of 4
# $ : tibble [150 x 5] (S3: tbl_df/tbl/data.frame)
# ..$ Sepal.Length: num [1:150] 5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# ..$ Sepal.Width : num [1:150] 3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# ..$ Petal.Length: num [1:150] 1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# ..$ Petal.Width : num [1:150] 0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# ..$ Species     : chr [1:150] "setosa" "setosa" "setosa" "setosa" ...
# $ : tibble [32 x 11] (S3: tbl_df/tbl/data.frame)
# ..$ mpg : num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
# ..$ cyl : num [1:32] 6 6 4 6 8 6 8 4 4 6 ...
# ..$ disp: num [1:32] 160 160 108 258 360 ...
# ..$ hp  : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
# ..$ drat: num [1:32] 3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
# ..$ wt  : num [1:32] 2.62 2.88 2.32 3.21 3.44 ...
# ..$ qsec: num [1:32] 16.5 17 18.6 19.4 17 ...
# ..$ vs  : num [1:32] 0 0 1 1 0 1 0 1 1 1 ...
# ..$ am  : num [1:32] 1 1 1 0 0 0 0 0 0 0 ...
# ..$ gear: num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
# ..$ carb: num [1:32] 4 4 1 1 2 1 4 2 2 4 ...
# $ : tibble [71 x 2] (S3: tbl_df/tbl/data.frame)
# ..$ weight: num [1:71] 179 160 136 227 217 168 108 124 143 140 ...
# ..$ feed  : chr [1:71] "horsebean" "horsebean" "horsebean" "horsebean" ...
# $ : tibble [1,000 x 5] (S3: tbl_df/tbl/data.frame)
# ..$ lat     : num [1:1000] -20.4 -20.6 -26 -18 -20.4 ...
# ..$ long    : num [1:1000] 182 181 184 182 182 ...
# ..$ depth   : num [1:1000] 562 650 42 626 649 195 82 194 211 622 ...
# ..$ mag     : num [1:1000] 4.8 4.2 5.4 4.1 4 4 4.8 4.4 4.7 4.3 ...
# ..$ stations: num [1:1000] 41 15 43 19 11 12 43 15 35 19 ...

list_all[[1]]
# A tibble: 150 x 5
# Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#           <dbl>       <dbl>        <dbl>       <dbl> <chr>  
#  1          5.1         3.5          1.4         0.2 setosa 
#  2          4.9         3            1.4         0.2 setosa 
#  3          4.7         3.2          1.3         0.2 setosa 
#  4          4.6         3.1          1.5         0.2 setosa 
#  5          5           3.6          1.4         0.2 setosa 
#  6          5.4         3.9          1.7         0.4 setosa 
#  7          4.6         3.4          1.4         0.3 setosa 
#  8          5           3.4          1.5         0.2 setosa 
#  9          4.4         2.9          1.4         0.2 setosa 
# 10          4.9         3.1          1.5         0.1 setosa 
# ... with 140 more rows

## Lastly, we may have workbooks with sheets identically formatted, but with 
## novel data; e.g. tabs per month, year, location. The following code reads 
## in the worksheets as above, but the list is then collapsed into a single 
## data frame. Note that there are multiple ways to accomplish this task. 
## The example workbook has three (3) identical sheets: “Sheet1”, “…2” and “…3”. 
## Each sheet has the same three (3) columns - “column1”, “…2” and “…3” - 
## each with twenty (20) elements:
  
## column1: A-B-C-D, repeating
## column2: integers 1 through 20
## column3: A-B, repeating

