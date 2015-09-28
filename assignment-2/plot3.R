# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
# Upload a PNG file containing your plot addressing this question.

library(plyr)
library(ggplot2)

setwd("/Users/damasceno/GitHub/Exploratory-Data-Analysis/assignment-2")

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Total Emissions for Baltimore (fips=24510) 
totalEmission <- ddply(NEI[NEI$fips == "24510",], c("year", "type"), 
                 function(df)sum(df$Emissions, na.rm=TRUE))

# Opening graphics device
png(filename="figure/plot3.png", width=480, height=480)

# Ploting final data 
ggplot(data=totalEmission, aes(x=year, y=V1, group=type, colour=type)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("PM2.5 Emissions (tons) Per Year by Source Type")

# Power off device
dev.off()

