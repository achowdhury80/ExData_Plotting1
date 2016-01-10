# Read the first and third column in the file 
pwConsumption <- read.table('household_power_consumption.txt', header=TRUE, sep=';', colClasses=c(rep('character',5), 'NULL', rep('character',3)));
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
subsetData$Global_reactive_power <- as.numeric(subsetData$Global_reactive_power);
subsetData$Voltage <- as.numeric(subsetData$Voltage);
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
png(file="plot4.png", width=480, height=480);
par(mfrow=c(2,2))
# generate plots
plot(subsetData$Date, subsetData$Global_active_power, type="l", xlab="", ylab="Global Active Power");
plot(subsetData$Date, subsetData$Voltage, type="l", xlab="datetime", ylab="Voltage");
plot(subsetData$Date, subsetData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="");
lines(subsetData$Date, subsetData$Sub_metering_2, type="l", col="red");
lines(subsetData$Date, subsetData$Sub_metering_3, type="l", col="blue");
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"));
plot(subsetData$Date, subsetData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power");
# close the png file
dev.off();