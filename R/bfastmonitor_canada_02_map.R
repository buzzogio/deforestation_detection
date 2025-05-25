###################################################
# BFAST 
# Exercise with Sentinel data 
# Apply bfastmonitor onto a raster
###################################################


## ---- 0.  First-time setup (run JUST ONCE) ----
# Uncomment the next lines the very first time you use BFAST.
# They will grab the current CRAN build (released 2024-10-22, v1.7.0)
# If you prefer the R-Forge build, change repos accordingly.
# pkgs <- c("bfast", "zoo", "forecast", "strucchangeRcpp")
# install.packages(pkgs)                               # <- CRAN binaries
# 
# install.packages("bfast",
#                   repos = "http://R-Forge.R-project.org",
#                   type  = "source")                  # <- dev build

library(bfast)
library(raster)
library(reticulate)
np <- import("numpy")

## Data reading
cube_4D <- np$load("D:/Users/PythonDevelopment/01_Projects/Forest/deforestation_detection/data/features_canada.npy")

b7  <- cube_4D[,,, 7]
b11 <- cube_4D[,,,11]

cube_3D <- (b7 - b11) / (b7 + b11) # dims [T, W, H]
rm(b7, b11)  # free memory

## Re-order to [H, W, T]
cube_3D <- aperm(cube_3D, c(2,3,1)) 

## Scale to [0, 1]
cube_min <- min(cube_3D, na.rm = TRUE)
cube_max <- max(cube_3D, na.rm = TRUE)
cube_3D <- (cube_3D - cube_min) / (cube_max - cube_min)

nbr_brick = raster::brick(cube_3D)


start_date = c(2021,8)

## bfastts requires a sequence of dates NOT in floting format
dates_canada <- seq(as.Date("2017-01-01"), by = "month", length.out = dim(nbr_brick)[3])


cell_index <- cellFromRowCol(nbr_brick, row = 38, col = 96)
nbr_ts <- as.numeric(nbr_brick[cell_index])
plot(nbr_ts, type = "l", main = "Time Series at (38, 96)")

## apply bfastmonitor on a time-series
nbr <- bfastts(as.numeric(nbr_brick[cell_index]), dates_canada, type ="irregular")
bfm <- bfastmonitor(data = nbr, start = start_date, history = c("ROC"))
plot(bfm)

## helper function to be used with the calc() function
helper_bfastmonitor <- function(x, timestamps=dates_canada) {
  start_date = c(2021,8)
  nbr <- bfastts(x, timestamps, type = c("irregular"))
  bfm <- bfastmonitor(data = nbr, start = start_date, history = c("ROC"))
  return(c(breakpoint = bfm$breakpoint, magnitude = bfm$magnitude))
}

## apply the bfastmonitor function onto one pixel in a raster brick
y = helper_bfastmonitor(nbr_brick[cell_index], dates_canada) ## helper function applied on one pixel

## apply the bfastmonitor function onto a raster brick
timeofbreak <- raster::calc(nbr_brick, fun=helper_bfastmonitor)

raster::plot(timeofbreak) ## time of break and magnitude of change
raster::plot(timeofbreak,2) ## magnitude of change