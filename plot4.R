# Load packages
library(data.table)
library(dplyr)

# read in data
path1 <- "./data/household_power_consumption.txt"
df <- fread(input=path1, header=TRUE, na.strings = "?")

# extract data from the dates 2007-02-01 and 2007-02-02
dfuse <- df %>% 
    filter(Date=="1/2/2007" | Date=="2/2/2007") %>%
    mutate(Timenew=as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")))
rm(df)

# plot 
par(mfrow=c(2,2))

plot(dfuse$Global_active_power ~ dfuse$Timenew,
     ylab = "Global Active Power (Kilowatts)",
     type = "l", xlab = " ") # plot in the topleft

plot(dfuse$Voltage ~ dfuse$Timenew,
     ylab = "Voltage",
     type = "l", xlab = "datatime") # plot in the topright

plot(dfuse$Sub_metering_1 ~ dfuse$Timenew, 
     type = "l", ylab = "Energy sub metering", xlab = " ")
lines(dfuse$Sub_metering_2 ~ dfuse$Timenew, col = "red")
lines(dfuse$Sub_metering_3 ~ dfuse$Timenew, col = "blue")
legend("topright", lty=1, col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       bty = "n", cex = 0.8) # plot in the bottomleft

plot(dfuse$Global_reactive_power ~ dfuse$Timenew,
     type = "l", xlab = "datatime") # plot in the bottomright

# save the plot into a png file
dev.copy(png, file = "plot4.png", 
         width = 480, height = 480)
dev.off() # close the device