
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
  geom_point(size = 3) + 
  labs(x = "Duration",y = "Attitude", size = 12) +
  theme_bw()

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
cor.test(att_data$attitude, att_data$duration, alternative = "two.sided", method = "spearman", conf.level = 0.95, exact = FALSE)

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

str(regression)
regression$store <- as.factor(regression$store) #convert grouping variable to factor
regression$brand_id <- as.factor(regression$brand_id) #convert grouping variable to factor
regression$saledummy_B <- as.factor(regression$saledummy_B) #convert grouping variable to factor
regression$saledummy_C <- as.factor(regression$saledummy_C) #convert grouping variable to factor
regression$saledummy_S <- as.factor(regression$saledummy_S) #convert grouping variable to factor
head(regression)

# Descriptive statistics
psych::describe(regression)

# Plot the data 
mean_price <- mean(regression$price_ounce)
mean_sales <- mean(regression$move_ounce)

scatter <- ggplot(regression, aes(price_ounce, move_ounce))
scatter + geom_point() + labs(x = "price (ounce)", y = "sales (ounce)")

scatter + geom_point() + 
  labs(x = "price (ounce)", y = "sales (ounce)") + 
  geom_vline(color = "red", size = 1, xintercept = mean_price) + 
  geom_hline(color = "red", size = 1, yintercept = mean_sales)

# ... using ggplot2
ggplot(regression, mapping = aes(price_ounce, move_ounce)) + 
  geom_point(shape = 1) +
  geom_hline(yintercept = mean(regression$move_ounce), linetype = "dotted") + # mean of sales
  geom_vline(xintercept = mean(regression$price_ounce), linetype = "dotted") + #mean of price
  labs(x = "Price (ounce)", y = "Sales (ounce)") + 
  theme_minimal()

# add regression line:
ggplot(regression, mapping = aes(price_ounce, move_ounce)) + 
  geom_point(shape = 1) +
  geom_smooth(method = "lm", color = "lavenderblush4", fill = "red", alpha = 0.1) + 
  geom_hline(yintercept = mean(regression$move_ounce), linetype = "dotted") + # mean of sales
  geom_vline(xintercept = mean(regression$price_ounce), linetype = "dotted") + # mean of price
  labs(x = "Price (ounce)", y = "Sales (ounce)") + 
  theme_minimal()

### Line Plots ###
# Sales per week 
ggplot(data = regression, aes(week, move_ounce)) + 
  geom_line(color = "forestgreen") + labs(x = "Week", y = "Sales") +
  theme_minimal()

# Price per week
ggplot(data = regression, aes(week, price_ounce)) +
  geom_line(color = "darkorange") + labs(x = "Week", y = "Price") +
  theme_minimal()


# log-log transformation
ggplot(regression, mapping = aes(log(price_ounce), log(move_ounce))) + 
  geom_point(shape = 1) +
  geom_smooth(method = "lm", color = "lavenderblush4", fill = "red", alpha = 0.1) + 
  labs(x = "Price", y = "Sales") + 
  theme_minimal()

### More Line Plots 
# Sales per week 
ggplot(data = regression, aes(week, log(move_ounce))) + 
  geom_line(color = "forestgreen") + labs(x = "Week", y = "Log-sales") +
  theme_minimal()

# Price per week
ggplot(data = regression, aes(week, log(price_ounce))) +
  geom_line(color = "darkorange") + labs(x = "Week", y = "Log-price") +
  theme_minimal()


#-------------------------------------------------------------------#
#----------------------Simple linear regression---------------------#
#-------------------------------------------------------------------#

# syntax: lm(DV ~ IV, data)
# create an object that stores the results of regression estimation
sales_reg <- lm(move_ounce ~ price_ounce, data = regression) #estimate linear model
summary(sales_reg) #summary of results

# Using the model for making predictions: sales if price is set to 2 EUR
prediction <- summary(sales_reg)$coefficients[1,1] + 
  summary(sales_reg)$coefficients[2,1]*2 # the slope * 2 EUR
prediction

