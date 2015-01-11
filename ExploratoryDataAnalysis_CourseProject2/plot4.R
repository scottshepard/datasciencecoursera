# This is a script to produce a plot showing the total tons of emissions of PM2.5
# from coal combustion-related sources in the United States between 1999 and 2008.

# Load the plyr package for the daply function
library(plyr)

# Clear the environment and set the working directory
rm(list=ls())
DataFolder <- "~/code/datasciencecoursera/data/exdata-data-NEI_data/"
setwd(DataFolder)

# load in the emissions data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_coal <- SCC[grep("coal",SCC$Short.Name,ignore.case=T),]
NEI_coal <- NEI[NEI$SCC %in% SCC_coal$SCC,]

total_emissions_from_coal_by_year <- daply(NEI_coal,.(year),function(x) sum(x$Emissions))

# Plot the data
plot(total_emissions_from_coal_by_year,
     main="Total Tons Emissions of PM2.5 from coal in the U.S. have decreased from 1999-2008",
     ylim=c(0,750000),
     type="l",lwd=4,
     yaxt="n",ylab="Total Tons of Emissions of PM2.5",
     xaxt="n",xlab="Year"
)
points(total_emissions_from_coal_by_year,pch=16,cex=2)
axis(1,at=1:4,names(total_emissions_from_coal_by_year))
axis(2,at=c(0,2e5,4e5,6e5),c(0,"0.2 mil","0.4 mil","0.6 mil"))
text(c(1.1,2,3,3.9),total_emissions_from_coal_by_year-6e4,c("0.60 mil","0.56 mil","0.57 mil","0.36 mil"))
