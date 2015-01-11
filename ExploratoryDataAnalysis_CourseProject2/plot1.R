# This is a script to produce a plot showing the total tons of emissions of PM2.5
#  in the United States between 1999 and 2008.

# Load the plyr package for the daply function
library(plyr)

# Clear the environment and set the working directory
rm(list=ls())
DataFolder <- "~/code/datasciencecoursera/data/exdata-data-NEI_data/"
setwd(DataFolder)

# load in the emissions data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the total emissions by year
# The daply function takes a data.frame, splits it by a column, then applys a function
# over each split
total_emissions_by_year <- daply(NEI,.(year),function(x) sum(x$Emissions))

# Plot the data
plot(total_emissions_by_year,
     main="Total Tons Emissions of PM2.5 in the U.S. have decreased from 1999-2008",
     ylim=c(0,7500000),
     type="l",lwd=4,col="orange",
     yaxt="n",ylab="Total Tons of Emissions of PM2.5",
     xaxt="n",xlab="Year"
     )
points(total_emissions_by_year,pch=16,cex=2)
axis(1,at=1:4,names(total_emissions_by_year))
axis(2,at=c(0,2e6,4e6,6e6),c(0,"2 mil","4 mil","6 mil"))
text(c(1.05,2,3,3.95),total_emissions_by_year-5e5,c("7.3 mil","5.6 mil","5.5 mil","3.5 mil"))
