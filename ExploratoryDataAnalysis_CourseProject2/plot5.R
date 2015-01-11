# This is a script to produce a plot showing the tons of emissions of PM2.5
# from vehicles in the United States between 1999 and 2008.

# Load the plyr package for the daply function
library(plyr)

# Clear the environment and set the working directory
rm(list=ls())
DataFolder <- "~/code/datasciencecoursera/data/exdata-data-NEI_data/"
setwd(DataFolder)

# load in the emissions data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_vehicles <- SCC[grep("vehicle",SCC$EI.Sector,ignore.case=T),]
NEI_vehicles <- NEI[NEI$SCC %in% SCC_vehicles$SCC,]
NEI_balt_veh <- subset(NEI_vehicles,fips==24510)

total_emissions_from_vehicles_by_year <- 
  daply(NEI_balt_veh,.(year),function(x) sum(x$Emissions))

bar <- barplot(total_emissions_from_vehicles_by_year,
               main="Emissions from vehicles have decreased every year",
               ylab="Tons of PM2.5 emissions from vehicles")
text(bar,
     total_emissions_from_vehicles_by_year-15,
     round(total_emissions_from_vehicles_by_year))
