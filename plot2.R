## =============================================================================
##   Libraries Used
## =============================================================================
library(dplyr)  ## for filtering


## =============================================================================
##  Information Required 
## =============================================================================
fileUrl   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destZip   <- "household_power_consumption.zip"
fromDate  <- as.Date("2007-02-01")
toDate    <- as.Date("2007-02-02")


## =============================================================================
##  Download file, unzip and reading the data. 
##  Remove Zip file and table after reading.  
## =============================================================================
download.file(fileUrl, destfile = destZip, method = "curl")
unzip(destZip)
file.remove(destZip)
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")
file.remove("household_power_consumption.txt")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- filter(data, Date >= fromDate & Date <= toDate)

## Create the date time data using existing variable to save space. 
data$Time <- as.POSIXct(strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S"))

## =============================================================================
##  Creating the histogram - Plot 2
## =============================================================================
par(mfrow = c(1,1)) ## Only 1 plot
plot(data$Global_active_power ~ data$Time, type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

dev.copy(png, file = "plot2.png", height = 480, width = 480 )
dev.off()
