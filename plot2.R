require(dplyr)

projectdir <- "exploratory_data_analysis/week1_project/"
setwd(projectdir)

file <- "household_power_consumption.txt"

classes <- c(
  Date = "character",
  Time = "character",
  Global_active_power = "numeric",
  Global_reactive_power ="NULL",
  Voltage = "NULL",
  Global_intensity = "NULL",
  Sub_metering_1 = "NULL",
  Sub_metering_2 = "NULL",
  Sub_metering_3 = "NULL")

hholdpower <- read.table(file, sep = ";", 
    header = TRUE, na.strings = "?", nrows = 2100000,
    colClasses = classes, comment.char = "")

hholdpower <- hholdpower %>%
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  mutate(datetime = as.POSIXct(strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))) %>%
  select(datetime, Global_active_power)

png(filename = "plot2.png", width = 480, height = 480)

with(hholdpower, plot(datetime, Global_active_power,
 xlab = "",    
 ylab = "Gobal Active Power (kilowatts)",
 type = "line"))

dev.off()