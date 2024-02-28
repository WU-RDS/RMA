## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# read.csv2 is shorthand for read.csv(file, sep = ";")
sales_data <- read.csv2("/Users/dariayudaeva/Desktop/RDS/3_Teaching/2024/RMA24/L_Market_Research/beer.csv", sep = ",")
dim(sales_data)
head(sales_data)
str(sales_data)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#transform data: check wrong data types (numeric, character, factor...)
library(tidyverse)
sales_data <- sales_data |> # pipe sales data into mutate
  mutate(store = as.factor(store), # convert to factor 
         brand_id = as.factor(brand_id), # convert to factor 
         move_ounce = as.numeric(move_ounce), # convert to numeric
         price_ounce = as.numeric(price_ounce), # convert to numeric
         sale_B = as.numeric(sale_B),
         sale_C = as.numeric(sale_C),
         sale_S = as.numeric(sale_S),
         summove_ounce = as.numeric(summove_ounce),
         mean_marketshare = as.numeric(mean_marketshare),
         sharerank = as.numeric(sharerank),
         logprice_ounce = as.numeric(logprice_ounce),
         logmove_ounce = as.numeric(logmove_ounce),
         saledummy_B = as.factor(saledummy_B),
         saledummy_C = as.factor(saledummy_C),
         saledummy_S = as.factor(saledummy_S)
         )
str(sales_data)

## --------------------------------------------------------------------------------------------------------------------------------------------------------------
table(sales_data$store) #absolute frequencies
table(sales_data$brand) #absolute frequencies


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
options(scipen = 999, digits = 4) # readable numeric values
prop.table(table(sales_data$brand)) #relative frequencies


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#some examples
selected_data <- sales_data %>% 
  filter(brand %in% c("Amstel", "Budweiser", "Corona", "Guiness", "HeinekenBeer", "Miller", "Strohs"))
bud_share <- prop.table(table(selected_data$brand))
bud_share <- round(100*bud_share[names(bud_share) == "Budweiser"], digits = 1)
bud_share


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
prop.table(table(select(selected_data, brand, store)), 1) #conditional relative frequencies


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#median rating
median_rating <- quantile(selected_data$sharerank, 0.5, type = 1)
median_rating


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#percentiles
quantile(selected_data$sharerank, c(0.25,0.5,0.75), type = 1)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
percentiles <- c(0.25, 0.5, 0.75)
rating_percentiles <- selected_data |>
  group_by(store) |>
  summarize(
    percentile = percentiles,
    value = quantile(sharerank, percentiles, type = 1)) 
rating_percentiles


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#descriptive statistics
library(psych)
psych::describe(select(selected_data, move_ounce, price_ounce))


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#descriptive statistics by group
describeBy(select(selected_data, move_ounce, price_ounce), selected_data$brand, skew = FALSE, range = FALSE)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
promo_weeks <- filter(selected_data, !is.na(promoweek))


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
hist(selected_data$price_ounce)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
selected_data$price_std <- (selected_data$price_ounce - mean(selected_data$price_ounce))/sd(selected_data$price_ounce)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
hist(selected_data$price_std)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
selected_data$price_std_new <- scale(selected_data$price_ounce)

