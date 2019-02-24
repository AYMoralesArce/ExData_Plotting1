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

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data_subset, {
  plot(Global_active_power~Datetime, type="l", 
      ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot.4.png", height=480, width=480)
## png 
##   4
dev.off()

