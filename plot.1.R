getwd()
setwd("/Users/ana/Desktop")
#checking the size of the data: rows * # columns * 8 bytes / 2^20
#(2,075,259 *9*8)/2^20 = 142.4967 Megabytes

data_total <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
#to find the dates I use %in% that" match returns a vector of the positions of (first) matches of its first argument in its second"
data_subset <- subset(data_total, Date %in% c("1/2/2007","2/2/2007"))
data_subset$Date <- as.Date(data_subset$Date, format="%d/%m/%Y")
hist(data_subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.copy(png, file="plot.1.png", height=480, width=480)
dev.off()
## png 
##   1