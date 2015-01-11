# Plot 2
library(lubridate)
library (dplyr) 
classes=c("character", "character", "numeric")
data2<-tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=classes)[,1:3])
data2$Date2<-dmy(data2$Date)
data2_subset<-filter(data2, Date2== dmy("01-02-2007") | Date2== dmy("02-02-2007"))
rm(data2)
data2_subset$DateTime<-dmy_hms(paste(data2_subset$Date, data2_subset$Time))

png(filename="plot2.png", width = 480, height = 480, units = "px")
xrange <- range(data2_subset$DateTime) 
yrange <- range(data2_subset$Global_active_power)
plot(xrange, yrange, type="n", ylab="Global Active Power (kilowatts)", xlab=" ")
lines(data2_subset$DateTime, data2_subset$Global_active_power)
dev.off()

rm(data2_subset)
