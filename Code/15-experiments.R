#-------------------------------------------------------------------#
#---------------------Install missing packages----------------------#
#-------------------------------------------------------------------#

req_pacakges <- c("ggplot2","psych","reshape2","lsr","pwr","ggstatsplot","dplyr")
req_pacakges <- req_pacakges[!req_pacakges %in% installed.packages()]
lapply(req_pacakges, install.packages)
options(scipen = 999,digits = 9)


#-------------------------------------------------------------------#
#----------------------Independent means t-test---------------------#
#-------------------------------------------------------------------#

between_data <- read.table("https://raw.githubusercontent.com/WU-RDS/RMA2024/refs/heads/main/data/ab_between_subject.csv", 
                        sep = ",", 
                        header = TRUE)
head(between_data)

# Descriptives by group
library(psych)
describeBy(between_data$WTP, between_data$Group)

# Visualization
library(tidyverse)
ggplot(between_data, aes(x = Group, y = WTP)) + 
  geom_boxplot() + 
  geom_jitter(alpha = 0.2, color = "red") +
  labs(x = "Group", y = "Willingness-to-pay (EUR)") + 
  ggtitle("Boxplot of willingness-to-pay") +
  theme_minimal() 

# Conduct t-test
t.test(WTP ~ Group, data = between_data)

# Alternatively you can use the "ggstatsplot" package
library(ggstatsplot)
ggbetweenstats(
  data = between_data,
  plot.type = "box", # Boxplot
  x = Group, 
  y = WTP ,
  type = "p", 
  effsize.type = "d", # display effect size (Cohen's d in output)
  messages = FALSE,
  bf.message = FALSE,
  mean.ci = TRUE,
  title = "Mean willingness-to-pay for different groups"
)

# ... or a regression with categorical predictor
model_between <- lm(WTP ~ Group, data = between_data)
summary(model_between)



#-------------------------------------------------------------------#
#--------------------------------ANOVA------------------------------#
#-------------------------------------------------------------------#

anova_data <- read.table("https://raw.githubusercontent.com/WU-RDS/RMA2024/refs/heads/main/data/abc_anova.csv", 
                          sep = ",", 
                          header = TRUE)

head(anova_data)
anova_data$Group <- factor(anova_data$Group, levels = c("Generic","Targeted","Dynamic")) #convert grouping variable to factor; note that "Generic" goes first = 1 level


describeBy(anova_data$WTP, anova_data$Group) #inspect data

# Plot data
ggplot(anova_data, aes(x = Group, y = WTP)) + 
  geom_boxplot() +
  geom_jitter(colour = "red", alpha = 0.1) +
  theme_minimal() +
  labs(x = "Group", y = "Average willingness-to-pay (EUR)", title = "Average willingness-to-pay by group")+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5,color = "#666666")) 


anova_result <- aov(WTP ~ Group, data = anova_data)
summary(anova_result)

oneway.test(WTP ~ Group, data = anova_data)

# Important for ANOVA: pairwise comparisons of groups
pairwise.t.test(anova_data$WTP, anova_data$Group, p.adjust.method = "bonferroni")


# Alternatively you can use the "ggstatsplot" package
ggbetweenstats(
  data = anova_data,
  x = Group,
  y = WTP,
  plot.type = "box",
  pairwise.comparisons = TRUE,
  pairwise.annotation = "p.value",
  p.adjust.method = "bonferroni",
  var.equal = FALSE,
  mean.plotting = TRUE, # whether mean for each group is to be displayed
  mean.ci = TRUE, # whether to display confidence interval for means
  mean.label.size = 2.5, # size of the label for mean
  type = "parametric", # which type of test is to be run
  k = 3, # number of decimal places for statistical results
  outlier.label.color = "darkgreen", # changing the color for the text label
  title = "Comparison of willingness-to-pay between groups",
  xlab = "Experimental group", # label for the x-axis variable
  ylab = "Willingness-to-pay", # label for the y-axis variable
  messages = FALSE,
  bf.message = FALSE
)


