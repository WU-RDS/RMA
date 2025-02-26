## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# read.csv2 is shorthand for read.csv(file, sep = ";")
sales_data <- read.csv2("https://raw.githubusercontent.com/WU-RDS/RMA/refs/heads/main/data/data_visualization.csv", sep = ";") %>% # pipe data into mutate
  mutate(Date = as.Date(Date), # convert to date
         Store = as.factor(Store), # convert to factor w. new labels
         Category = as.factor(Category), # convert to factor with values as labels
         Brand = as.factor(Brand)) %>%
  filter(!is.na(Sales_Amount)) 

head(sales_data)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# number of observations per category (i.e., in how many rows do we have information about category "clothes", ... etc)
table(sales_data$Category) #absolute frequencies
table(sales_data$Store) #absolute frequencies


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# share of observations per category (i.e., in how many rows do we have information about category "clothes", ... etc)
prop.table(table(sales_data$Category)) #relative frequencies
prop.table(table(sales_data$Store)) #relative frequencies

# We can extract specific values directly from the table:
grocery_share <- prop.table(table(sales_data$Category)) # first create the relative frequencies table
grocery_share <- round(100*grocery_share[names(grocery_share) == "Grocery"], digits = 1) # extract the value that satisfies the condition (where the name of category is "Grocery")
grocery_share

store_2_share <- prop.table(table(sales_data$Store))
store_2_share <- round(100*store_2_share[names(store_2_share) == "Store 2"], digits = 1)
store_2_share


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
prop.table(table(select(sales_data, Store, Category)), 1) # conditional relative frequencies BY STORE
prop.table(table(select(sales_data, Store, Category)), 2) # another conditional relative frequencies - but now against the second variable 
                                                          # (e.g., category Clothing has the highest share of its sales in Store 8 (12.17%))


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# average customer age
avg_age <- mean(sales_data$Customer_Age)
avg_age

# median customer age
median_age <- median(sales_data$Customer_Age)
median_age

# or using quantile()
median_age <- quantile(sales_data$Customer_Age, 0.5, type = 1)
median_age

# customer age by percentiles
quantile(sales_data$Customer_Age, c(0.25,0.5,0.75), type = 1)

# mode customer age
library(DescTools)
mode_age <- Mode(sales_data$Customer_Age)
mode_age


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Get a wider set of descriptive statistics (many are only applicable to numeric values, measured in interval or ratio scales)
library(psych)
psych::describe(select(sales_data, Sales_Amount, Units_Sold, Customer_Age))

# descriptive statistics by group
describeBy(select(sales_data, Sales_Amount, Units_Sold, Customer_Age), sales_data$Category, skew = FALSE, range = FALSE)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# calculate standard deviation if it is needed later on for manual analysis. This is also usually referred to as "normalization"
sales_data$sales_std <- (sales_data$Sales_Amount - mean(sales_data$Sales_Amount))/sd(sales_data$Sales_Amount)
sales_data$sales_std <- scale(sales_data$Sales_Amount) 

