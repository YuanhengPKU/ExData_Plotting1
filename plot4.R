#read data from ascci file
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#to form a new field which include date and time
datetime <- paste(mydata$Date, mydata$Time, sep = " ")

#convert it to stardand format
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

#construct a new dataframe contains 7 fields
sub_power <- data.frame(mydata$Global_active_power, mydata$Voltage, mydata$Sub_metering_1, 
                        mydata$Sub_metering_2, mydata$Sub_metering_3, mydata$Global_reactive_power, datetime)

#subtract data based on datetime field
sub_power <- subset(sub_power, datetime >= "2007-02-01" & datetime < "2007-02-03")

#png device
png("Plot4.png", width = 480, height = 480, units = "px")

#4 subplots
par(mfrow = c(2, 2))

#1st subplot
plot(as.numeric(as.character(sub_power$mydata.Global_active_power)), type="l", ylab = "Global Active Power", xlab = "", xaxt="n")
#add xscale
axis(1,labels=c("Thu", "Fri", "Sat"), at=c(1,length(sub_power$datetime)/2,length(sub_power$datetime)))

#2nd subplot
plot(as.numeric(as.character(sub_power$mydata.Voltage)), type="l", ylab = "Voltage", xlab = "datetime", xaxt="n")
#add xscale
axis(1,labels=c("Thu", "Fri", "Sat"), at=c(1,length(sub_power$datetime)/2,length(sub_power$datetime)))

#3rd subplot
with(sub_power, plot(as.numeric(as.character(mydata.Sub_metering_1)), type="n", ylab = "Energy sub metering", xlab = "", xaxt="n"))
with(sub_power, points(as.numeric(as.character(mydata.Sub_metering_1)), type="l", xlab = "", xaxt="n"))
with(sub_power, points(as.numeric(as.character(mydata.Sub_metering_2)), type="l", col = "red", xlab = "", xaxt="n"))
with(sub_power, points(as.numeric(as.character(mydata.Sub_metering_3)), type="l", col = "blue", xlab = "", xaxt="n"))
#add xscale
axis(1,labels=c("Thu", "Fri", "Sat"), at=c(1,length(sub_power$datetime)/2,length(sub_power$datetime)))
#add legend
legend("topright", pch = "_", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4th subplot
plot(as.numeric(as.character(sub_power$mydata.Global_reactive_power)), type="l", 
     ylab = "Global_reactive_power", xlab = "datetime", xaxt="n")
#add xscale
axis(1,labels=c("Thu", "Fri", "Sat"), at=c(1,length(sub_power$datetime)/2,length(sub_power$datetime)))

#close device
dev.off()

