library(tidyverse)
library(scatterplot3d)
library(tibble)

x <- read.table("uWaveGestureLibrary_X_TRAIN.txt")
y <- read.table("uWaveGestureLibrary_Y_TRAIN.txt")
z <- read.table("uWaveGestureLibrary_Z_TRAIN.txt")

x <- t(x)
y <- t(y)
z <- t(z)

bind1 <- cbind(x[,11], y[,11], z[,11])
bind2 <- cbind(x[,20], y[,20], z[,20])
bind3 <- cbind(x[,4], y[,4], z[,4])
bind4 <- cbind(x[,5], y[,5], z[,5])
bind5 <- cbind(x[,2], y[,2], z[,2])
bind6 <- cbind(x[,1], y[,11], z[,11])
bind7 <- cbind(x[,7], y[,7], z[,7])
bind8 <- cbind(x[,6], y[,6], z[,6])


scatterplot3d(x[,11], y[,11], z[,11], main="Class 1", color = 1)
scatterplot3d(x[,20], y[,20], z[,20], main="Class 2", color = 2)
scatterplot3d(x[,4], y[,4], z[,4], main="Class 3", color = 3)
scatterplot3d(x[,5], y[,5], z[,5], main="Class 4", color = 4)
scatterplot3d(x[,2], y[,2], z[,2], main="Class 5", color = 5)
scatterplot3d(x[,1], y[,1], z[,1], main="Class 6", color = 6)
scatterplot3d(x[,7], y[,7], z[,7], main="Class 7", color = 7)
scatterplot3d(x[,6], y[,6], z[,6], main="Class 8", color = 8)



















