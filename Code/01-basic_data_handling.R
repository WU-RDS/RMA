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

# such operations can be performed not just with "single" values; we can do the same with values in data tables (see further)

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
log(top10_sales) # you can take logarithm of the values in the row you created by applying the function log() to the whole object that contains the values of interest. 
# It also works with columns in data tables (see further)

# Character:
products <- c("Bio-Kaisersemmel", "Laktosefreie Bio-Vollmilch", "Ottakringer Helles", "Milka Ganze Haselnüsse", "Bio-Toastkäse Scheiben", "Ottakringer Bio Zwickl", "Vienna Coffee House Espresso", "Bio-Mozzarella", "Basmati Reis", "Bananen") # Characters have to be put in ""


### Data files: 
## in this course, we use data files, stored on a server; these files can be read into R as follows
sales_data <- read.csv("https://raw.githubusercontent.com/WU-RDS/RMA2024/main/data/Sales_Data,csv", 
                      sep = ";", 
                      header = TRUE)

# If you ever need to read in files from your local device (your laptop, etc.), use the code below. 
# You must check where the file is saved (provide the full file path), how it is named, and (in case of csv. files) what separators it uses: , or ; or tabular
#sales_data <- read.csv("full path to your file", sep = ";", header = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#sales_data # Returns the entire data frame. NEVER DO IT. 

head(sales_data, 3) # returns the first N rows (here, the first 3 rows)
tail(sales_data, 3) # returns the last N rows (here, the last 3 rows)

#names(sales_data) # returns the names of the variables in the data frame

str(sales_data) # returns the structure of the data frame

nrow(sales_data) # returns the number of rows 
ncol(sales_data) # returns the number of columns 

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
sales_data$top10_sales # this is the way to "call" a specific column from a data table (or data frame). Read: top10_sales from sales_data
# It makes the column "active" - using this notation, you can perform any operations with a specified column


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
sales_data[ , 2:4] # all rows and columns 2,3,4
sales_data[5:7, ] # rows 5,6,7 and all columns



## --------------------------------------------------------------------------------------------------------------------------------------------------------------
### Operations with data
library(tidyverse)

# 1. Filtering (ROWS)
# Filter by specific values
filter(sales_data, private_label == "private label") # show only products that belong to private labels
filter(sales_data, top10_sales > 100000) # show only products that sold more than 100,000 units  
filter(sales_data, top10_product_names == 'Bio-Kaisersemmel') # returns all observations from product "Bio-Kaisersemmel"
private_labels <- filter(sales_data, private_label == "private label") # creates a new data.frame by assigning only observations belonging to private labels

#another way of using dplyr functions: with a pipe
sales_data %>% filter(private_label == "private label")


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2. Arranging
# Arrange by sales (descending: most - least) 
arrange(sales_data, desc(top10_sales))

# Arrange by brand (ascending by default) and then sales (descending: most - least) 
arrange(sales_data, top10_brand, desc(top10_sales))


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# 3. Selecting (COLUMNS)
# Keep only several columns. Again, if you need to use the result for analysis or show it in a presentation, you need to create the object. 
select(sales_data, top10_product_names, top10_sales, private_label)

#spot the difference:
select(sales_data, private_label)
select(sales_data, private_label) %>% unique() # you can retrieve unique combinations for one column's value, ... 
select(sales_data, top10_brand, private_label) %>% unique() # ... or unique combinations of different columns


# Another way to do the same - remove columns that you don't need
select(sales_data, -date_most_sold, -private_label_logical)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create new variable as the log of sales
sales_data$log_sales <- log(sales_data$top10_sales) 

# Create an ascending count variable which might serve as an ID
sales_data$obs_number <- 1:nrow(sales_data)
head(sales_data)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# 4. Grouping and 5. Summarizing 
# Get summary statistics by grouping observations by some characteristic: functions group_by() and summarize()
sales_total <- sales_data %>% 
  group_by(top10_brand) %>%
  summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))
head(sales_total)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# 6. Mutating
sales_data_new <- mutate(sales_data, 
       sqrt_sales = sqrt(top10_sales),
       # "%m" extracts the month, format returns a character so we convert it to integer
       most_sales_month = as.integer(format(date_most_sold, "%m")) 
       ) %>%
  select(top10_product_names, sqrt_sales, most_sales_month)
head(sales_data_new)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# To rename a column, use rename() function from dplyr package. On the left side (before "="), give the new name, then specify what existing column should be renamed like this
sales_data <- dplyr::rename(sales_data, brand = top10_brand)
head(sales_data)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#load data from file on disk. You have to make sure that your working directory is set correctly, 
# your R file is open from the working directory, and either your data file is located in the working directory 
# or you provide a correct path to it
test_data <- read.csv("sales_data.csv", header = TRUE, sep = ",") #assuming your R file and data file are located in one folder == working directory
head(test_data)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# If you need to export your data (e.g., to send it to a colleague)
write.csv(sales_data, "Sales_Data.csv", row.names = FALSE) # writes to a comma-separated value file


## Let's practice!


