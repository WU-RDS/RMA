## --------------------------------------------------------------------------------------------------------------------------------------------------------------
x <- "hello world" # assigns the words "hello world" to the object x
# this is a comment


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
x # print the value of x to the console


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
print(x) # print the value of x to the console

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
x <- 2 # assigns the value of 2 to the object x
print(x)
x == 2  # checks whether the value of x is equal to 2
x != 3  # checks whether the value of x is NOT equal to 3
x < 3   # checks whether the value of x is less than 3
x > 3   # checks whether the value of x is greater than 3


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
y <- 5 # assigns the value of 2 to the object x
x == y # checks whether the value of x to the value of y
x*y # multiplication of x and y
x + y # adds the values of x and y together
y^2 + 3*x # adds the value of y squared and 3x the value of x together


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
class(y)
y <- as.character(y)
y <- as.numeric(y)
print(y)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Numeric:
top10_sales <- c(163608, 126687, 120480, 110022, 108630, 95639, 94690, 89011, 87869, 85599) # function c() means "concatenate" (= merge) and serves for creating a row of values
log(top10_sales) # you can take logarithm of the values in the row you created by applying the function log() to the whole object that contains the values of interest. It also works with columns
# Character:
top10_product_names <- c("Bio-Kaisersemmel", "Laktosefreie Bio-Vollmilch", "Ottakringer Helles", "Milka Ganze Haselnüsse", "Bio-Toastkäse Scheiben", "Ottakringer Bio Zwickl", "Vienna Coffee House Espresso", "Bio-Mozzarella", "Basmati Reis", "Bananen") # Characters have to be put in ""

# Factor variable with two categories:
private_label <- c(1,1,0,0,1,0,0,1,1,1)
private_label <- factor(private_label, 
                               levels = 0:1, 
                               labels = c("national brand", "private label"))

# Factor variable with more than two categories:
top10_brand <- c("Ja! Natürlich", "Ja! Natürlich", "Ottakringer", "Milka", "Ja! Natürlich", "Ottakringer", "Julius Meinl", "Ja! Natürlich", "Billa Bio", "Clever")
top10_brand <- as.factor(top10_brand)

# Date:
date_most_sold <- as.Date(c("2023-05-24", "2023-06-23", "2023-09-01", "2023-06-30", "2023-05-05", "2023-06-09", "2023-07-14", "2023-06-16", "2023-05-18", "2023-05-19"))

# Logical
private_label_logical <- c(TRUE,TRUE,FALSE,FALSE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE)  


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
top10_sales

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
date_most_sold


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
class(date_most_sold)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
sales_data <- data.frame(top10_sales, 
                         top10_product_names, 
                         private_label, 
                         top10_brand, 
                         date_most_sold, 
                         private_label_logical)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
sales_data # Returns the entire data frame. NEVER DO IT AGAIN. 

head(sales_data, 3) # returns the first X rows (here, the first 3 rows)
tail(sales_data, 3) # returns the last X rows (here, the last 3 rows)

names(sales_data) # returns the names of the variables in the data frame

str(sales_data) # returns the structure of the data frame

nrow(sales_data) # returns the number of rows 
ncol(sales_data) # returns the number of columns 
dim(sales_data) # returns the dimensions of a data frame

ls(sales_data) # list all objects associated with an object

ls() # list of all objects you created

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
sales_data$top10_sales


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
sales_data[ , 2:4] # all rows and columns 2,3,4
sales_data[5:7, ] # rows 5,6,7 and all columns


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
filter(sales_data, private_label == "private label") # show only products that belong to private labels
filter(sales_data, top10_sales > 100000) # show only products that sold more than 100,000 units  
filter(sales_data, top10_product_names == 'Bio-Kaisersemmel') # returns all observations from product "Bio-Kaisersemmel"
private_labels <- filter(sales_data, private_label == "private label") # creates a new data.frame by assigning only observations belonging to private labels


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Arrange by sales (descending: most - least) 
arrange(sales_data, desc(top10_sales))

# Arrange by brand (ascending by default) and then sales (descending: most - least) 
arrange(sales_data, top10_brand, desc(top10_sales))


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Keep only several columns. Again, if you need to use the result for analysis or show it in a presentation, you need to create the object. 
select(sales_data, top10_product_names, top10_sales, private_label)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Another way to do the same - remove columns that you don't need
select(sales_data, -date_most_sold, -private_label_logical)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create new variable as the log of sales
sales_data$log_sales <- log(sales_data$top10_sales) 
# Create an ascending count variable which might serve as an ID
sales_data$obs_number <- 1:nrow(sales_data)
head(sales_data)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Get summary statistics by grouping observations by some characteristic: functions group_by() and summarize()
sales_total <- sales_data %>% 
  group_by(top10_brand) %>%
  summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))
head(sales_total)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
sales_data_new <- mutate(sales_data, 
       sqrt_sales = sqrt(top10_sales),
       # "%m" extracts the month, format returns a character so we convert it to integer
       most_sales_month = as.integer(format(date_most_sold, "%m")) 
       ) %>%
  select(top10_product_names, sqrt_sales, most_sales_month)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# To rename a column, use rename() function from dplyr package. On the left side (before "="), give the new name, then specify what existing column should be renamed like this
sales_data <- dplyr::rename(sales_data, brand = top10_brand)
head(sales_data)

# Other two ways:
names(sales_data)[names(sales_data)=="brand"] <- "top10_brand"
head(sales_data)

names(sales_data)[4] <- "brand"
head(sales_data)


## Data import
## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#load data from server
readLines("https://short.wu.ac.at/ma22_musicdata", n = 3)
test_data <- read.csv("https://short.wu.ac.at/ma22_musicdata", 
                      sep = ";", 
                      header = TRUE)
head(test_data)

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#load data from file on disk. You have to make sure that your working directory is set correctly, 
# your R file is open from the working directory, and either your data file is located in the working directory 
# or you provide a correct path to it
test_data <- read.csv("sales_data.csv", header = TRUE, sep = ",") #assuming your R file and data file are located in one folder == working directory
head(test_data)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#export data
write.csv(sales_data, "Sales_Data.csv", row.names = FALSE) # writes to a comma-separated value file

