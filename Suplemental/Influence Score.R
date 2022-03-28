library(data.table)
library(dplyr)
file.choose()
df <- fread("/Users/josephdambrosio/Dropbox/AA-ACADEMICS/AA-Kutztown/2021/Spring/SMS Analytics/dplyr Assignement HW/DAMBROSIOSEEDCOV.csv")

df %>%
  select(from_user_name, from_user_tweetcount, from_user_followercount, lang, from_user_friendcount) %>%
  filter(from_user_followercount > 0, from_user_friendcount >0) %>%
  mutate(influence = from_user_followercount / from_user_friendcount) %>%
  group_by(lang) %>%
  summarise(avg_influence = mean(influence)) %>%
  arrange(desc(avg_influence))


