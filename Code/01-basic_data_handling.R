## This is the beginning of the code

## Remember to run the code line by line, without skipping any of lines, top-to-bottom (i.e., never start in the middle of the code)

x <- "hello world" # assigns the words "hello world" to the object x
# this is a comment (any number of "#" denotes a comment; the number of "#" does not matter)

x # print the value of x to the console
#print(x) # - another way to print the results (in this case, the value of x)

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
x <- 2 # assigns the value of 2 to the object x
x
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

# such operations can be performed not just with "single" values; we can do the same with values in data tables (see below)

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#class(y) # check the class of the variable (what type of variable it is) - or hover over the "y" cell in the top right corner (Global Environment)
y <- as.character(y)
y <- as.numeric(y)
y


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
## Data Import

### Manual:
# Numeric:
sales <- c(163608, 126687, 120480, 110022, 108630, 95639, 94690, 89011, 87869, 85599) # function c() means "concatenate" (= merge) and serves for creating a row of values
log(sales) # you can take logarithm of the values in the row you created by applying the function log() to the whole object that contains the values of interest. 
# It also works with columns in data tables (see further)

# Character:
products <- c("Bio-Kaisersemmel", "Laktosefreie Bio-Vollmilch", "Ottakringer Helles", "Milka Ganze Haselnüsse", "Bio-Toastkäse Scheiben", "Ottakringer Bio Zwickl", "Vienna Coffee House Espresso", "Bio-Mozzarella", "Basmati Reis", "Bananen") # Characters have to be put in ""


### Data files: 
## in this course, we use data files, stored on a server; these files can be read into R as follows
sales_data <- read.csv("https://raw.githubusercontent.com/WU-RDS/RMA2024/refs/heads/main/data/Sales_Data.csv", 
                      sep = ",", 
                      header = TRUE)

# If you ever need to read in files from your local device (your laptop, etc.), use the code below. 
# You must check where the file is saved (provide the full file path), how it is named, and (in case of csv. files) what separators it uses: , or ; or tabular
#sales_data <- read.csv("full path to your file", sep = ";", header = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#sales_data # Returns the entire data frame. NEVER DO IT AGAIN. 

head(sales_data, 3) # returns the first N rows (here, the first 3 rows)
tail(sales_data, 3) # returns the last N rows (here, the last 3 rows)

#names(sales_data) # returns the names of the variables in the data frame

str(sales_data) # returns the structure of the data frame

# Your to-dos when inspecting the structure of the data frame:
# 1. Check if the data is read in correctly (e.g., if the columns are split correctly)
# 2. Check how the columns are called and what the spelling is. You must refer to columns exactly how they are called in the data frame.
# 3. Check data types: what columns (variables) should be numeric but are currently character? Are there any dates that are not in the date format?
# 4. If something is wrong, change the data types, targeting specific columns:

sales_data$top10_sales <- as.numeric(sales_data$top10_sales) # in this case, it's basically not necessary, because integer ("int") is by definition numeric
sales_data$date_most_sold <- as.Date(sales_data$date_most_sold)
sales_data$private_label <- as.factor(sales_data$private_label) # for most analyses, it doesn't matter if such variables are characters or factors, as characters will be treated as unique groups (or factors)


nrow(sales_data) # returns the number of rows 
ncol(sales_data) # returns the number of columns 

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
sales_data$top10_sales # this is the way to "call" a specific column from a data table (or data frame). Read: top10_sales from sales_data
# It makes the column "active" - using this notation, you can perform any operations with a specified column


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
### Operations with data

# I want you to make two mistakes:
Sales_data
sales_data$top1_sales

#sales_data
#sales_data$top10_sales

select(sales_data, private_label)

library(tidyverse)
#select(sales_data, private_label)

# 1. Filtering (ROWS)
# Filter by specific values
filter(sales_data, private_label == "private label") # show only products that belong to private labels
# typical syntax of dplyr functions is: function(data_frame, the action with a column of interest)

# however, let's check another way of using dplyr functions: with a pipe
sales_data %>% filter(private_label == "private label")
# hence the syntax: data_frame THEN function(action with a column)
# note that we don't put the data_frame in the function itself anymore:
# you can read this as follows: take "sales_data", then filter [it] by "private_label"

sales_data %>% filter(top10_sales > 100000) # show only products that sold more than 100,000 units  
sales_data %>% filter(top10_product_names == 'Bio-Kaisersemmel') # returns all observations from product "Bio-Kaisersemmel"

# we can create an object based on our manipulations. 
private_labels <- sales_data %>% filter(private_label == "private label")
# ! Note that as a result of this code, there is NO output down in the console. This means that if you run this line in your report, your manager won't see any results!
# To get the result of the code above as an output, call the created object:
private_labels


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2. Arranging
# Arrange by sales (descending: most - least) 
sales_data %>% arrange(desc(top10_sales)) 
# function desc() is applied directly to column "top10_sales", but it is also correct to write sales_data %>% arrange(desc(sales_data$top10_sales)) 

