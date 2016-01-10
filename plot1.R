#read data from ascci file
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#to form a new field which include date and time
datetime <- paste(mydata$Date, mydata$Time, sep = " ")

#convert it to stardand format
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

#construct a new dataframe contains 2 fields, active power and datetime
gl_act_power <- data.frame(mydata$Global_active_power, datetime)

#subtract data based on datetime field
sub_power <- subset(gl_act_power, datetime >= "2007-02-01" & datetime < "2007-02-03")

#png device
png("Plot1.png", width = 480, height = 480, units = "px")

#draw the histogram graph
hist(as.numeric(as.character(sub_power$mydata.Global_active_power)), col = "red", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

#close device
dev.off()