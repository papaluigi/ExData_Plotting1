library(data.table)
library(datasets)
library(lubridate)

directory <- "Exploratory Data Analysis"
file <- "household_power_consumption"
file <- paste(directory,"/",file,".txt",sep="")

#data <- read.table(file, sep=';', header=TRUE, nrows = 10)
data <- fread(file, sep=';', header=TRUE, na.strings="?", colClasses="character")
data$Date <- as.Date(data$Date, format ="%d/%m/%Y")
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]
data <- data[,wd:=weekdays(Date)]
data <- data[,lgtime:=ymd_hms(paste(Date,Time, sep=" "))]

#print (str(data))
data$sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$sub_metering_3 <- as.numeric(data$Sub_metering_3)

png(filename="plot3.png", width=480, height=480)

with(data,plot(lgtime, Sub_metering_1, col="black", type = "l", xlab="", ylab="Energy sub metering"))
with(data,lines(lgtime, Sub_metering_2, col="red", type = "l"))
with(data,lines(lgtime, Sub_metering_3, col="blue", type = "l"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=2)

dev.off()