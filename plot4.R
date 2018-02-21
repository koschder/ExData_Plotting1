library(sqldf)
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
data <- read.csv.sql(unzip("household_power_consumption.zip"),"select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep = ";")
data <- data %>% as_tibble() %>% mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))

png("plot4.png")
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF-8")
par(mfcol = c(2,2))
# Plot 1
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
# Plot 2
plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lwd = c(1,1,1), bty = "n")
# Plot 3
plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
# Plot 4
with(data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()