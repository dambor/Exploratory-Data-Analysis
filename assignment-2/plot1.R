# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
# Upload a PNG file containing your plot addressing this question.

setwd("/Users/damasceno/GitHub/Exploratory-Data-Analysis/assignment-2")

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# summarizing by years
aggData<-with (NEI,aggregate(NEI[,'Emissions'],by=list(year), sum, na.rm=TRUE))

# Rename the column names
names(aggData) <- c('Year', 'Emissions')

# Opening the graph device
png(filename='figure/plot1.png', width=480, height=480, units='px')

# Ploting the data on histogram
plot(aggData, type="h", xlab="Year", ylab="Total PM2.5 Emmisions (1999-2008)", 
     col="red", lwd="35", xaxt="n", main="Total Emissions (tons)")

# Plot the x-axis with the year
axis(1, at=as.integer(aggData$Year), las=1)

# Turn off the graphic device
dev.off() 
