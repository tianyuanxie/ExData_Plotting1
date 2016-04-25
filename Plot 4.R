##download and unzip the dataset
setwd('C:/Courses/coursera/04 Data analysis/Assignment')
if(!file.exists('Electric power consumption.zip')) {
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 
                  destfile = 'Electric power consumption.zip')
}
unzip('Electric power consumption.zip')

##Load the needed data into R and convert Data/Time variable into data/time classes
library(data.table)
consumption <- read.table('household_power_consumption.txt', sep = ';', 
                          header = TRUE, nrows = 2075260, na.strings = '?')
consumption$Date <- as.Date(consumption$Date, format = '%d/%m/%Y')
refined1 <- consumption[consumption$Date == '2007-02-01', ]
refined2 <- consumption[consumption$Date == '2007-02-02', ]
refined <- rbind(refined1, refined2)
refined$Time <- strptime(refined$Time, format = '%H:%M:%S')
refined$Time <- strftime(refined$Time, format = '%H:%M:%S')

##Make Plot 4
x <- paste(refined$Date, refined$Time)
x <- as.POSIXct(x)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(x, refined$Global_active_power, xlab = '', 
     ylab = 'Global Active Power (kilowatts)',
     type = 'l')
plot(x, refined$Voltage, xlab = 'datatime', 
     ylab = 'Voltage', type = 'l')
plot(x, refined$Sub_metering_1, xlab = '', 
     ylab = 'Energy sub metering', type = 'l')
lines(x, refined$Sub_metering_2, type = 'l', col = 'Red')
lines(x, refined$Sub_metering_3, type = 'l', col = 'Blue')
legend('topright', lty = c(1, 1, 1), col = c('Black', 'Red', 'Blue'), bty = 'n',
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
plot(x, refined$Global_reactive_power, xlab = 'datatime', 
     ylab = 'Global_reactive_power', type = 'l')
dev.copy(png, 'Plot 4.png', width = 480, height = 480, units = 'px')
dev.off()
