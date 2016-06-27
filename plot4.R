plot4 <- function(){
    feb2007data <- extractData("./household_power_consumption.txt")
    png("plot4.png")
    par(mfrow=c(2,2))
    # draw topleft one / first
    plot(feb2007_data$datetime, feb2007_data$Global_active_power, 
         ylab = "Global Active Power", xlab = "", type = "l")
    
    # draw topright one / second
    plot(feb2007_data$datetime, feb2007_data$Voltage, 
         ylab = "Voltage", xlab = "datetime", type = "l")
    
    # draw bottome left / third
    plot(feb2007_data$datetime, feb2007_data$Sub_metering_1, type="l", 
         ylab = "Energy sub metering", xlab = "", col = "black")
    lines(feb2007_data$datetime,feb2007_data$Sub_metering_2, col="red")
    lines(feb2007_data$datetime,feb2007_data$Sub_metering_3, col="blue")
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty=1, col = c("black", "red", "blue"), bty = "n")
    # draw bottom right / forth
    plot(feb2007_data$datetime, feb2007_data$Global_reactive_power, type="l", 
         xlab = "datetime", ylab = "Global_reactive_power" )
    
    dev.off()
}


extractData <- function(data_path){
    # read the raw data
    raw_data <- read.table(data_path, sep = ";",
                           header = TRUE,
                           na.strings = c("?"))
    # transform the date to proper class
    raw_data$date <- as.Date(raw_data$Date, "%d/%m/%Y")
    # subset the Feb  2007 
    feb2007_data <- subset(raw_data, date >="2007-02-01" 
                           & date <= "2007-02-02")
    feb2007_data$datetime <- as.POSIXct(
        paste(feb2007_data$Date, feb2007_data$Time)
        ,format = "%d/%m/%Y %H:%M:%S")
    feb2007_data
}