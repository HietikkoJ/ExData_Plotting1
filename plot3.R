# Set new Date class for easy data extract
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

# Read data and define columns
data <- read.table("household_power_consumption.txt", header=T, sep=";", colClasses = c("myDate", "character",rep("numeric",7)), na.strings="?")

# Take subset from data
data <- subset(data, Date=="2007-02-01" | Date=="2007-02-02")

# Start png-write
png(file = "plot3.png", width = 480, height = 480, units = "px")

# Start plotting:
plot(data$Sub_metering_1, type="l",
     axes=F, 
     ylab="Energy sub metering", 
     xlab ="",
     frame.plot=T)

# Make x-axis: 
# 1st point is index 1 and labelled as "Thu"
# 2nd point is index when date changes in "Date" column.
# We get this by changing the weekday of the "Date" to factor and then again to numeric.
# Now we check with diff() function in what point the numeric value is different with the previous row
# This row number is then the index number for 2nd point, and labelled as "Fri"
# 3rd is last index of the "Date" column and using the length() function we acquire it. Labelled as "Sat"
axis(1, at=c(1,1+which(diff(as.numeric(as.factor(weekdays(data$Date))))!=0),length(data$Date)), labels=c("Thu", "Fri", "Sat"))

# Make y-axis
axis(2, at=seq(0,30,10))

# Add other data
lines(data$Sub_metering_2, col="red")
lines(data$Sub_metering_3, col="blue")

# Add legend
legend("topright", 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), 
       lwd=c(2.5,2.5,2.5),
       col=c("black","red","blue"))


# Stop png-Write command
dev.off()



