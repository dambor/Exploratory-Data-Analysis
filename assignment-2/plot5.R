# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Upload a PNG file containing your plot addressing this question.

library(ggplot2)

setwd("/Users/damasceno/GitHub/Exploratory-Data-Analysis/assignment-2")

#NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Subsetting on baltimore city (fips=24510) and "on-road" Type
NEIonRoad <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"), ]

# Agregate data per year
aggData <- aggregate(NEIonRoad$Emissions, list(Year=NEIonRoad$year), sum)
aggData$x <- aggData$x/1000

# Opening graphics device
png(filename="figure/plot5.png", width=480, height=480)

# Plotting the graphic
ggplot(aggData) + 
  geom_line(aes(y = x, x = Year), colour = 'red', lwd = 5) + 
  labs(y="PM2.5 Emissions (tons)") + 
  ggtitle(expression(atop("PM2.5 emission from  vehicle sources", 
                          atop(italic("Baltimore City"), ""))))
# Power off device
dev.off()
