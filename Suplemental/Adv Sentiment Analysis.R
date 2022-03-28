#init packages
library(data.table)
install.packages("sentimentr")
library(sentimentr)

#choose file
file.choose()
#import csv to df
df <- fread("/Users/josephdambrosio/Dropbox/AA-Kutztown/2021/Spring/SMS Analytics/Sentiment R COVID HW/DAMBROSIOSEEDCOV.csv")

#copy "text" column into separate df
prep_df <- get_sentences(as.vector(df$text))

#run sentiment analysis on prep_df, store values into new df
sent_df <- sentiment(prep_df)

#display data
mean(sent_df$sentiment) 
range(sent_df$sentiment)
View(sent_df)
