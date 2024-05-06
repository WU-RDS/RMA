
#-------------------------------------------------------------------#
#---------------------Install missing packages----------------------#
#-------------------------------------------------------------------#

# At the top of each script this code snippet will make sure that all required packages are installed
req_packages <- c("Hmisc", "psych", "plyr", "ggplot2", "lm.beta", "car", "ggside","ggstatsplot", "stargazer", "sandwich", "lmtest", "boot")
req_packages <- req_packages[!req_packages %in% installed.packages()]
lapply(req_packages, install.packages)

#-------------------------------------------------------------------#
#----------------------------Correlation----------------------------#
#-------------------------------------------------------------------#

#set options
options(scipen = 999, digits = 8) 
library(tidyverse)

# Create data set
library(psych)
attitude <- c(6,9,8,3,10,4,5,2,11,9,10,2)
duration <- c(10,12,12,4,12,6,8,2,18,9,17,2)
att_data <- data.frame(attitude, duration)
att_data <- att_data[order(-attitude), ]
att_data$respodentID <- c(1:12)
str(att_data)
psych::describe(att_data[, c("attitude", "duration")])

# Scatterplot
library(ggplot2)
ggplot(att_data, aes(duration, attitude)) + 
  geom_point(size = 2, shape = 1) + 
  labs(x = "Duration",y = "Attitude", size = 12) +
  theme_minimal()

# Compute covariance
# ... manually 
x <- att_data$duration
x_bar <- mean(att_data$duration)
y <- att_data$attitude
y_bar <- mean(att_data$attitude)
N <- nrow(att_data)
cov_x_y <- (sum((x - x_bar)*(y - y_bar))) / (N - 1)
cov_x_y

# ... using the cov function 
cov(att_data$duration, att_data$attitude)          

# Compute correlation coefficient
# ... manually
x_sd <- sd(att_data$duration)
y_sd <- sd(att_data$attitude)
r <- cov_x_y/(x_sd*y_sd)
r

# ... using functions
cor(att_data[, c("attitude", "duration")], method = "pearson")
cor.test(att_data$attitude, att_data$duration, alternative = "two.sided", method = "pearson", conf.level = 0.95)

# Non-parametric test
#cor.test(att_data$attitude, att_data$duration, alternative = "two.sided", method = "spearman", conf.level = 0.95, exact = FALSE)

# Spurious correlation
drownings <- c(109,102,102,98,85,95,96,98,123,94,102)
years <- c(1999:2009)
cage_movies <- c(2,2,2,3,1,1,2,3,4,1,4)
data_cage <- data.frame(years, drownings, cage_movies)
cor.test(data_cage$drownings, data_cage$cage_movies, alternative = "two.sided", method = "pearson", conf.level = 0.95)

#-------------------------------------------------------------------#
#----------------------Simple linear regression---------------------#
#-------------------------------------------------------------------#

# Load and inspect data
regression <- read.table("https://raw.githubusercontent.com/dariayudaeva/RMA2024/main/data/bud_store102.csv", 
                          sep = ",", 
                          header = TRUE) # read in data
regression <- regression %>% select(store, brand_id, brand, week, move_ounce, price_ounce, sale_B, sale_C, sale_S)
str(regression)
regression$store <- as.factor(regression$store) #convert grouping variable to factor
regression$brand_id <- as.factor(regression$brand_id) #convert grouping variable to factor
regression$brand <- as.factor(regression$brand) #convert grouping variable to factor
str(regression)

# Descriptive statistics
psych::describe(regression)

# Plot the data 
### Line Plots ###
# Sales per week 
ggplot(data = regression, aes(week, move_ounce)) + 
  geom_line(color = "forestgreen") + labs(x = "Week", y = "Sales") +
  theme_minimal()

# Price per week
ggplot(data = regression, aes(week, price_ounce)) +
  geom_line(color = "darkorange") + labs(x = "Week", y = "Price") +
  theme_minimal()


mean_price <- mean(regression$price_ounce)
mean_price
mean_sales <- mean(regression$move_ounce)
mean_sales

ggplot(regression, aes(price_ounce, move_ounce)) + 
  geom_point(size = 2, shape = 1) + labs(x = "Price ($/ounce)", y = "Sales (ounce)") + theme_minimal()

