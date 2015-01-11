#  Plot 4
library(lubridate)
library (dplyr) 
classes=c("character", "character", rep ("numeric", 7))
cs<-c(1,2,3,4,5,7,8,9)
data4<-tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=classes)[,cs])
data4$Date2<-dmy(data4$Date)
data4_subset<-filter(data4, Date2== dmy("01-02-2007") | Date2== dmy("02-02-2007"))

rm(data4)
data4_subset$DateTime<-dmy_hms(paste(data4_subset$Date, data4_subset$Time))
data4_subset<-select(data4_subset,DateTime, Global_active_power, Global_reactive_power, Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3)

png(filename="plot4.png", width = 480, height = 480, units = "px")
par(mfcol=c(2,2))
#TopLeft
xrange1 <- range(data4_subset$DateTime) 
yrange1 <- range(data4_subset$Global_active_power)
plot(xrange1, yrange1, type="n", ylab="Global Active Power (kilowatts)", xlab=" ")
lines(data4_subset$DateTime, data4_subset$Global_active_power)
#Bottom Left
xrange2 <- range(data4_subset$DateTime) 
yrange2 <- range(data4_subset$Sub_metering_1)
plot(xrange2, yrange2, type="n", ylab="Energy sub metering", xlab=" ")
lines(data4_subset$DateTime, data4_subset$Sub_metering_1, col="black")
lines(data4_subset$DateTime, data4_subset$Sub_metering_2, col="red")
lines(data4_subset$DateTime, data4_subset$Sub_metering_3, col="blue")
legend("topright", col=c("black", "blue", "red"), c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), bty="n")
#Top Right
xrange3 <- range(data4_subset$DateTime) 
yrange3 <- range(data4_subset$Voltage)
plot(xrange3, yrange3, type="n",xlab="datetime", ylab="Voltage")
lines(data4_subset$DateTime, data4_subset$Voltage)
#Bottom Right
xrange4 <- range(data4_subset$DateTime) 
yrange4 <- range(data4_subset$Global_reactive_power)
plot(xrange4, yrange4, type="n",xlab="datetime", ylab="Global_reactive_power")
lines(data4_subset$DateTime, data4_subset$Global_reactive_power)
dev.off()
rm(data4_subset)


