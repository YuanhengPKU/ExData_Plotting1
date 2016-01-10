#read data from ascci file
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#to form a new field which include date and time
datetime <- paste(mydata$Date, mydata$Time, sep = " ")

#convert it to stardand format
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

#construct a new dataframe contains 4 fields
sub_metering_power <- data.frame(mydata$Sub_metering_1, mydata$Sub_metering_2, mydata$Sub_metering_3, datetime)

#subtract data based on datetime field
sub_power <- subset(sub_metering_power, datetime >= "2007-02-01" & datetime < "2007-02-03")

#png device
png("Plot3.png", width = 480, height = 480, units = "px")

#draw the line graph without xscale
with(sub_power, plot(as.numeric(as.character(mydata.Sub_metering_1)), type="n", 
                     ylab = "Energy sub metering", xlab = "", xaxt="n"))
with(sub_power, points(as.numeric(as.character(mydata.Sub_metering_1)), type="l", xlab = "", xaxt="n"))
with(sub_power, points(as.numeric(as.character(mydata.Sub_metering_2)), type="l", col = "red", xlab = "", xaxt="n"))
with(sub_power, points(as.numeric(as.character(mydata.Sub_metering_3)), type="l", col = "blue", xlab = "", xaxt="n"))

#add xscale
axis(1,labels=c("Thu", "Fri", "Sat"), at=c(1,length(sub_power$datetime)/2,length(sub_power$datetime)))

#add legend
legend("topright", pch = "_", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close device
dev.off()