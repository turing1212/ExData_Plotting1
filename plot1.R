# Load packages
library(data.table)
library(dplyr)

# read in data
path1 <- "./data/household_power_consumption.txt"
df <- fread(input=path1, header=TRUE, na.strings = "?")

# extract data from the dates 2007-02-01 and 2007-02-02
dfuse <- df %>% 
    filter(Date=="1/2/2007" | Date=="2/2/2007")
rm(df)

# plot the histogram
hist(dfuse$Global_active_power, 
     xlab = "Global Active Power (Kilowatts)", 
     main = "Global Active Power",
     col = "red")

# save the histogram into a png file
dev.copy(png, file = "plot1.png", 
         width = 480, height = 480)
dev.off() # close the device