# Across the United States, how have emissions from coal combustion-related sources
# changed from 1999–2008?
# Upload a PNG file containing your plot addressing this question.

library(ggplot2)

setwd("/Users/damasceno/GitHub/Exploratory-Data-Analysis/assignment-2")

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Coal related source names 
coalSources <- SCC[grep("^Coal ", SCC$Short.Name, ignore.case=F),"SCC"]

# Filter out emission sources for all the Coal Sources
aggData <- ddply(NEI[NEI$SCC %in% coalSources,], c("year"), 
                 function(df)sum(df$Emissions, na.rm=TRUE))

# Rename column names
names(aggData) <- c('Year', 'Emissions')

# Opening Graphics device
png(filename="figure/plot4.png", width=480, height=480)

# Plot final data to plot which of the 4 sources have seen decreased emissions
ggplot(aggData, aes(x=Year,y=Emissions))+
  geom_line(colour = 'red', lwd = 5)+
  xlab('Year')+
  ylab('Total PM2.5 Emissions (tons)')+
  ggtitle('Emissions from Coal Combustion-related sources')

# Power off device
dev.off()
