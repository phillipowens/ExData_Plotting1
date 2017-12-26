require(dplyr)

projectdir <- "exploratory_data_analysis/week1_project/"
setwd(projectdir)

file <- "household_power_consumption.txt"

hholdpower <- read.table(file, sep = ";", 
                         header = TRUE, na.strings = "?", nrows = 21)
sapply(hholdpower, class)

classes <- c(
  Date = "factor",
  Time = "NULL",
  Global_active_power = "numeric",
  Global_reactive_power ="NULL",
  Voltage = "NULL",
  Global_intensity = "NULL",
  Sub_metering_1 = "NULL",
  Sub_metering_2 = "NULL",
  Sub_metering_3 = "NULL")

hholdpower <- read.table(paste0(projectdir, file), sep = ";", 
    header = TRUE, na.strings = "?", nrows = 2100000,
    colClasses = classes, comment.char = "")

hholdpower <- hholdpower %>%
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  select(Global_active_power)

png(filename = "plot1.png", width = 480, height = 480)

with(hholdpower, hist(Global_active_power,
 main = "Global Active Power",
 xlab = "Gobal Active Power (kilowatts)",
 col = "Red"))

dev.off()