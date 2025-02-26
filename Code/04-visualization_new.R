## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# load and transform data
library(tidyverse)
sales_data <- read.csv2("https://raw.githubusercontent.com/WU-RDS/RMA/refs/heads/main/data/data_visualization.csv", sep = ";") %>% # pipe data into mutate
  mutate(Date = as.Date(Date), # convert to date
         Store = as.factor(Store), # convert to factor w. new labels
         Category = as.factor(Category), # convert to factor with values as labels
         Brand = as.factor(Brand)) %>%
  filter(!is.na(Sales_Amount)) 

# Check the data
head(sales_data)
table(sales_data$Category) # number of observations per category (i.e., in how many rows do we have information about category "clothes", ... etc)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# table of relative frequencies. Note that this is the count of observations (i.e., in what % of rows do we have information about category "clothes", ... etc)
table_plot_rel <- as.data.frame(prop.table(table(sales_data$Category))) 
head(table_plot_rel)

library(plyr)
table_plot_rel <- dplyr::rename(table_plot_rel, "Category" = "Var1")
head(table_plot_rel)


# create a bar chart - step by step; you don't have to create your plot step by step though - jump straight to the last step after running the first line below

# Step 1: call the function that creates the plot area
ggplot(table_plot_rel, aes(x = Category, y = Freq)) # this is the base for your plot - see that there are axes but the data is not plotted anyhow

# Step 2: add the command that tells R which form (plot) should be used
ggplot(table_plot_rel, aes(x = Category, y = Freq)) + geom_col() # now it adds columns

# Step 3: manually change axis labels for better readability
ggplot(table_plot_rel, aes(x = Category, y = Freq)) + geom_col() +
  ylab("Relative frequency") + 
  xlab("Category") 

# Step 4 (opt.): you can add the specific values of relative frequencies for better readability
ggplot(table_plot_rel, aes(x = Category, y = Freq)) + geom_col() +
  ylab("Relative frequency") + 
  xlab("Category") + 
  geom_text(aes(label = sprintf("%.0f%%", Freq * 100)), vjust = -0.2) 

# Step 5 (opt.): you can play around with the colors (bars, background) and themes of the plot
ggplot(table_plot_rel, aes(x = Category, y = Freq)) + geom_col() +
  ylab("Relative frequency") + 
  xlab("Category") + 
  geom_text(aes(label = sprintf("%.1f%%", Freq/sum(Freq) * 100)), vjust = -0.2) +
  theme_minimal() 

# Step 6 (opt.): you can rotate the labels to ensure better readability  
ggplot(table_plot_rel, aes(x = Category, y = Freq)) + geom_col() +
  ylab("Relative frequency") + 
  xlab("Category") + 
  geom_text(aes(label = sprintf("%.1f%%", Freq/sum(Freq) * 100)), vjust = -0.2) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.75)) 

# Step 7 (last one): This code has all necessary arguments specified: data, labels, plot title, etc. 
ggplot(table_plot_rel, aes(x = Category, y = Freq)) + geom_col() +
  labs(x = "Category", y = "Relative frequency", title = "Purchases by category") + 
  geom_text(aes(label = sprintf("%.1f%%", Freq/sum(Freq) * 100)), vjust = -0.2) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.75),
        plot.title = element_text(hjust = 0.5, color = "#666666")
        ) 

# If you want your plot to look great, it is a good idea to use colors:
library(colorspace)
ggplot(table_plot_rel, aes(x = Category, y = Freq)) + geom_col(aes(fill = Freq)) +
  labs(x = "Category", y = "Relative frequency", title = "Purchases by category") + 
  geom_text(aes(label = sprintf("%.1f%%", Freq/sum(Freq) * 100)), vjust = -0.2) +
  theme_minimal() +
  ylim(0, 0.5) +
  scale_fill_continuous_sequential(palette = "Blues") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.75),
        plot.title = element_text(hjust = 0.5, color = "#666666"),
        legend.title = element_blank()
        ) 

