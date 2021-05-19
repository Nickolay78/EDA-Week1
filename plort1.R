library (data.table)

filename <- "Coursera_DS_4-1.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if fіle exists
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

#Getting data
rrr<-fread("household_power_consumption.txt")
wrr<-subset (rrr, (Date=="1/2/2007"|Date=="2/2/2007"))
#Making hist
hist (as.numeric(wrr$Global_active_power), 
      xlab = "Global Active Power (kilowatts)",
      ylab = "Frequency", col = "red", main = "Global Active Power")
#Copy to PNG
dev.copy (png, file="plot1.png") 
dev.off ()
  