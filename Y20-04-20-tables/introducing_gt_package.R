# introducing_gt_package.R

# https://blog.rstudio.com/2020/04/08/great-looking-tables-gt-0-2/

library(gt)
library(tidyverse)
library(glue)

# Define the start and end dates for the data range
start_date <- "2010-06-07"
end_date <- "2010-06-14"

# Create a gt table based on preprocessed
# `sp500` table data
x <-  sp500 %>%
  dplyr::filter(date >= start_date & date <= end_date) %>%
  dplyr::select(-adj_close) %>%
  gt() %>%
  tab_header(
    title = "S&P 500",
    subtitle = glue::glue("{start_date} to {end_date}")
  ) %>%
  fmt_date(
    columns = vars(date),
    date_style = 3
  ) %>%
  fmt_currency(
    columns = vars(open, high, low, close),
    currency = "USD"
  ) %>%
  fmt_number(
    columns = vars(volume),
    suffixing = TRUE
  )

## Me playing around--can save as image with ggsave()
ggsave(sp500,
       device = "png",
       width = 2.83,
       height = 2.21,
       units = "in"
) 

##  From blog:
### Nice, yet still flextable + officer would be my first choice. Table 
## formatting features seems the same but it offers easy export to .docx