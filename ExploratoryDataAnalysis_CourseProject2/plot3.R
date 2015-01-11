# This is a script to produce a plot showing the total tons of emissions of PM2.5
#  in Baltimore between 1999 and 2008.

# Load the plyr package for the daply function and the ggplot2 package
library(plyr)
library(ggplot2)
library(reshape)

# Clear the environment and set the working directory
rm(list=ls())
DataFolder <- "~/code/datasciencecoursera/data/exdata-data-NEI_data/"
setwd(DataFolder)

# load in the emissions data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset the NEI data to only show Baltimore data
NEI_balt <- subset(NEI,fips == 24510)

# Split the baltimore data by type
NEI_balt_by_type <- split(NEI_balt,NEI_balt$type)
balt_emissions_by_year_and_type <- 
  lapply(NEI_balt_by_type, 
         function(x) daply(x, .(year), 
                           function(y) sum(y$Emissions)
                           )
         )
# Create a matrix for easy plotting
emissions <- data.frame(balt_emissions_by_year_and_type[1],
             balt_emissions_by_year_and_type[2],
             balt_emissions_by_year_and_type[3],
             balt_emissions_by_year_and_type[4]
             )
emissions$year <- row.names(emissions)
emissions$year <- as.numeric(emissions$year)

emissions <- melt(emissions,id="year")

ggplot(emissions, aes(x=year, y=value, color=variable)) + geom_line()
