plot3 <- function() {
  #get the file locally as unzipped csv
  if(!file.exists("household_power_consumption.txt")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","data.zip")
    unzip("data.zip")
  }
  
  #load csv
  data <- read.csv("household_power_consumption.txt",sep=";",na.strings="?")
  
  #filter - keep the data only belonging to the 01/02/2007-02/02/2007 interval
  data[,1] <- as.Date(data[,1],"%d/%m/%Y")
  date1 <- as.Date("01/02/2007","%d/%m/%Y")
  date2 <- as.Date("02/02/2007","%d/%m/%Y")
  twoDaysSet <- data[(data$Date >= date1) & (data$Date <= date2),]
  
  #make the column
  twoDaysSet[,7] <- as.numeric(as.character(twoDaysSet[,7]))
  twoDaysSet[,8] <- as.numeric(as.character(twoDaysSet[,8]))
  twoDaysSet[,9] <- as.numeric(as.character(twoDaysSet[,9]))
  
  datetime <- as.POSIXct(paste(as.character(twoDaysSet$Date), as.character(twoDaysSet$Time)), format="%Y-%m-%d %H:%M:%S")
  
  #open device
  png(filename="plot3.png",width=480,height=480)
  
  plot(datetime,twoDaysSet[,7],type="l", xlab="", ylab="Energy sub metering",col="black")
  points(datetime,twoDaysSet[,8],type="l",col="red")
  points(datetime,twoDaysSet[,9],type="l",col="blue")
  
  legend("topright",lwd=2,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  #close the graphics device
  dev.off()
}