sales_reg2 <- lm(log(move_ounce) ~ log(price_ounce), data = regression)
summary(sales_reg2) #remember that now the interpretation changed

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
ggcoefstats(x = multiple_sales_reg,
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

# Plot model fit for bivariate model (predicted vs. observed values)
regression$yhat_1 <- predict(sales_reg)
ggplot(regression, aes(x = yhat_1, y = log(move_ounce))) +  
  geom_point(size=2,shape=1) +  #Use hollow circles
  scale_x_continuous(name="predicted values") +
  scale_y_continuous(name="observed values") +
  geom_abline(intercept = 0, slope = 1) +
  theme_bw()

# Model comparison 
## ------------------------------------------------------------------------
non_linear_reg$pred_lin_reg <- predict(linear_reg)
non_linear_reg$pred_log_reg <- predict(log_reg)
ggplot(data = non_linear_reg) +
  geom_point(aes(x = advertising, y = sales),shape=1) + 
  geom_line(data = non_linear_reg,aes(x=advertising,y=pred_lin_reg),color="blue", size=1.05) + 
  geom_line(data = non_linear_reg,aes(x=advertising,y=exp(pred_log_reg)),color="red", size=1.05) + theme_bw()

# Making predictions
advertising <- 1000
pred <- exp(log_reg$coefficients[1] + log_reg$coefficients[2]*log(advertising))
pred

# Added variable plots
library(car) 
avPlots(multiple_sales_reg)



#-------------------------------------------------------------------#
#-----------------------Categorical predictors----------------------#
#-------------------------------------------------------------------#

# Two categories
## ------------------------------------------------------------------------
multiple_regression_bin <- lm(sales ~ adspend + airplay + starpower + country, data = regression) 
summary(multiple_regression_bin)
# More than two categories
## ------------------------------------------------------------------------
multiple_regression_ext <- lm(sales ~ adspend + airplay + starpower+ country + genre, data = regression) 
summary(multiple_regression_ext) 
## ------------------------------------------------------------------------
multiple_regression_ext <- lm(sales ~ adspend + airplay + starpower+ country + relevel(genre,ref=2), data = regression) 
summary(multiple_regression_ext) #summary of results

# visualization
## ------------------------------------------------------------------------
ggcoefstats(x = multiple_regression_ext,
            title = "Sales predicted by adspend, airplay, starpower, country, & genre")
#save plot (optional)
## ------------------------------------------------------------------------
ggsave("lm_out_ext.jpg", height = 6, width = 8.5)
# reporting using stargazer
stargazer(multiple_regression, multiple_regression_ext, type = "text",ci = TRUE, ci.level = 0.95, ci.separator = "; ")


#-------------------------------------------------------------------#
#------------------------Interaction Effects------------------------#
#-------------------------------------------------------------------#

# Categorical x continuous
## ------------------------------------------------------------------------
ggplot(regression, aes(adspend, sales, colour = as.factor(country))) +
  geom_point() + 
  geom_smooth(method="lm", alpha=0.1) + 
  labs(x = "Advertising expenditures (EUR)", y = "Number of sales", colour="country") + 
  theme_bw()
## ------------------------------------------------------------------------
multiple_regression <- lm(sales ~ adspend + airplay + starpower + country + adspend:country, data = regression) 
summary(multiple_regression)

# Continuous x continuous
## ------------------------------------------------------------------------
multiple_regression <- lm(sales ~ adspend + airplay + starpower + adspend:airplay, data = regression)
summary(multiple_regression) 

# Mean centering variables
regression$c_adspend <- regression$adspend-mean(regression$adspend)
regression$c_airplay <- regression$airplay-mean(regression$airplay)
regression$c_starpower <- regression$starpower-mean(regression$starpower)
multiple_regression <- lm(sales ~ c_adspend + c_airplay + c_starpower + c_adspend:c_airplay, data = regression)
summary(multiple_regression) 

#-------------------------------------------------------------------#
#----------------------Non-linear relationships---------------------#
#-------------------------------------------------------------------#

# Note: Multiplicative model (log-log) has been covered above 

# Quadratic model
quad_reg <- read.table("https://raw.githubusercontent.com/IMSMWU/MRDA2018/master/data/sales_quad.csv", 
                             sep = ";", 
                             header = TRUE) #read in data
head(quad_reg)
ggplot(data = quad_reg, aes(x = advertising, y = sales)) +
  geom_point(shape=1) + 
  geom_smooth(method = "lm", fill = "blue", alpha=0.1) + 
  theme_bw() + xlab("Advertising (thsd. Euro)") + ylab("Sales (million units)") 

# Linear model
linear_reg <- lm(sales ~ advertising, data = quad_reg)
summary(linear_reg)
confint(linear_reg)

plot(linear_reg,1)
plot(linear_reg,2)
shapiro.test(resid(linear_reg))

# Quadratic model
quad_mod <- lm(sales ~ advertising + I(advertising^2), data = quad_reg)
summary(quad_mod)
confint(quad_mod)
quad_reg$predict <- predict(quad_mod)
ggplot(data = quad_reg, aes(x = predict, y = sales)) + 
  geom_point(shape=1) + 
  geom_smooth(method = "lm", fill = "blue", alpha=0.1) +
  theme_bw()

plot(quad_mod,1)
plot(quad_mod,2)
shapiro.test(resid(quad_mod))

# Model comparison 
quad_reg$pred_lin_reg <- predict(linear_reg)
ggplot(data = quad_reg) +
  geom_point(aes(x = advertising, y = sales),shape=1) + 
  geom_line(data = quad_reg,aes(x=advertising,y=pred_lin_reg),color="blue", size=1.05) + 
  geom_line(data = quad_reg,aes(x=advertising,y=predict),color="red", size=1.05) + theme_bw() + xlab("Advertising (thsd. Euro)") + ylab("Sales (million units)") 

# Turning point
x_turn <- -quad_mod$coefficients[2]/(2*quad_mod$coefficients[3])
ggplot(data = quad_reg) +
  geom_point(aes(x = advertising, y = sales),shape=1) + 
  geom_line(data = quad_reg,aes(x=advertising,y=predict),color="red", size=1.05) +
  geom_vline(xintercept = x_turn,color="black") +
  geom_vline(xintercept = mean(quad_reg$advertising),color="black", linetype = "dashed", size=1.05) + theme_bw() + xlab("Advertising (thsd. Euro)") + ylab("Sales (million units)") 

# Making predictions
advertising <- 100
pred <- quad_mod$coefficients[1] + quad_mod$coefficients[2]*advertising+quad_mod$coefficients[3]*(advertising^2)
pred

# Mean centering
quad_reg$c_advertising <- quad_reg$advertising - mean(quad_reg$advertising)
quad_mod_c <- lm(sales ~ c_advertising + I(c_advertising^2), data = quad_reg)
summary(quad_mod_c)
confint(quad_mod_c)

#-------------------------------------------------------------------#
#------------------------Logistic regression------------------------#
#-------------------------------------------------------------------#

# Import data
churn_data <- read.csv("https://raw.githubusercontent.com/dariayudaeva/RMA2024/main/data/e_com_data.csv", 
                         sep = ",", header = T) 
head(churn_data)
str(churn_data)
# correct the variables types
churn_data$Customer_ID <- as.factor(churn_data$Customer_ID)
churn_data$Gender <- as.factor(churn_data$Gender)
churn_data$Annual_Income <- as.numeric(churn_data$Annual_Income)
churn_data$Total_Spend <- as.numeric(churn_data$Total_Spend)
churn_data$Average_Transaction_Amount <- as.numeric(churn_data$Average_Transaction_Amount)
churn_data$Email_Opt_In <- as.factor(churn_data$Email_Opt_In)
churn_data$Promotion_Response <- as.factor(churn_data$Promotion_Response)
#change the variable "Target_Churn" to binary type, which is 1 if a customer churned and 0 else:
churn_data$Target_Churn <- ifelse(churn_data$Target_Churn == "True", 1, 0)


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
PseudoR2(logit_model, which = "CoxSnell")
#Convert coefficients to odds ratios
exp(coef(logit_model))
#Confidence interval
confint(logit_model)

#Overall model test
llh_ratio <- logit_model$null.deviance-logit_model$deviance
llh_ratio
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
PseudoR2(multiple_logit_model, which = "CoxSnell")
exp(coef(multiple_logit_model))
confint(multiple_logit_model)

