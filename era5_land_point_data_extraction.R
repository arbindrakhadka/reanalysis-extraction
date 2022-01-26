


##  Arbindra khadka
##arikhadka@gmail.com


# data extraction code for era5 land data
## this is one example how to extract grid elevation form geopotential height data of ERA5 Land
{rm(list=ls())
  
  setwd("D:/ERA5L/geopotential//")
  # install.packages("ncdf4")
  library(raster)
  library(ncdf4)
  ####extract data  from era5land 
  ####brick
  
  
  
  ## era 5 land downloded data
  ERA5Land= brick(paste("D:/ERA5L/geopotential.nc"))
  
  ## location point to extract the data 
  location = cbind(86.778,	27.9831)
  location2 = cbind(86.778,	26.9831)
  
  ## data extraction
  era_2m_temperature_1981  <- as.numeric(raster::extract(ERA5Land, location))/9.81
  era_2m_temperature_198  <- as.numeric(raster::extract(ERA5Land, location2))/9.81
  
  
  
  data_f= data.frame(location1 = location, location2 = location2)
  
  write.csv(data_f, "D:/ERA5L/grid_elevation.csv")
  
}