# add lines
ggplot(regression, aes(price_ounce, move_ounce)) + 
  geom_point(size = 2, shape = 1) + 
  labs(x = "Price ($/ounce)", y = "Sales (ounce)") + 
  geom_vline(size = 1, xintercept = mean_price, linetype = "dotted") + 
  geom_hline(size = 1, yintercept = mean_sales, linetype = "dotted") + 
  theme_minimal()

# add regression line
ggplot(regression, mapping = aes(price_ounce, move_ounce)) + 
  geom_point(shape = 1) +
  geom_smooth(method = "lm", color = "lavenderblush4", fill = "red", alpha = 0.1) + 
  geom_hline(yintercept = mean(regression$move_ounce), linetype = "dotted") + # mean of sales
  geom_vline(xintercept = mean(regression$price_ounce), linetype = "dotted") + # mean of price
  labs(x = "Price (ounce)", y = "Sales (ounce)") + 
  theme_minimal()


#-------------------------------------------------------------------#
#----------------------Simple linear regression---------------------#
#-------------------------------------------------------------------#

# syntax: lm(DV ~ IV, data)
# create an object that stores the results of regression estimation
sales_reg <- lm(move_ounce ~ price_ounce, data = regression) # estimate linear model
summary(sales_reg) #summary of results

# Using the model for making predictions: sales if price is set to 2 EUR
prediction <- summary(sales_reg)$coefficients[1,1] + 
  summary(sales_reg)$coefficients[2,1]*2 # the slope * 2 EUR
prediction

# Non-linear specification: Multiplicative (a.k.a log-log) model
# log-log transformation
ggplot(regression, mapping = aes(log(price_ounce), log(move_ounce))) + 
  geom_point(shape = 1) +
  geom_smooth(method = "lm", color = "lavenderblush4", fill = "red", alpha = 0.1) + 
  labs(x = "Price", y = "Sales") + 
  theme_minimal()

plot(sales_reg, 1) # residuals plot of the original regression. note the deviation from the dotted line

# Sales per week 
ggplot(data = regression, aes(week, log(move_ounce))) + 
  geom_line(color = "forestgreen") + labs(x = "Week", y = "Log-sales") +
  theme_minimal()

# Price per week
ggplot(data = regression, aes(week, log(price_ounce))) +
  geom_line(color = "darkorange") + labs(x = "Week", y = "Log-price") +
  theme_minimal()

# new regression
sales_reg2 <- lm(log(move_ounce) ~ log(price_ounce), data = regression)
summary(sales_reg2) # remember that now the interpretation changes to %!

# Confidence intervals
confint(sales_reg2)

#-------------------------------------------------------------------#
#--------------------Multiple linear regression---------------------#
#-------------------------------------------------------------------#

# Run the model
multiple_sales_reg <- lm(log(move_ounce) ~ log(price_ounce) + sale_B + sale_S, data = regression) # estimate the model
summary(multiple_sales_reg) #summary of results

# Confidence intervals
confint(multiple_sales_reg)

# visualization
ggstatsplot::ggcoefstats(x = multiple_sales_reg,
            title = "Sales prediction")

# add predicted sales to the data frame
regression$logmove_ounce_hat <- fitted(multiple_sales_reg)
# plot sales and predicted sales per week
ggplot(data = regression, aes(week, log(move_ounce))) +
  geom_vline(xintercept = regression$promoweek, colour = "grey") +
  geom_line(aes(y = log(move_ounce), colour = "logsales"), size = 1) +
  geom_line(aes(y = (logmove_ounce_hat), colour = "logsales (predicted)"), size = 1) +
  scale_color_manual(values = c("black", "red")) +
  theme_minimal()

# reporting using stargazer (https://www.jakeruss.com/cheatsheets/stargazer/)
library(stargazer)
stargazer(multiple_sales_reg, type = "text",ci = FALSE)
stargazer(multiple_sales_reg, type = "text",ci = TRUE, ci.level = 0.95, ci.separator = "; ")

# Standardized coefficients
library(lm.beta)
lm.beta(multiple_sales_reg)


