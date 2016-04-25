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

##Make Plot 1
hist(refined$Global_active_power, col = 'red', xlab = 'Global Active Power (kilowatts)', 
     main = 'Global Active Power')
dev.copy(png, 'Plot 1.png', width = 480, height = 480, units = 'px')
dev.off()

