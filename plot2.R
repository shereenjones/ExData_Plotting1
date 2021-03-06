## plot2.R
## Outline of Project
##      Download the zip file
##      Unzip the specific data file in question
##      Read in the data pertaining to the 2 days
##      Create the plots as shown

## Assumes you are in your working directory
install.packages("downloader")
library(downloader)

## Download the zip file if data file not already in working directory
datafile <- "household_power_consumption.txt"
if (!file.exists(datafile)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  destfile <- "household_power_consumption.zip"
  download(url, destfile, mode = "wb")
  ## unzip the file
  unzip(destfile)
}

## read in the header
header <- as.vector(read.table(datafile, sep=";", nrows=1))
## read in the data file - records for 2007-02-01 and 2007-02-02
df <- read.table(datafile, sep = ";", na.strings="?", skip=66637, nrows=2880)
h1 <- NULL
for (i in 1:9) { h1 <- c(h1, as.character(header[[i]]))}
colnames(df) <- h1  # set column names

## Plot 2
df$time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
plot(df$time, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Save plot to png
dev.copy(png, file="plot2.png", width=480, height=480, units="px")
dev.off()