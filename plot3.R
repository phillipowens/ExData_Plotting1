require(dplyr)

projectdir <- "exploratory_data_analysis/week1_project/"
setwd(projectdir)

file <- "household_power_consumption.txt"

classes <- c(
  Date = "character",
  Time = "character",
  Global_active_power = "NULL",
  Global_reactive_power ="NULL",
  Voltage = "NULL",
  Global_intensity = "NULL",
  Sub_metering_1 = "numeric",
  Sub_metering_2 = "numeric",
  Sub_metering_3 = "numeric")

hholdpower <- read.table(file, sep = ";", 
    header = TRUE, na.strings = "?", nrows = 2100000,
    colClasses = classes, comment.char = "")

hholdpower <- hholdpower %>%
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  mutate(datetime = as.POSIXct(strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))) 

png(filename = "plot3.png", width = 480, height = 480)

with(hholdpower, {
     plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering")
     lines(datetime, Sub_metering_2, type = "l", col = "red")
     lines(datetime, Sub_metering_3, type = "l", col = "blue")
     legend("topright", 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            lty=c(1,1,1),
            col = c("black", "red", "blue"))
})

dev.off()