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

png(filename="plot2.png", width=480, height=480)

with(data,plot(lgtime, Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)"))

#axis(2, at=c(0,200,400,600,800, 1000, 1200))
dev.off()