# By ordering the bars, you clearly show what category is the current leader in terms of purchases share
ggplot(table_plot_rel, aes(x = Category, y = Freq)) + geom_col(aes(x = fct_reorder(Category, Freq), fill = Freq)) +
  labs(x = "Category", y = "Relative frequency", title = "Purchases by category") + 
  geom_text(aes(label = sprintf("%.1f%%", Freq/sum(Freq) * 100)), vjust = -0.2) +
  theme_minimal() +
  ylim(0, 0.5) +
  scale_fill_continuous_sequential(palette = "Blues") +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.75),
        plot.title = element_text(hjust = 0.5, color = "#666666"),
        legend.title = element_blank()
        )


## -----------------------------------------------------------------------------------------------------------------
# visualize conditional relative frequencies
table_plot_cond_rel <- as.data.frame(prop.table(table(select(sales_data, Category, Store)), 2)) # conditional relative frequencies: purchases of categories per store
table_plot_cond_rel

ggplot(table_plot_cond_rel, aes(x = fct_reorder(Category, Freq), y = Freq)) + 
  geom_col(aes(fill = Freq)) +
      facet_wrap(~Store) +
  labs(x = "", y = "Relative frequency", title = "Distribution of sales per category per store") + 
  geom_text(aes(label = sprintf("%.0f%%", Freq * 100)), vjust = -0.2) +
  theme_minimal() +
  ylim(0, 1) +
  scale_fill_continuous_sequential(palette = "Blues") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1.1, hjust = 1),
        plot.title = element_text(hjust = 0.5,color = "#666666"),
        legend.position = "none"
        ) 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# create a histogram
sales_data |>
  filter(Store == "Store 1") %>%
  ggplot(aes(Sales_Amount)) + 
    geom_histogram(binwidth = 50, col = "white", fill = "lavenderblush3") + 
    labs(x = "Amount of sales", y = "Frequency", title = "Distribution of sales in Store 1") + 
    theme_minimal()

# add vertical reference lines
sales_data |>
  filter(Store == "Store 1") %>%
  ggplot(aes(Sales_Amount)) + 
  geom_histogram(binwidth = 50, col = "white", fill = "lavenderblush3") + 
  labs(x = "Amount of sales", y = "Frequency", title = "Distribution of sales in Store 1", subtitle = "Red vertical line = mean, green vertical line = median") + 
  geom_vline(aes(xintercept = mean(Sales_Amount)), color = "red", size = 1) +
  geom_vline(aes(xintercept = median(Sales_Amount)), color = "green", size = 1) +
  theme_minimal()


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Boxplot
ggplot(sales_data, aes(x = fct_reorder(Category, Sales_Amount), y = Sales_Amount)) +
  geom_boxplot(coef = 3) + 
  labs(x = "Category", y = "Revenue per purchase") + 
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5,color = "#666666"),
        legend.position = "none"
  ) 

# add individual data points to also see the distributions and outliers
ggplot(sales_data, aes(x = fct_reorder(Category, Sales_Amount), y = Sales_Amount)) +
  geom_jitter(colour = "red", alpha = 0.1) +
  geom_boxplot(coef = 3, alpha = 0.1) + 
  labs(x = "Category", y = "Revenue per purchase") + 
  theme_minimal() 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#bar charts with error bars
music_data$genre_dummy <- as.factor(ifelse(music_data$genre=="HipHop/Rap","HipHop & Rap","other"))
## --------------------------------------------------------------------------------------------------------------------------------------------------------------
library(Rmisc)
mean_data <- summarySE(music_data, measurevar="streams", groupvars=c("genre_dummy"))
mean_data
## --------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(mean_data,aes(x = genre_dummy, y = streams)) + 
  geom_bar(position=position_dodge(.9), colour="black", fill = "#CCCCCC", stat="identity", width = 0.65) +
  geom_errorbar(position=position_dodge(.9), width=.15, aes(ymin=streams-ci, ymax=streams+ci)) +
  theme_bw() +
  labs(x = "Genre", y = "Average number of streams", title = "Average number of streams by genre")+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5,color = "#666666")) 
