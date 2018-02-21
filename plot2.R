library(sqldf)
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
data <- read.csv.sql(unzip("household_power_consumption.zip"),"select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep = ";")
data <- data %>% as_tibble() %>% mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))

png("plot2.png")
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF-8")
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()