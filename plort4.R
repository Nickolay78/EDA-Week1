library (data.table)
library (dplyr)
filename <- "Coursera_DS_4-1.zip"
Sys.setlocale(category = "LC_ALL", locale = "USA")

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if fіle exists
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#Getting data
wrr <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")
wrr$Date<- paste (wrr$Date, wrr$Time, sep="-")
wrr$Time<-strptime (wrr$Date, format="%d/%m/%Y-%H:%M:%S")
#Making PLOT


par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(wrr,{
  plot(Time,as.numeric(as.character(Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(Time,as.numeric(as.character(Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  lines(Time,as.numeric(as.character(Sub_metering_1)))
  lines(Time,as.numeric(as.character(Sub_metering_2)),col="red")
  lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue")
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(Time,as.numeric(as.character(Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

#Copy to PNG
dev.copy (png, file="plot4.png") 
dev.off ()