# ... or a regression with categorical predictor
model_anova <- lm(WTP ~ Group, data = anova_data) # since we specified the order of levels above, the first level is not alphabetical, generic (= control) comes first
summary(model_anova)

# if you want to change the level of comparison
model_anova2 <- lm(WTP ~ relevel(Group, ref = 2), data = anova_data) # to compare to targeted ads
summary(model_anova2)


#-------------------------------------------------------------------#
#-----------------------Dependent means t-test----------------------#
#-------------------------------------------------------------------#

within_data <- read.table("https://raw.githubusercontent.com/WU-RDS/RMA2024/refs/heads/main/data/ab_within_subject.csv", 
                               sep = ",", 
                               header = TRUE)

head(within_data)

psych::describe(within_data)

# Visualization; we need to convert data to long format
within_data_long <- within_data %>% pivot_longer(cols = c("before", "after")) %>% rename(Condition = name, Minutes = value)
head(within_data_long)

ggplot(within_data_long, aes(x = Condition, y = Minutes)) + 
  geom_boxplot() + 
  geom_jitter(alpha = 0.2, color = "red") +
  labs(x = "Group", y = "Time spent on site (minutes)") + 
  ggtitle("Boxplot of time spent on site") +
  theme_minimal() 

# Conduct t-test
t.test(within_data$before, within_data$after, paired = TRUE)


# Alternatively you can use the "ggstatsplot" package
ggwithinstats(
  data = within_data_long,
  x = Condition,
  y = Minutes,
  path.point = FALSE,
  path.mean = TRUE,
  sort = "descending", # ordering groups along the x-axis based on
  sort.fun = median, # values of `y` variable
  title = "Mean time spent on site for different treatments",
  messages = FALSE,
  bf.message = FALSE,
  mean.ci = TRUE,
  effsize.type = "d" # display effect size (Cohen's d in output)
)


# ... or a regression with categorical predictor
within_data$difference <- within_data$after - within_data$before

# Regression: Test if the intercept (mean difference) is different from zero
# This intercept is the mean of the differences, and its significance is tested to determine if the mean difference is different from zero
model_within <- lm(difference ~ 1, within_data)  # No predictors, only intercept
summary(model_within)



#-------------------------------------------------------------------#
#--------------------------Categorical test-------------------------#
#-------------------------------------------------------------------#

categorical_data <- read.table("https://raw.githubusercontent.com/WU-RDS/RMA2024/refs/heads/main/data/abc_categorical.csv", 
                          sep = ",", 
                          header = TRUE)
categorical_data$Conversion <- factor(categorical_data$Conversion , levels = c(0:1), labels = c("no", "yes")) #convert to factor
categorical_data$Group <- factor(categorical_data$Group, levels = c("Generic","Targeted","Dynamic")) #convert to factor
head(categorical_data)
table(categorical_data)

# Conditional relative frequencies
rel_freq_table <- as.data.frame(prop.table(table(categorical_data), 1))
rel_freq_table

# Plot proportions using ggplot
ggplot(rel_freq_table, aes(x = Group, y = Freq, fill = Conversion)) + 
  geom_col(width = .7) + 
  geom_text(aes(label = paste0(round(Freq*100,0),"%")), position = position_stack(vjust = 0.5), size = 4) + 
  ylab("Proportion of conversions") + xlab("Agent") + 
  theme_bw()


# Chi-squared test of independence
conversion_table <- table(categorical_data$Group, categorical_data$Conversion)
chisq.test(conversion_table)


# ... or using LOGISTIC regression
logistic_model <- glm(Conversion ~ Group, data = categorical_data, family = "binomial") # since we specified the order of levels above, the first level is not alphabetical, generic (= control) comes first
summary(logistic_model)
exp(coef(logistic_model))

# if you want to change the level of comparison
logistic_model2 <- glm(Conversion ~ relevel(Group, ref = 2), data = categorical_data, family = "binomial") # to compare to targeted ads
summary(logistic_model2)
exp(coef(logistic_model2))

