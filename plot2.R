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
plot(dfuse$Global_active_power~dfuse$Timenew,
     ylab = "Global Active Power (Kilowatts)",
     type = "l", xlab = " ")

# save the plot into a png file
dev.copy(png, file = "plot2.png", 
         width = 480, height = 480)
dev.off() # close the device