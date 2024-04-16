library(tidyverse)
library(lubridate)

getwd()
# setwd("../")

df <- readxl::read_excel("data/your_data_set.xlsx") %>% janitor::clean_names(ascii = FALSE)

save(df, file = "data/df.RData")