# Plot of model fit (predicted vs. observed values)
regression$yhat <- predict(multiple_sales_reg)
ggplot(regression, aes(x = yhat, y = log(move_ounce))) +  
  geom_point(size=2,shape=1) +  #Use hollow circles
  scale_x_continuous(name="predicted values") +
  scale_y_continuous(name="observed values") +
  geom_abline(intercept = 0, slope = 1) +
  theme_bw()

# Added variable plots
library(car) 
avPlots(multiple_sales_reg, layout = c(1,3))


# Plot model fit for bivariate model (predicted vs. observed values)
regression$yhat_1 <- predict(sales_reg)
ggplot(regression, aes(x = yhat_1, y = log(move_ounce))) +  
  geom_point(size=2,shape=1) +  #Use hollow circles
  scale_x_continuous(name="predicted values") +
  scale_y_continuous(name="observed values") +
  geom_abline(intercept = 0, slope = 1) +
  theme_bw()


## Making predictions: log-log edition
prediction_mult <- exp(summary(multiple_sales_reg)$coefficients[1,1] + # intercept
  summary(multiple_sales_reg)$coefficients[2,1]*log(2) + 
  summary(multiple_sales_reg)$coefficients[3,1]*0.05 +
  summary(multiple_sales_reg)$coefficients[4,1]*0.10)
prediction_mult # sales volume

prediction_percentage <- summary(multiple_sales_reg)$coefficients[1,1] + # intercept
                         summary(multiple_sales_reg)$coefficients[2,1]*log(1) + 
                         summary(multiple_sales_reg)$coefficients[3,1]*0.01 +
                         summary(multiple_sales_reg)$coefficients[4,1]*0.01
prediction_percentage # percentage increase of sales volume (1% increase in each variable)


#-------------------------------------------------------------------#
#-----------------------Categorical predictors----------------------#
#-------------------------------------------------------------------#

# Two categories
# Load a new data set
categories <- read.table("https://raw.githubusercontent.com/WU-RDS/RMA2024/main/data/beer_categorical", 
                         sep = ",", 
                         header = TRUE) # read in data
categories <- categories %>% select(store, brand_id, brand, week, move_ounce, price_ounce, sale_B, sale_C, sale_S)
str(categories)
categories$store <- as.factor(categories$store) #convert grouping variable to factor
categories$brand_id <- as.factor(categories$brand_id) #convert grouping variable to factor
categories$brand <- as.factor(categories$brand) #convert grouping variable to factor
categories$week <- as.factor(categories$week) #convert grouping variable to factor
str(categories)

multiple_regression_new <- lm(move_ounce ~ price_ounce + sale_B + sale_S, data = categories) 
summary(multiple_regression_new)

multiple_regression_store <- lm(move_ounce ~ price_ounce + sale_B + sale_S + store, data = categories) 
summary(multiple_regression_store)

# More than two categories
multiple_regression_ext <- lm(move_ounce ~ price_ounce + sale_B + sale_S + store + brand, data = categories) 
summary(multiple_regression_ext) 

multiple_regression_ext <- lm(move_ounce ~ price_ounce + sale_B + sale_S + store + relevel(brand, ref = 2), data = categories) 
summary(multiple_regression_ext) 

# visualization
ggstatsplot::ggcoefstats(x = multiple_regression_ext,
            title = "Sales predicted by price, bonus buy, price reduction, store, and brand")

# reporting using stargazer
stargazer(multiple_regression_new, multiple_regression_ext, type = "text",ci = TRUE, ci.level = 0.95, ci.separator = "; ")


#-------------------------------------------------------------------#
#------------------------Interaction Effects------------------------#
#-------------------------------------------------------------------#

ggplot(categories, aes(price_ounce, move_ounce, colour = brand)) +
  geom_point() + 
  geom_smooth(method = "lm", alpha = 0.1) + 
  labs(x = "Price ($ per oz)", y = "Sales (oz)", colour = "brand") + 
  theme_minimal()


