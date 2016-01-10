# Read the first and third column in the file 
pwConsumption <- read.table('household_power_consumption.txt', header=TRUE, sep=';', colClasses=c('character','NULL','character',rep('NULL',6)));
# load lubridate
library(lubridate);
# convert to date
pwConsumption$Date <- dmy(pwConsumption$Date);
# February 1st, 2007
feb1_2007 <- dmy('1/2/2007');
# February 2nd, 2007
feb2_2007 <- dmy('2/2/2007');
# take data only for specific dates
subsetData <- pwConsumption[pwConsumption$Date %in% c(feb1_2007,feb2_2007),];
# convert to numeric
subsetData$Global_active_power <- as.numeric(subsetData$Global_active_power);
# open png file
png(file="plot1.png", width=480, height=480);
# create histogram
hist(subsetData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(killowatts)");
# close the png file
dev.off();
