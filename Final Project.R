#install libs 
library(sentimentr)
library(dplyr)
library(data.table)
library(ggplot2)
library(corrplot)
library(tidytext)
library(tidyr)


# START Dataset Selection and DF Import
file.choose()
SUPLdf <- fread("/Users/josephdambrosio/Dropbox/AA-ACADEMICS/AA-Kutztown/2021/Spring/SMS Analytics/Final Project/SMS314 Final Project/DAMBROSIOSEEDCOV.csv")
# END Dataset Selection and DF Import


# START stage one (adv sentiment analysis)
S1prep_df <- get_sentences(as.vector(SUPLdf$text))
S1sent_df <- sentiment(S1prep_df)
mean(S1sent_df$sentiment) 
range(S1sent_df$sentiment)
#View(S1sent_df)
#z <- S1sent_df
# END stage one (adv sentiment analysis)

# START stage two (influence score)
S2infl_df <- SUPLdf %>%
  mutate(influence = from_user_followercount / from_user_friendcount)
# END stage two (influence score)

# START stage three (recombining sentiment scores)
S3recmb_df <- S1sent_df %>%
  group_by(element_id) %>%
  summarize(mean(sentiment))
# END stage three (recombining sentiment scores)

# START stage four (sent scores and infl scores)
S4newest_df <- data.frame(S2infl_df, S3recmb_df$'mean(sentiment)')
# END stage four (sent scores and infl scores)

# START stage five (clean up DF)
S5clean_df <- S4newest_df %>%
  filter(from_user_friendcount > 0, from_user_followercount > 0)
S5finalClean_df <- S5clean_df %>%
 mutate(sentiment_score = S3recmb_df..mean.sentiment..) %>%
  select(-c(S3recmb_df..mean.sentiment..))
# END stage five (clean up DF)

# START stage 6 (create date)
x6 <- S5finalClean_df$created_at
x6_2 <- as.Date(x6)
S6_FinalDF <- S5finalClean_df %>%
  mutate(Date = x6_2) %>%
  select(-c(created_at))
# END stage 6 (create date)
  
# STAGE 7 NOT DONE
barplot(S6_FinalDF$Dates, main = "Change over time: Influence", type = "b")
# END stage 7

# START stage 8 (splitting DF and summarize by sentiment and influence)
S8splitINFL_df <- S6_FinalDF %>%
  group_by(Date) %>%
  summarize(mean(influence))
S8splitSNTMNT_df <- S6_FinalDF %>%
  group_by(Date) %>%
  summarize(mean(sentiment))
# END stage 8

# START stage 9 (Plot Change over time; sent & influ)
plot(S8splitINFL_df, main = "Change over time: Influence", type = "b")
plot(S8splitSNTMNT_df, main = "Change over time: Sentiment", type = "b")
# END stage 9

# START stage 10 (find top people)
round(mean(S6_FinalDF$sentiment), 3)
round(mean(S6_FinalDF$influence), 3)
# END stage 10

# START stage 11
corrplot_df <- S6_FinalDF %>%
  select(from_user_tweetcount, favorite_count, from_user_followercount, from_user_listed, influence, sentiment)
corrplot(cor(corrplot_df), method = "number")
# END stage 11

# START stage 12
S12topINFLR_df <- S6_FinalDF %>%
  filter(influence > 2461)
# END stage 12

# START stage 13
S13ngram_df <- S5finalClean_df %>%
  filter(lang == "en") %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
# END stage 13

# START stage 14
fivegram <- function(x) {
  library(dplyr)
  library(tidytext)
  library(tidyr)
  bigram_number <- x %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 5)
  z <- table(bigram_number$bigram)
  z2 <- as.data.frame(z)
  View(z2)}
fivegram_eng <- function(x) {
  library(dplyr)
  library(tidytext)
  library(tidyr)
  bigram_number <- x %>%
    filter(lang == "en") %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 5)
  z <- table(bigram_number$bigram)
  z2 <- as.data.frame(z)
  View(z2)}
# END stage 14



  
  
  
  