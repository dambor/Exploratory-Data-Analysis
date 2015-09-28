# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == 06037). Which city 
# has seen greater changes over time in motor vehicle emissions?
# Upload a PNG file containing your plot addressing this question.

library(ggplot2)

setwd("/Users/damasceno/GitHub/Exploratory-Data-Analysis/assignment-2")

#NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Subsetting on baltimore city (fips=24510) and LA (fips=06037) with "on-road" Type
NEIonRoad <- NEI[(NEI$fips %in% c("24510","06037")) & (NEI$type=="ON-ROAD"), ]

# Aggregate data per year and location
aggData <- aggregate(NEIonRoad$Emissions, list(Year=NEIonRoad$year, 
                                               Location=as.factor(NEIonRoad$fips)), sum)

# Calculate the city with greater changes over time in motor vehicle emissions
totalData <- ddply(aggData,"Location",transform, Growth=c(0,(exp(diff(log(x)))-1)*100))
totalData<-as.data.frame(sapply(totalData,gsub,pattern="06037",replacement="Los Angeles"))
totalData<-as.data.frame(sapply(totalData,gsub,pattern="24510",replacement="Baltimore"))

# Opening graphics device
png(filename="figure/plot6.png", width=480, height=480)

# Plotting the comparison on both cities
ggplot(totalData, aes(Year, Growth, fill = Location)) + 
  geom_bar(position = "dodge", stat="identity") + 
  labs(y="Variation (%)") + 
  ggtitle(expression(atop("PM2.5 Emission Comparison", 
                          atop(italic("Baltimore vs Los Angeles"), ""))))
# Power off device
dev.off() 
