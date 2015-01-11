# This is a script to produce a plot showing the total tons of emissions of PM2.5
#  in Baltimore between 1999 and 2008.

# Load the plyr package for the daply function
library(plyr)

# Clear the environment and set the working directory
rm(list=ls())
DataFolder <- "~/code/datasciencecoursera/data/exdata-data-NEI_data/"
setwd(DataFolder)

# load in the emissions data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset the NEI data to only show Baltimore data
NEI_balt <- subset(NEI,fips == 24510)

# Calculate the total emissions by year
# The daply function takes a data.frame, splits it by a column, then applys a function
# over each split
balt_emissions_by_year <- daply(NEI_balt,.(year),function(x) sum(x$Emissions))

# Plot the data
plot(balt_emissions_by_year,
     main="Total Tons Emissions of PM2.5 in Baltimore have decreased from 1999-2008",
     ylim=c(0,3500),
     type="l",lwd=4,col="purple",
     yaxt="n",ylab="Total Tons of Emissions of PM2.5",
     xaxt="n",xlab="Year"
)
points(total_emissions_by_year,pch=16,cex=2)
axis(1,at=1:4,names(total_emissions_by_year))
axis(2,at=seq(0,3000,1000),c(0,"1,000","2,000","3,000"))
text(c(1.05,2,3,3.95),balt_emissions_by_year-300,c("3,200","2,500","3,100","1,900"))