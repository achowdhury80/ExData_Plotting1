# Read the first and third column in the file 
pwConsumption <- read.table('household_power_consumption.txt', header=TRUE, sep=';', colClasses=c(rep('character',2),rep('NULL',4),rep('character',3)));
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
subsetData$Sub_metering_1 <- as.numeric(subsetData$Sub_metering_1);
subsetData$Sub_metering_2 <- as.numeric(subsetData$Sub_metering_2);
subsetData$Sub_metering_3 <- as.numeric(subsetData$Sub_metering_3);
# convert to time
subsetData$Time <- hms(subsetData$Time);
# add hour, minute, seconds to date
hour(subsetData$Date) <- hour(subsetData$Time);
minute(subsetData$Date) <- minute(subsetData$Time);
second(subsetData$Date) <- second(subsetData$Time);
# open png file
png(file="plot3.png", width=480, height=480);
# generate plot
plot(subsetData$Date, subsetData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="");
lines(subsetData$Date, subsetData$Sub_metering_2, type="l", col="red");
lines(subsetData$Date, subsetData$Sub_metering_3, type="l", col="blue");
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"));
# close the png file
dev.off();