##Initially, movie name data and user rates are merged.
library(openxlsx)
user_data=read.xlsx("Netflix_data.xlsx")
user_data

## Setting "0" values as "NA" and replacing NA data with the mean of each column
user_data[user_data == 0] <- NA
user_data
user_data1<- user_data
for(i in 1:ncol(user_data))  {}
for(i in 1:ncol(user_data))  {
  +   user_data1[ , i][is.na(user_data1[ , i])] <- mean(user_data1[ , i], na.rm = TRUE)
   }
> user_data1

##Getting distances
library(factoextra)
distance <- get_dist(user_data1)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

##Applying hierarchical clustering
d <- dist(user_data1, method = "euclidean")
hc1 <- hclust(d, method = "complete" )
plot(hc1, cex = 0.6, hang = -1)

kume=cutree(hc1, k=4)
kume
plot(hc1, cex = 0.6)
rect.hclust(hc5, k = 4, border = 2:5)

##Silhuette Index for the best number of clusters
library(cluster)
silh=c()
for (k in 2:6){
kume=cutree(hc1,k=k)
user_data1_sil=silhouette(kume, dist(user_data1))
silh[k-1]=mean(user_data1_sil[,3])
}
data.frame(k=2:6,silh)

##As a result, it is observed that further analysis is required, because the highest silhuette index is obtained as 0.3.. which is not sufficient (expected to be 0.7..). Additionally according to latest analysis 1 cluster dominates the others.
