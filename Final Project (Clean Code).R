library(sentimentr)
library(dplyr)
library(data.table)
library(ggplot2)
library(corrplot)
library(tidytext)
library(tidyr)
file.choose()
SUPLdf <- fread("/Users/josephdambrosio/Dropbox/AA-ACADEMICS/AA-Kutztown/2021/Spring/SMS Analytics/Final Project/SMS314 Final Project/DAMBROSIOSEEDCOV.csv")
S1prep_df <- get_sentences(as.vector(SUPLdf$text))
S1sent_df <- sentiment(S1prep_df)
mean(S1sent_df$sentiment) 
range(S1sent_df$sentiment)
S2infl_df <- SUPLdf %>%
  mutate(influence = from_user_followercount / from_user_friendcount)
S3recmb_df <- S1sent_df %>%
  group_by(element_id) %>%
  summarize(mean(sentiment))
S4newest_df <- data.frame(S2infl_df, S3recmb_df$'mean(sentiment)')
S5clean_df <- S4newest_df %>%
  filter(from_user_friendcount > 0, from_user_followercount > 0)
S5finalClean_df <- S5clean_df %>%
 mutate(sentiment_score = S3recmb_df..mean.sentiment..) %>%
  select(-c(S3recmb_df..mean.sentiment..))
x6 <- S5finalClean_df$created_at
x6_2 <- as.Date(x6)
S6_FinalDF <- S5finalClean_df %>%
  mutate(Date = x6_2) %>%
  select(-c(created_at))
BPtbl <- table(S6_FinalDF$Date)
barplot(BPtbl, col='blue', main= 'Barplot of Tweets about COVID-19')
S8splitINFL_df <- S6_FinalDF %>%
  group_by(Date) %>%
  summarize(mean(influence))
S8splitSNTMNT_df <- S6_FinalDF %>%
  group_by(Date) %>%
  summarize(mean(sentiment_score))
plot(S8splitINFL_df, main = "Change over time: Influence", type = "b")
plot(S8splitSNTMNT_df, main = "Change over time: Sentiment", type = "b")
round(mean(S6_FinalDF$sentiment), 3)
round(mean(S6_FinalDF$influence), 3)
corrplot_df <- S6_FinalDF %>%
  select(from_user_tweetcount, favorite_count, from_user_followercount, from_user_listed, influence, sentiment_score)
corrplot(cor(corrplot_df), method = "number")
S12topINFLR_df <- S6_FinalDF %>%
  filter(influence > 2461)
text <- as.vector(S12topINFLR_df$text)
text_df <- data_frame(line = 1:5, text = text)
text_df2 <- text_df %>% unnest_tokens(word, text)
text_df3 <- text_df2 %>% anti_join(stop_words) %>% count(word, sort = TRUE)
text_df_NRC <- text_df3 %>% inner_join(get_sentiments("nrc"))
text_df_NRC
mean(text_df_NRC$value)
S13bigram_df <- S5finalClean_df %>%
  filter(lang == "en") %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
S13trigram_df <- S5finalClean_df %>%
  filter(lang == "en") %>%
  unnest_tokens(trigram, text, token = "ngrams", n = 3)
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



  
  
  
  