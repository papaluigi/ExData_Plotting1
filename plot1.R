library(data.table)
library(datasets)

directory <- "Exploratory Data Analysis"
file <- "household_power_consumption"
file <- paste(directory,"/",file,".txt",sep="")

#data <- read.table(file, sep=';', header=TRUE, nrows = 10)
data <- fread(file, sep=';', header=TRUE, na.strings="?", colClasses="character")
data$Date <- as.Date(data$Date, format ="%d/%m/%Y")
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]
#print (str(data))

png(filename="plot1.png", width=480, height=480)
hist(as.numeric(data$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
axis(2, at=c(0,200,400,600,800, 1000, 1200))
dev.off()