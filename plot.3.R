getwd()
setwd("/Users/ana/Desktop")
#checking the size of the data: rows * # columns * 8 bytes / 2^20
#(2,075,259 *9*8)/2^20 = 142.4967 Megabytes

data_total <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                       nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

data_subset <- subset(data_total, Date %in% c("1/2/2007","2/2/2007"))
data_subset$Date <- as.Date(data_subset$Date, format="%d/%m/%Y")

datetime <- paste(as.Date(data_subset$Date), data_subset$Time)
data_subset$Datetime <- as.POSIXct(datetime)


with(data_subset, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot.3.png", height=480, width=480)
## png 
##   3
dev.off()
