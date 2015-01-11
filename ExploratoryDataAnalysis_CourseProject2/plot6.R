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
NEI_LA_veh <- subset(NEI_vehicles,fips=="06037")

total_emissions_from_vehicles_by_year_balt <- 
  daply(NEI_balt_veh,.(year),function(x) sum(x$Emissions))

total_emissions_from_vehicles_by_year_LA <- 
  daply(NEI_LA_veh,.(year),function(x) sum(x$Emissions))

change_in_emissions <- 
  abs(c(total_emissions_from_vehicles_by_year_LA[4]-
          total_emissions_from_vehicles_by_year_LA[1],
        total_emissions_from_vehicles_by_year_balt[4]-
          total_emissions_from_vehicles_by_year_balt[1]
  ))

par(mfcol=c(1,2))
plot(total_emissions_from_vehicles_by_year_LA,
     main="Motor Vehicle Emissions in LA and Baltimore 1999-2008",
     ylim=c(0,5000),ylab="Tons of Emissions",
     type="l",lwd=4,col="yellow",
     xaxt="n",xlab="Year")
points(total_emissions_from_vehicles_by_year_LA,pch=16,cex=2)
lines(total_emissions_from_vehicles_by_year_balt,
      lwd=4,col="purple")
points(total_emissions_from_vehicles_by_year_balt,pch=16,cex=2)


bar <- barplot(change_in_emissions,
               main="Baltimore had a greater absolute change in emissions from 1999-2008",
               ylab="Tons of Emissions",names.arg=c("LA","Baltimore"),
               col=c("yellow","purple"))
text(bar,change_in_emissions-10,c("Increase of","Decrease of"))
text(bar,change_in_emissions-20,c("170 tons","260 tons"))