## --------------------------------------------------------------------------------------------------------------------------------------------------------------
#grouped bar chart
mean_data2 <- summarySE(music_data, measurevar="streams", groupvars=c("genre_dummy","explicit"))
mean_data2
## --------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(mean_data2,aes(x = genre_dummy, y = streams, fill = explicit)) + 
  geom_bar(position=position_dodge(.9), colour="black", stat="identity") +
  geom_errorbar(position=position_dodge(.9), width=.2, aes(ymin=streams-ci, ymax=streams+ci)) +
  scale_fill_manual(values=c("#CCCCCC","#FFFFFF")) +
  theme_bw() +
  labs(x = "Genre", y = "Average number of streams", title = "Average number of streams by genre and lyric type")+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5,color = "#666666")) 


## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Scatter plot
ggplot(sales_data, aes(Sales_Amount, Customer_Age)) + 
  geom_point(shape = 1) +
  labs(x = "Genre", y = "Relative frequency") + 
  geom_smooth(method = "lm", fill = "blue", alpha = 0.1) +
  labs(x = "Amount spent", y = "Customer age", title = "Scatterplot of amount spent and customer age") + 
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5,color = "#666666")) 

#grouped scatter plot
ggplot(sales_data, aes(Sales_Amount, Customer_Age, colour = Category)) +
  geom_point(shape =1) + 
  geom_smooth(method="lm", alpha = 0.1) + 
  labs(x = "Revenue per purchase", y = "Age", title = "Scatterplot of revenue and age by product category", colour = "Category") + 
  scale_color_manual(values=c("lightblue","darkblue", "lavenderblush3", "red3", "green4", "gold2")) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5,color = "#666666")) 



## --------------------------------------------------------------------------------------------------------------------------------------------------------------
# line plot
# When building a line plot, it is especially important to understand the so-called level of aggregation. In the example below, we only work with one category. However, there are multiple observation per day;
# hence, if we want to build a line plot to show daily developments of sales in the category, we need to have a single observation per date (otherwise R tries to fit all values which does not make sense)

sales_data_clothing <- filter(sales_data, Category == 'Clothing')

# to ensure proper aggregation, we add grouping and summarize sales per date

sales_data_clothing %>% group_by(Date) %>% dplyr::summarize(total_sales = sum(Sales_Amount)) %>% 
  ggplot(., aes(x = Date, y = total_sales)) + 
  geom_line(color = "lavenderblush4") + 
  labs(x = "", y = "Total sales of clothing (EUR)", title = "Daily revenues in clothing category") +
  theme_minimal() +
  scale_y_continuous(labels = scales::label_comma()) +
  theme(plot.title = element_text(hjust = 0.5, color = "#666666")) 


# Usually it is a good idea to aggregate the data by week or month, because daily level is too granular; weekly data smooth out daily fluctuations and reveal clearer trends
library(lubridate)  
sales_clothing_weekly <- sales_data_clothing %>%
  mutate(Week = floor_date(Date, "week")) %>% filter(Week < max(Week)) %>%  
  group_by(Week) %>%
  dplyr::summarise(Weekly_Sales = sum(Sales_Amount)) 

# Plot the weekly sales trend
ggplot(sales_clothing_weekly, aes(x = Week, y = Weekly_Sales)) +
  geom_line(color = "lavenderblush4") +
  theme_minimal() +
  labs(x = "Week", y = "Total sales of clothing (EUR)", title = "Weekly revenues in clothing category") +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1.1, hjust = 1), plot.title = element_text(hjust = 0.5, color = "#666666")) 


# line plot by group
sales_data_compare <- filter(sales_data, Category %in% c('Clothing','Electronics','Toys'))
sales_data_compare <- sales_data_compare %>%
  mutate(Week = floor_date(Date, "week")) %>% filter(Week < max(Week)) %>% 
  group_by(Week, Category) %>%
  dplyr::summarise(Weekly_Sales = sum(Sales_Amount)) 

ggplot(sales_data_compare, aes(x = Week, y = Weekly_Sales, color = Category)) + 
  geom_line() + 
  labs(x = "Week", y = "Total streams", title = "Weekly number of streams by country") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5,color = "#666666")) +
  scale_y_continuous(labels = scales::label_comma()) + 
  scale_color_manual(values = c("lightblue", "red3", "green4"))