# Arrange by brand (ascending by default) and by sales (descending: most - least) by simply listng the columns in the order that you need
sales_data %>% arrange(top10_brand, desc(top10_sales))


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# 3. Selecting (COLUMNS)
# Keep only several columns. Again, if you need to use the result for analysis or show it in a presentation, you need to create the object. 
sales_data %>% select(top10_product_names, top10_sales, private_label)

# spot the difference:
sales_data %>% select(private_label)
sales_data %>% select(private_label) %>% unique() # you can retrieve unique combinations for one column's value, ... 
sales_data %>% select(top10_brand, private_label) %>% unique() # ... or unique combinations of different columns

# Another way to do the same - remove columns that you don't need
sales_data %>% select(-date_most_sold, -private_label_logical)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create new variable as the log of sales
sales_data$log_sales <- log(sales_data$top10_sales) 

# Create an ascending count variable which might serve as an ID
sales_data$obs_number <- 1:nrow(sales_data)
head(sales_data)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# 4. Summarizing and 5. Summarizing with Grouping
# Get summary statistics for the data frame, e.g., total sales (overall across the whole dataset)
sales_data %>% summarize(total_sales = sum(top10_sales))

# Get the max and min sales from the dataset (i.e., observations that have the biggest and the smallest sales value)
sales_data %>% summarize(max_sales = max(top10_sales), min_sales = min(top10_sales))


# Get summary statistics by grouping observations by some characteristic: functions group_by() and summarize()
# total and average sales BY GROUP (in this case, by brand)
sales_data %>% group_by(top10_brand) %>% summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))

# We can split the code line by " %>% " to make it more readable:
sales_data %>% 
  group_by(top10_brand) %>% 
  summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))

# In many cases, it makes sense to save the results of our summary as a new object (then we can reuse it in some analyses or export from R as Excel file)
summary <- sales_data %>% 
  group_by(top10_brand) %>% 
  summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))
# Again, there is no "presentable" output in the console unless we call it directly:
summary

# Important: summarize() keeps only the grouping columns and the columns that you create to get the desired summary; it drops all other unused columns.
# If you need to keep more columns, e.g., private_label, they should be also included in the group_by():
summary_new <- sales_data %>% 
  group_by(top10_brand, private_label) %>% 
  summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))
# The message in the console simply tells you that the main grouping variable is top10_brand; private_label was not used for any meaningful grouping.
summary_new


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# 6. Mutating
# Very similar to summarize(), but in this case it keeps all columns of a data frame and simply performs operations with them: 
#   either changing the existing columns or creating new columns
sales_data %>% mutate(sqrt_sales = sqrt(top10_sales)) %>%
  select(top10_product_names, sqrt_sales)

sales_data %>% mutate(most_sales_month = as.integer(format(date_most_sold, "%m"))) %>% 
# "%m" extracts the month, format returns a character so we convert it to integer - JUST an example for you of what R can do
  select(top10_product_names, most_sales_month)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# To rename a column, use rename() function from dplyr package. 
# On the left side (before "="), give the new name, then specify what existing column should be renamed like this
# By writing "dplyr::" before the function, we tell R from which package to take the needed function 
#  (because in many packages, functions have the same names but have different syntax and outcomes; 
#  knowing which function we need, we call it from the respective package).
sales_data <- dplyr::rename(sales_data, brand = top10_brand)
head(sales_data)

# Let's make the mistake regarding the "dplyr::" part:
sales_data <- rename(sales_data, brand_new = brand) 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# If you need to export your data (e.g., to send it to a colleague)
write.csv(sales_data, "Sales_Data.csv", row.names = FALSE) # writes to a comma-separated value file

# To save as Excel file:
library(xlsx)
write.xlsx(sales_data, "Sales_Data.xlsx", # we can also split the code in lines by comma (not just by " %>% ")
           sheetName = "Data",
           row.names = FALSE)



## --------------------------------------------------------------------------------------------------------------------------------------------------------------
### Let's practice!

# 1. What is the difference between these two code lines (their outputs)?
sales_data %>% filter(private_label == "private label")
private_labels <- sales_data %>% filter(private_label == "private label")


# 2. Filter the data frame "sales_data" by sales below (less than) 100000: fill in the "filter()" function
sales_data %>% filter()


# 3. Filter the data frame "sales_data" by national brands (i.e., only keep observations with national brands). Write the whole code yourself.


# 4. What happens when you use select() vs. filter()? Try both and observe the differences:
sales_data %>% select(brand, top10_sales)
sales_data %>% filter(private_label == "national brand")


# 5. Select only the columns that contain information about the brand name and the sales: fill in the "select()" function
sales_data %>% select()


# 6. Arrange the “sales_data” in ascending order of date: fill in the "arrange()" function
sales_data %>% arrange()


# 7. Group by “brand” and summarize total sales for each brand. Write the whole code yourself.



