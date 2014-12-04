# Set new Date class for easy data extract
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

# Read data and define columns
data <- read.table("household_power_consumption.txt", header=T, sep=";", colClasses = c("myDate", "character",rep("numeric",7)), na.strings="?")

# Take subset from data
data <- subset(data, Date=="2007-02-01" | Date=="2007-02-02")

# Start png-write
png(file = "plot1.png", width = 480, height = 480, units = "px")

# Make Histogram and  add axis with specific parameters
hist(data$Global_active_power,
     axes=F, col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

axis(side=1, at=c(0,2,4,6))
axis(2, at=seq(0,1200,200))

# Stop png-Write command
dev.off()