# Categorical x continuous: store x price
multiple_regression_cat_con <- lm(move_ounce ~ price_ounce + price_ounce:store, data = categories) 
summary(multiple_regression_cat_con)
# price_ounce MAIN effect tells you the effect of price for the reference group (here: ref. store - 98) that has the factor level zero. 
# In our example, it is the advertising effect for local artist. 
# This means that for store 98, increasing the price by $1 will result in -155,707.58 oz sales. 
# The interaction effect tells you by how much the effect differs for the other group (i.e., store 100) + significance. 
# Here it means that the effect for store 100 can be computed as: (-155,707.58) + (16,278.71) = -139,428.87
# This means that for store 100, increasing the price by $1 will result in -139,428.87 oz sales. 
# Since the interaction effect is significant (p < 0.05) we can conclude that price is slightly less important in store 100.

# Note that you can essentially do quasi interaction analysis by subsetting data frame (filter by brand, store, etc.). 
# Remember that the coefficient will be different in comparison to the previous one due to the change in sample (= new data)!
data_subset <- categories %>% filter(store == 100)
regression_cat_con_subset <- lm(move_ounce ~ price_ounce, data = data_subset) 
summary(regression_cat_con_subset)

# Continuous x continuous: price x discount
multiple_regression_con_con <- lm(move_ounce ~ price_ounce + sale_S + price_ounce:sale_S, data = categories)
summary(multiple_regression_con_con) 
# we can interpret the beta for price:discount as the increase in the importance (~effectiveness) 
# of pricing for a one unit increase in discount (or vice versa).




#-------------------------------------------------------------------#
#------------------------Logistic regression------------------------#
#-------------------------------------------------------------------#

# Import data
churn_data <- read.csv("https://raw.githubusercontent.com/WU-RDS/RMA2024/main/data/e_com_data.csv", 
                         sep = ",", header = T) 
head(churn_data)
str(churn_data)
# correct the variables types
churn_data$CustomerID <- as.factor(churn_data$CustomerID)
churn_data$Gender <- as.factor(churn_data$Gender)
churn_data$Tenure <- as.factor(churn_data$Tenure)
churn_data$PreferredLoginDevice <- as.factor(churn_data$PreferredLoginDevice)
churn_data$CityTier <- as.factor(churn_data$CityTier)


#Scatterplot showing the association between two variables using a linear model
ggplot(churn_data, aes(CashbackAmount, Churn)) +  
  geom_point(shape = 1) +
  geom_smooth(method = "lm") +
  theme_minimal()

#Scatterplot showing the association between two variables using a glm
ggplot(churn_data, aes(CashbackAmount, Churn)) +  
  geom_point(shape = 1) +
  geom_smooth(method = "glm", 
              method.args = list(family = "binomial"), 
              se = FALSE) +
  theme_minimal()

#Run the glm
logit_model <- glm(Churn ~ CashbackAmount, family = binomial(link = 'logit'), data = churn_data)
#Inspect model summary
summary(logit_model)
#Inspect R2
library(DescTools)
PseudoR2(logit_model, which = "all")
#Convert coefficients to odds ratios
exp(coef(logit_model))
#Confidence interval
confint(logit_model)

#Overall model test
llh_ratio <- logit_model$null.deviance-logit_model$deviance
llh_ratio # Chi Squared test statistic
library(lmtest)
lrtest(logit_model)

#Probability of churn with a cashback amount of 200
prob_200 <- exp(-(-summary(logit_model)$coefficients[1,1]-summary(logit_model)$coefficients[2,1]*200))
prob_200

#Probability of churn with a cashback amount of 201
prob_201 <- exp(-(-summary(logit_model)$coefficients[1,1]-summary(logit_model)$coefficients[2,1]*201))
prob_201

#Odds ratio
prob_201/prob_200

#Logistic model with multiple predictors
multiple_logit_model <- glm(Churn ~ OrderAmountHikeFromlastYear + DaySinceLastOrder +
                              WarehouseToHome + OrderCount + CashbackAmount, 
                            family = binomial(link = 'logit'), data = churn_data)
summary(multiple_logit_model)
lrtest(multiple_logit_model)
PseudoR2(multiple_logit_model, which = "CoxSnell")
exp(coef(multiple_logit_model))
confint(multiple_logit_model)


predict.glm(multiple_logit_model, newdata = data.frame(OrderAmountHikeFromlastYear = 5, DaySinceLastOrder = 30,
                                                   WarehouseToHome = 10, OrderCount = 10, CashbackAmount = 300), 
        type = "response") # exact interpretation
