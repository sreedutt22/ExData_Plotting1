plot2 <- function(){
    feb2007data <- extractData("./household_power_consumption.txt")
    png("plot2.png")
    plot(feb2007_data$datetime, feb2007_data$Global_active_power, 
            type = "l", 
            ylab = "Global Active Power (kilowatts)", xlab = "")
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