#install dependancies 
install.packages("sentimentr")
install.packages("dplyr")
install.packages("data.table")
library(sentimentr)
library(dplyr)
library(data.table)

# START Dataset Selection and DF Import
file.choose()
SUPLdf <- fread("/Users/josephdambrosio/Dropbox/AA-Kutztown/2021/Spring/SMS Analytics/Final Project/SMS314 Final Project/DAMBROSIOSEEDCOV.csv")
# END Dataset Selection and DF Import


# START stage one (adv sentiment analysis)
S1prep_df <- get_sentences(as.vector(SUPLdf$text))
S1sent_df <- sentiment(prep_df)
mean(S1sent_df$sentiment) 
range(S1sent_df$sentiment)
View(S1sent_df)
z <- S1sent_df
# END stage one (adv sentiment analysis)

# START stage two (influence score)
S2infl_df <- S1sent_df %>%
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