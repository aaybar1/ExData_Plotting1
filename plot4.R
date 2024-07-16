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

## Plot 4

par(mfrow = c(2, 2))  # Set up a 2x2 layout for the plots

# plot 1
plot(df2$Time, df2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", xaxt = "n")

# Customize the x-axis to display Thu, Fri, and Sat
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))


# Plot 2: Voltage
plot(df2$Time, df2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))

# Plot 3: Energy Sub Metering
plot(df2$Time, df2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n", col = "black")

# Add lines for Sub_metering_2 and Sub_metering_3
lines(df2$Time, df2$Sub_metering_2, col = "red")
lines(df2$Time, df2$Sub_metering_3, col = "blue")

# Customize the x-axis to display Thu, Fri, and Sat
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))

# Add a legend to differentiate the lines
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

# Plot 4: Global Reactive Power
plot(df2$Time, df2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))


# create plot4.png

png(file = "plot4.png", width = 480, height = 480)  # Adjust width and height as needed
par(mfrow = c(2, 2))  # Set up a 2x2 layout for the plots

# Plot 1: Global Active Power
plot(df2$Time, df2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", xaxt = "n")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))

# Plot 2: Voltage
plot(df2$Time, df2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))

# Plot 3: Energy Sub Metering
plot(df2$Time, df2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n", col = "black")
lines(df2$Time, df2$Sub_metering_2, col = "red")
lines(df2$Time, df2$Sub_metering_3, col = "blue")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

# Plot 4: Global Reactive Power
plot(df2$Time, df2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power", xaxt = "n")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))

dev.off()