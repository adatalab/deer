# https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15058923
# https://www.data.go.kr/iim/api/selectAPIAcountView.do

## library ----
# remotes::install_github("adatalab/hanwoo")

library(hanwoo)
library(lubridate)
library(dplyr)
library(XML)

key_encoding <- "YOU_API_KEY"
key_decoding <- "YOU_API_KEY"

hanwoo_info("002100113645", key_encoding, key_decoding) # test code; is it working? 올드버전
hanwoo_info("002121614931", key_encoding, key_decoding) # test code; is it working? 최신버전
hanwoo_info("002154949309", key_encoding, key_decoding)

hanwoo_price("", "list", key_encoding = key_encoding)

dd <- hanwoo_info("002121614931", key_encoding, key_decoding)$quality_info
str(dd)
glimpse(dd)

hanwoo::hanwoo_kpn %>% View()

list <- 2120000000:2120001000
list <- paste0("00", as.character(list))

get_hanwoo <- function(x) {
  return(
    tryCatch(hanwoo_info(x, key_encoding, key_decoding)$quality_info,
             error = function(e) NULL
    )
  )
}

multiple_result <- pbapply::pblapply(list[1:10], get_hanwoo)
purrr::map_df(list[1:100], get_hanwoo, .progress=TRUE)

result <- multiple_result %>% map_df(as_tibble)
