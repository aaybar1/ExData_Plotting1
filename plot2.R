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

## Plot 2

# Create a sequence of time points for each minute
time_points <- seq.POSIXt(from = min(df2$Time), to = max(df2$Time), by = "min")

# Plot the data
plot(df2$Time, df2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")

# Customize the x-axis to display Thu, Fri, and Sat
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))

## create plot2.png

png(file = "plot2.png", width = 480, height = 480)  # Adjust width and height as needed

# Plot the data
plot(df2$Time, df2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")

# Customize the x-axis to display Thu, Fri, and Sat
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))

dev.off()