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
##  Remove Zip file  
## =============================================================================
download.file(fileUrl, destfile = destZip, method = "curl")
unzip(destZip)
file.remove(destZip)
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- filter(data, Date >= fromDate & Date <= toDate)


hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red")
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
