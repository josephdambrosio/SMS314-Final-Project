#boxplot example
#a boxplot is a unique way to visualize data
#it has two key parts: the box and the whiskers
#the box represents where 50% of the scores are in the dataset
#a line within the box shows were the mean score is
#the whiskers extend up and down from the box
#the distance from the box edge to the end of the whisker is 25% of the data
#so, 50% is in the box, 25% is above, and 25% is below
#if a data point is outside this range; it is shown as a dot and is quite rare
#we will use the example from the book: R for Everyone by Lander
#the dataset is called diamonds, which is a dataset within the ggplot2 R package
install.packages("ggplot2") #this gets the package from the CRAN
library(ggplot2) #get ggplot from you library since you now have it from the CRAN
names(diamonds) #look at the categories for the "diamonds" dataset, which is in ggplot2 package
str(diamonds) #shows you how many observations there are and each categories name and type
boxplot(diamonds$carat) #makes a boxplot of the carat category within diamond dataset
#add a logical title to the plot using code you already learned
#add a logical label to the Y axis using code you already learned
#using what you already know, make the box in the boxplot "light blue"
#the above is the basic way to make a boxplot;however, there is another way
#you can make a boxplot via ggplot and it will give you more things to work with
ggplot(diamonds, aes(y = carat, x = 1)) + geom_boxplot()
#breaking down the above line of code
#ggplot is a function (like when you ask mean(x) to get the mean)
#diamonds is the dataset that we want to visualize
#aes is the aesthetic and we are asking for category "carat" to be y-axis and x-axis to be 1
#geom_boxplot tells the code that we want a boxplot
#this ggplot format is better in some ways than the boxplot(diamonds$carat) one
#ggplot lets us make more variations or types of things
#remember the mosiacplot? #we had two items compared on one visualization
#you can do the same for boxplots using the ggplot version
ggplot(diamonds, aes(y = carat, x = factor(cut))) + geom_boxplot()
#here we compare boxplots of carat size for each kind of diamond cut
#try making a boxplot comparison where price is y and color is x
#finally, go back to your original code from line 32 but make them violin shaped
#you can find what you need in your book, page 105
#the width of the violin parts says how common the give score is, which is more
#accurate than forcing everything into a box

