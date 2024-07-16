## Load packages 
library(dplyr)
library(lubridate)

## Open file
df <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

## set the corresponding classes
df <- df %>% mutate(Date = as.Date(Date, format = "%d/%m/%Y"))

df <- df %>%
  mutate(

    Time = strptime(Time, format = "%H:%M:%S"),
    
    Time = as.POSIXct(paste(as.Date(Date), format(Time, "%H:%M:%S")), format = "%Y-%m-%d %H:%M:%S")
  )

df <- df %>% mutate(across(c(Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2), as.numeric))

## filter the specified rows

df2 <- df %>% filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## Plot 1

hist(df2$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     border = "black")

## create plot1.png

png(file = "plot1.png", width = 480, height = 480)  # Adjust width and height as needed
hist(df2$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     border = "black")
dev.off()



