# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510)
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
# Upload a PNG file containing your plot addressing this question.

library(plyr)

setwd("/Users/damasceno/GitHub/Exploratory-Data-Analysis/assignment-2")

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Data aggregation for Baltimore, fips code 24510
aggDataPerYear <- ddply(NEI[NEI$fips == "24510",], c("year"), 
                        function(df)sum(df$Emissions, na.rm=TRUE))

# Opening graphics device
png(filename="figure/plot2.png", width=480, height=480)

# Ploting final aggregate data using histogram
plot(aggDataPerYear$year, aggDataPerYear$V1, type="h", col="red", lwd="35", xlab="Year", 
     ylab="PM2.5 (tons)", main="PM2.5 in Baltimore (1999-2008)")

# Power off graphic device
dev.off()
