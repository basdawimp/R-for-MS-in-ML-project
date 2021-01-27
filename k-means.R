install.packages("jpeg")
install.packages("gridExtra")

library(jpeg)
library(ggplot2)
library(grid)
require(gridExtra)

# Save your favourite image, or the one posted on Moodle as Image.jpg in your working director
image.path<-paste(getwd(),"/R/Image.jpg",sep="") #This will give you a path to your saved image
img <- readJPEG(image.path) # Read the image

# Obtain Image  dimension
imgDm <- dim(img)

# Assign RGB channels to data frame 
imgRGB <- data.frame(
  x = rep(1:imgDm[2], each = imgDm[1]),
  y = rep(imgDm[1]:1, imgDm[2]),
  R = as.vector(img[,,1]),
  G = as.vector(img[,,2]),
  B = as.vector(img[,,3])
)

# Obtain a plot of the original image
plot1<-ggplot(data = imgRGB, aes(x = x, y = y)) + geom_point(colour = rgb(imgRGB[c("R", "G", "B")])) + labs(title = "Original Image")
plot1b<-ggplot(data = imgRGB1, aes(x = x, y = y)) + geom_point(colour = rgb(imgRGB1[c("R", "G", "B")])) + labs(title = "Original Image")

# Compress the image using k-means clustering 
k <- c(3, 16, 32) # Number of clusters
kMeans1 <- kmeans(imgRGB[, c("R", "G", "B")], centers = k[1]) 
kMeans2 <- kmeans(imgRGB[, c("R", "G", "B")], centers = k[2]) 
kMeans3 <- kmeans(imgRGB[, c("R", "G", "B")], centers = k[3]) 
num.of.colours1 <- rgb(kMeans1$centers[kMeans1$cluster,])
num.of.colours2 <- rgb(kMeans2$centers[kMeans2$cluster,])
num.of.colours3 <- rgb(kMeans3$centers[kMeans3$cluster,])

# Obtain a plot of the compressed image
plot2<-ggplot(data = imgRGB, aes(x = x, y = y)) + geom_point(colour = num.of.colours1) + labs(title = paste("k-Means Clustering of", k[1], "Colours"))
plot3<-ggplot(data = imgRGB, aes(x = x, y = y)) + geom_point(colour = num.of.colours2) + labs(title = paste("k-Means Clustering of", k[2], "Colours"))
plot4<-ggplot(data = imgRGB, aes(x = x, y = y)) + geom_point(colour = num.of.colours3) + labs(title = paste("k-Means Clustering of", k[3], "Colours"))

# Plot the original and compressed image side by side
grid.arrange(plot1, plot2, nrow=2)
grid.arrange(plot1, plot3, nrow=2)
grid.arrange(plot1, plot4, nrow=2)
grid.arrange(plot1, plot2, plot3, plot4, nrow=2)
