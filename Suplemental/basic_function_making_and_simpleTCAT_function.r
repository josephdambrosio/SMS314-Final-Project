
#super simple function would be to simply add 1 point to all scores in a df
#let's make a simple vector with scores 5, 9, 13

vect <- c(5, 9, 13)

#to make the simple function, we first name the function, then say that it's a function
#then we tell it, using special brackets, what to 'do' as a function
#add_one will be the name of our function and it will take our df and add one to it
#given that the function has to work for ANY df regardless of what name someone gave it, we use the letter x
#to represent the object or df

add_one <- function(x) {
  x + 1
}

#now, we can use our function (or verb) on any numbers we want
#it could be a single number
add_one(83) #which will respond with 84
#or a group of numbers (like the vect we created above)
add_one(vect) #which will give 6,10, 14

#we make functions so that any task that we are going to repeat often doesn't have to be typed over and over
#if you do a task more than two times, it suggest you should simply make a function as to make the work easy

#making a function to simplify info from the TCAT
#running the code below will make a function called "simpleTCAT"
#simpleTCAT is a function just like mean() is a function
#within the parenthesis, you will have to put the name of your TCAT dataset
#so, if you import a dataset into R with purple <- read.csv("C://massie//tcatdata//love.csv)
#you will have a dataset called purple and would use:
#simpleTCAT(purple) to remove all extra columns

simpleTCAT <- function(x){
  library(dplyr)
  x %>% select(created_at, from_user_name, text, lang, location, from_user_lang, from_user_tweetcount,
               from_user_followercount, from_user_friendcount, from_user_favourites_count, 
               from_user_listed, from_user_created_at)
}

#this will take the 36 column from the TCAT and make a dataset with only 11 of the most useful ones
#if you want less or more columns for the output, simply change the code in the parentheses after
#select
#so "select(text, lang, location)}" would give you only 3 columns of data from the dataset

#one can add to the function as to mutate and add another column called influence
#influence will be the outcome of dividing followercount 
#by friendcount (i.e.,number of people user is following)
#to make the function have those aspects use the code below

simpleTCAT <- function(x){
  library(dplyr)
  x %>% select(created_at, from_user_name, text, lang, location, from_user_lang, from_user_tweetcount,
               from_user_followercount, from_user_friendcount, from_user_favourites_count, 
               from_user_listed, from_user_created_at)%>%
    mutate(influence = from_user_followercount/from_user_friendcount)
}

#realize that sometime the outcome of "influence" will not end up as a number
#if the user has 8 followers but doesn't follow ANYONE, we have 8/0 which is infinite or NaN
#thus, to know min(), max(), range(), or mean() of the influence (i.e., df$influence)
#you will need to add the statement "na.rm = TRUE"
# new_df_w_influence <- simpleTCAT(purple)
#here, new_df_w_influence will be the simplified purple dataset with the addition of influence
#to get the mean influence, you would have to have
#mean(new_df_w_influence$influence, na.rm = TRUE)

#want to save the simplier dataset, then use:
# write.csv(df, "#name_file.csv")
#so write.csv is the function
#df is the dataframe name after you have used simpleTCAT
#then, after the comma, you put in quotes the name you want to save the file as and .csv

simpleTCAT2 <- function(x){
  library(dplyr)
  x %>% select(created_at, from_user_name, text, lang, location, from_user_lang, from_user_tweetcount,
               from_user_followercount, from_user_friendcount, from_user_favourites_count, 
               from_user_listed, from_user_created_at)%>%
    mutate(influence = from_user_followercount/from_user_friendcount) %>%
    mutate(date.4.timeseries = as.Date(created_at, format = "%m/%d/%Y"))
}
#the above needs work as date fromat does not take
#the last mutate should make the created time changed from a factor to a date as R needs
#dates to be in specific formats; then, date can be used as a time on x axis for a ggplot lineplot