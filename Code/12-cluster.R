options(scipen = 999)
set.seed(1)
library(tidyverse)
library(NbClust)
library(ggplot2)
library(stringr)

#visualization example
load(url("https://github.com/WU-RDS/MRDA2021/raw/main/trackfeatures.RData"))
# remove duplicates
tracks <- na.omit(tracks[!duplicated(tracks$isrc),])
robin_schulz <- tracks[str_detect(tracks$artistName, "Robin Schulz"), ]
robin_schulz$artist <- "Robin Schulz"
adele <- tracks[str_detect(tracks$artistName, "Adele"), ]
adele$artist <- "Adele"

example_tracks <- rbind(robin_schulz, adele)
ggplot(example_tracks, aes(x = energy, y = acousticness, color = artist)) +
  geom_point() +
  theme_bw()

tracks_scale <- data.frame(artist = example_tracks$artist, energy = scale(example_tracks$energy), acousticness = scale(example_tracks$acousticness))
tracks_scale <- na.omit(tracks_scale)
kmeans_clusters <- kmeans(tracks_scale[-1], 2)
kmeans_clusters$centers

tracks_scale$cluster <- as.factor(kmeans_clusters$cluster)
ggplot(tracks_scale, aes(x = energy, y = acousticness, color = cluster, shape = artist)) +
  geom_point(size = 3) +
  theme_bw()
table(tracks_scale$artist, tracks_scale$cluster)


### -------------------------- ###
### -------------------------- ###
### -------------------------- ###

# Retail clustering: Customer segmentation
cluster <- read.csv("https://raw.githubusercontent.com/WU-RDS/RMA2024/main/data/e_com_data.csv", 
                    sep = ",", header = T) 
head(cluster)
str(cluster)
# correct the variables types
cluster$CustomerID <- as.factor(cluster$CustomerID)
cluster$Gender <- as.factor(cluster$Gender)
cluster$MaritalStatus <- as.factor(cluster$MaritalStatus)
cluster$CityTier <- as.factor(cluster$CityTier)
cluster <- cluster %>% select(CustomerID, Gender, MaritalStatus, CityTier, PreferedOrderCat, 
                              Tenure, WarehouseToHome, HourSpendOnApp, NumberOfDeviceRegistered, SatisfactionScore, 
                              CouponUsed, OrderCount, DaySinceLastOrder)
cluster <- na.omit(cluster)


# Scale the data
cluster_scale <- scale(cluster[,6:13]) 
set.seed(123)
#get the recommended number of clusters
opt_K <- NbClust(cluster_scale, method = "kmeans", max.nc = 10) # max.nc can be set between 2 and (number of objects - 1)
table(opt_K$Best.nc["Number_clusters",])


kmeans_clusters <- kmeans(cluster_scale, 2) # specify the number of clusters to be created. Can try 3 too in this case
kmeans_clusters$centers

#visualization
library(ggiraph)
library(ggiraphExtra)
centers <- data.frame(kmeans_clusters$centers)
centers$cluster <- 1:2 # clusters from 1 to N, depending on N (recommended number of clusters)
ggRadar(centers, aes(color = cluster), rescale = FALSE) + 
  ggtitle("Centers") +
  theme_minimal()

cluster$cluster_num <- as.factor(kmeans_clusters$cluster)
ggplot(cluster, aes(y = cluster_num, fill = Gender)) +
  geom_bar() +
  theme_minimal()
table(cluster$Gender, cluster$cluster_num)

ggplot(cluster, aes(y = cluster_num, fill = PreferedOrderCat)) +
  geom_bar() +
  theme_minimal()
table(cluster$PreferedOrderCat, cluster$cluster_num)

library(factoextra)

fviz_cluster(kmeans_clusters, data = cluster_scale, 
             palette = hcl.colors(2, palette = "Dynamic"), # again, specify the number of clusters
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_minimal()
)

fviz_cluster(kmeans_clusters, data = cluster_scale, choose.vars = c("DaySinceLastOrder", "CouponUsed"),
             palette = hcl.colors(2, palette = "Dynamic"), # again, specify the number of clusters
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_minimal()
)


#finding similar customers
customer <- cluster %>% filter(CustomerID == 50019) %>% distinct(cluster_num, .keep_all = TRUE) %>% 
  select(cluster_num)
customer
similar_customers <- cluster %>% filter(cluster_num == 1) %>% select(CustomerID, Gender, MaritalStatus, CityTier, PreferedOrderCat) 
head(similar_customers, 20)

#compare:
random_customers <- cluster %>% filter(CustomerID == 50012 | CustomerID == 50015 | CustomerID == 50011)

ggplot(random_customers, aes(Tenure, OrderCount, color = cluster_num)) +
  geom_point() +
  geom_label(aes(label = CustomerID), hjust = "inward") +
  theme_bw()
