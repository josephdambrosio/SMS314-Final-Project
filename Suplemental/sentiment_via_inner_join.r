#sentiment via inner_join; you'll need dplyr, tidytext, textdata packages
#doing sentiment via inner_join allows you access to 3 different approaches to sentiment
library(dplyr)
library(tidytext)
library(textdata)
#get a TCAT file (for this example we will call our file df, but you can call it anything)
#if you call it "fred" then everywhere you see df in the code, you have to change to fred
file.choose()
df <- read.csv("/Users/josephdambrosio/Dropbox/My Mac (MacBook-Pro.home)/Downloads/TCAT_electiondata_example_50tweets_only_MINI - Copy.csv")
text <- as.vector(df$text) #this pulls out only the tweets of the dataframe and converts them to a vector
length(text) #this will tell you how long the dataframe is; you will need this number

#you will need the following packages: dplyr, tidytext, and tidyr

text_df <- data_frame(line = 1:50, text = text)
#line 12 is important to focus on at this point
#FIRST, the numbers used for "line =" come from the outcome of line 8 you did before
#when I did it, my dataset has 23,398 as a length; so, I want line 1 through 23398 or 1:23398
#you will have a different second number because your dataset likely has a different length
#SECOND, you WILL get a warning after running this, but it okay, it is only telling you that
#it made a "tibble" which is a special kind of dataframe that we need for the next steps

text_df2 <- text_df %>% unnest_tokens(word, text)
#if you have a large data set you may get a warning here too, but a warning is NOT an error
#the unnest_tokens function works to break every "unit" (in this case a word) to be by itself
#so a tweet like "I like chocolate" which starts as ONE thing, gets broken into THREE things
# I   like    chocolate
#so, in my df of 23398 tweets, ended up with 520,132 words
#the 520,132 is ALL words not unique words (so "the" may make up 5000 of the words)

#Quick note: Realize that we have renamed text_df to text_df2
#doing so helps if we make a mistake we can tell where the issue arose
text_df3 <- text_df2 %>% anti_join(stop_words) %>% count(word, sort = TRUE)
#this step does two things at once: (1) removes "stop_words" like "the," "a", "an" and THEN (2) counts words, sorting by most common
#you may get odd data here, my df top word is an "a" with a line above it, a carrot
#you can View(text_df3) and you will see the most common words in your dataset

#there are 3 sentiment types in the tidytext package
#"afinn" (developed by Finn Arup Nielsen)
#"bing" (developed by Bing Liu and others)
#and "nrc" (by Saif Mohammad and Peter Turney)

#The afinn system will give you a score from -5 to +5 (as it becomes numeric and can be graphed easily)
#The bing system will give you a sentiment based in negative or positive only
#The nrc system, used in our "advance sentiment script" gives the 8 basic emotions and positive or negative (i.e., 10 categories)

text_df_afinn <- text_df3 %>% inner_join(get_sentiments("afinn"))
#named the object with afinn to remember what system 
#the inner_join says "where in your dataset does it overlap with the afinn list of words and sentiment scores?"
#you may end up needing R to download the afinn dictionary (or others) if it gives a selection of 
#1: Yes or 2:No, then you will type "1" (no quote marks) after the word Selection:
text_df_afinn  #this will show you a tibble of the top word, its frequency, and sentiment score
#higher the positive the more positive the sentiment, the lower the negative the more negative
#with 5 being the max pos and -5 being max neg; zero, then, is neutral
#As we have numbers, we can find the average
mean(text_df_afinn$value) #here, you ask for the mean of the column "score" from the dataset called "text_df_afinn"
#this is the average for all words that matched the afinn lexicon [this is now called "value" rather than "score"]

#want to do a "bing" sentiment or a "nrc" one?
#Simply (1) rename the object in line 43 and replace the "afinn" with the system you want
#as these systems do not yield numbers, you cannot run a mean on them
#to get the number of outcomes use the table() function and put the (name of the object)$sentiment



