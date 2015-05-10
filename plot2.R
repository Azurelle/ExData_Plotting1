####
# Individual household electric power consumption Data Set
####
# Dataset: Electric power consumption [20Mb]
# Description: Measurements of electric power consumption in one household with 
# a one-minute sampling rate over a period of almost 4 years. Different 
# electrical quantities and some sub-metering values are available.
#
####
# Variables:
#1. Date: Date in format dd/mm/yyyy
#2. Time: time in format hh:mm:ss
#3. Global_active_power: household global minute-averaged active power (in kw)
#4. Global_reactive_power: household global minute-averaged reactive power (in kw)
#5. Voltage: minute-averaged voltage (in volt)
#6. Global_intensity: household global minute-averaged current intensity (in ampere)
#7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#   -corresponds to the kitchen, containing mainly a dishwasher, an oven and a 
#    microwave (hot plates are not electric but gas powered).
#8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#   - corresponds to the laundry room, containing a washing-machine, 
#     a tumble-drier, a refrigerator and a light.
#9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
#   - corresponds to an electric water-heater and an air-conditioner.

#read in data, including column names. Change the missing values code "?" to NA
df<-read.csv("/Volumes/jssFiles/a_Courses/4 Exploratory Data Analysis/household_power_consumption.txt", 
    sep = ";",header=T, as.is=T, na.strings=c("?",""," "))

#check to see that dataset has correct number of rows and columns, and colnames
nrow(df)
ncol(df)
colnames(df)

#create a date-time variable from the character version of date and time
df$datetime<-strptime(paste(df[,1],df[,2],sep=" "),"%d/%m/%Y %H:%M:%S")

# test code on a few rows of the dataset before doing it on entire dataframe  
dftest<-df[1:20,]
dftest[dftest$datetime>="2006-12-16 17:30:00" & dftest$datetime<="2006-12-16 17:34:00",10]

#replace the big data with just the required rows - normally I'd create a new
#dataframe here, but the original dataset is too big, so I want to overwrite it 
df<-df[df$datetime>="2007-02-01 00:00:00" 
    & df$datetime<="2007-02-02 23:59:59" 
    & !is.na(df$datetime),3:10]

#generate the required plot

#Plot 2
par(mar=c(5,4,6,4), mfrow=c(1,1), cex=.7)
plot(df$datetime, df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
mtext("Plot 2", side=3, outer=T, line=-2, adj=0, font=2)

#save plot to pdf file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()