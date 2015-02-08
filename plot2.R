plot2 <- function() {
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
  twoDaysSet[,3] <- as.numeric(as.character(twoDaysSet[,3]))
  
  datetime <- as.POSIXct(paste(as.character(twoDaysSet$Date), as.character(twoDaysSet$Time)), format="%Y-%m-%d %H:%M:%S")
  
  #open device
  png(filename="plot2.png",width=480,height=480)
  
  plot(datetime,twoDaysSet[,3],type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  #close the graphics device
  dev.off()
}