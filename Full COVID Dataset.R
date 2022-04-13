library(sentimentr)
library(dplyr)
library(data.table)
library(ggplot2)
library(corrplot)
library(tidytext)
library(tidyr)
file.choose()
SUPLdf <- fread("/Users/josephdambrosio/Dropbox/AA-ACADEMICS/AA-Kutztown/2021/Spring/SMS Analytics/Final Project/SMS314 Final Project/Suplemental/covid_data_full.csv")
S13bigram_df <- SUPLdf %>%
  filter(lang == "en") %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
S13trigram_df <- SUPLdf %>%
  filter(lang == "en") %>%
  unnest_tokens(trigram, text, token = "ngrams", n = 3)
