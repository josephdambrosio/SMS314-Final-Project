#need following packages: dplyr, tidytext, tidyr

bigram_number <- df %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

#here, we'd pull all 12 word strings out of the df from the "text" column
#as we see the word "text" in the unnest section
#and we see that n = 12
#we likely want to use lower numbers like 2, 3, or 5, but essentially any number can be selected

z <- table(bigram_number$bigram)
z2 <- as.data.frame(z)
z3 <- z2 %>% filter(Freq > 1000) #you can set the Freq number to anything
#the higher the Freq number the less likely to get something
#the lower the number the larger your data outcome will be