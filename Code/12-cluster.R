options(scipen = 999)
set.seed(1)
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


#retail clustering: customer segmentation
cluster <- read.csv2("data/Mall_Customers.csv", sep = ",")
str(cluster)
cluster <- cluster %>% rename("Annual_Income" = "Annual.Income..k..",
                              "Spending_Score" = "Spending.Score..1.100.")


# Scale the data
cluster_scale <- scale(cluster[,3:5]) 
set.seed(123)
#get the recommended number of clusters
opt_K <- NbClust(cluster_scale, method = "kmeans", max.nc = 10)
table(opt_K$Best.nc["Number_clusters",])


kmeans_clusters <- kmeans(cluster_scale, 2) #specify the number of clusters to be created
kmeans_clusters$centers

#visualization
library(ggiraph)
library(ggiraphExtra)
centers <- data.frame(kmeans_clusters$centers)
centers$cluster <- 1:2
ggRadar(centers, aes(color = cluster), rescale = FALSE) + 
  ggtitle("Centers") +
  theme_minimal()

cluster$cluster_num <- as.factor(kmeans_clusters$cluster)
ggplot(cluster, aes(y = cluster_num, fill = Gender)) +
  geom_bar() +
  theme_minimal()
table(cluster$Gender, cluster$cluster_num)

library(factoextra)
fviz_cluster(kmeans_clusters, data = cluster_scale,
             palette = hcl.colors(2, palette = "Dynamic"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_minimal()
)


#finding similar customers
customer <- cluster %>% filter(CustomerID == 19) %>% distinct(cluster_num, .keep_all = TRUE) %>% 
  select(cluster_num)
customer
similar_customers <- cluster %>% filter(cluster_num == 1) %>% select(CustomerID, Gender) 
head(similar_customers, 20)

#compare:
random_customers <- cluster %>% filter(CustomerID == 19 | CustomerID == 20 | CustomerID == 21)

ggplot(random_customers, aes(Annual_Income, Spending_Score, color = cluster_num)) +
  geom_point() +
  geom_label(aes(label = CustomerID), hjust = "inward") +
  theme_bw()





