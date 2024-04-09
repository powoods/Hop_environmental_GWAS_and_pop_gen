###Script for downloading Climate Data from World Clim and Using it to do GWAS###
##Author: Patrick Woods##
##Date: March 6, 2024##

setwd("Desktop/Projects/Wild_hops/")
install.packages("raster")

install.packages(file.choose(), repos=NULL, type='source') #Needed to download and manually install terra_1.7-71.tar
library(raster)
#need a file with coordinates

coords <- read.csv(file.choose(),header=T) #Need a .csv file with longitude and latitude coordinates for individual samples


#import all climate data
r <- getData('worldclim',var='bio', res=2.5) #Can adjust the resolution
r <- r[[c(1,12)]] #Not needed since we want all 19 climate variables
names(r) <- c('temp','precip') #Not needed since we want all 19 climate variables
clim1 <- coords$longitude
clim2 <- coords$latitude
clim1x <- c(clim1)
clim2y <- c(clim2)
df <- data.frame(x = clim1x, y = clim2y)
points <- SpatialPoints(df, proj4string = r@crs)
extrct <- extract(r, points)
cods <- cbind.data.frame(coordinates(points), extrct)

