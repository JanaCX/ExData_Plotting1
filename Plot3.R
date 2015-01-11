# Plot 3
library(lubridate)
library (dplyr) 
classes=c("character", "character", "numeric", "numeric", "numeric")
cs<-c(1,2,7,8,9)
data3<-tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=classes)[,cs])
data3$Date2<-dmy(data3$Date)
data3_subset<-filter(data3, Date2== dmy("01-02-2007") | Date2== dmy("02-02-2007"))
rm(data3)
data3_subset$DateTime<-dmy_hms(paste(data3_subset$Date, data3_subset$Time))
data3_subset$Sub_metering_1<-as.numeric(data3_subset$Sub_metering_1)
data3_subset<-select(data3_subset,DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)

png(filename="plot3.png", width = 480, height = 480, units = "px")
xrange <- range(data3_subset$DateTime) 
yrange <- range(data3_subset$Sub_metering_1)
plot(xrange, yrange, type="n", ylab="Energy sub metering", xlab=" ")
lines(data3_subset$DateTime, data3_subset$Sub_metering_1, col="black")
lines(data3_subset$DateTime, data3_subset$Sub_metering_2, col="red")
lines(data3_subset$DateTime, data3_subset$Sub_metering_3, col="blue")
legend("topright", col=c("black", "blue", "red"), c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1))

dev.off()
rm(data3_subset)


