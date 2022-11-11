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
plot(dfuse$Sub_metering_1 ~ dfuse$Timenew, 
     type = "l", ylab = "Energy sub metering", xlab = " ")
lines(dfuse$Sub_metering_2 ~ dfuse$Timenew, col = "red")
lines(dfuse$Sub_metering_3 ~ dfuse$Timenew, col = "blue")

legend("topright", lty=1, lwd=c(1,1,1), col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# save the plot into a png file
dev.copy(png, file = "plot3.png", 
         width = 480, height = 480)
dev.off() # close the device