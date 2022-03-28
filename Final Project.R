#install dependancies 
install.packages("sentimentr")
install.packages("dplyr")
install.packages("data.table")
library(sentimentr)
library(dplyr)
library(data.table)

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
  
  
  
  
  