


## Pull Data from the working directory 
## setwd("C:/Users/Sree Palepu/Documents/Coursera/Data")

odf = read.table("household_power_consumption.txt", 
sep=";", header=T,
col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power",
"Voltage","Global_intensity", "Sub_metering_1", "Sub_metering_2", 
"Sub_metering_3"), 
fill=TRUE, strip.white=TRUE)

head(odf, 10)
dim(odf)

## Set Date Values
odf$Date <- as.Date(odf$Date, format="%d/%m/%Y")

## Populate required dataset for assignment - (data 2/1/2007 and 2/2/2007) into my data frame 
mdf <- odf[(odf$Date=="2007-02-01") | (odf$Date=="2007-02-02"),]


## Check top 100 records to verify if the data is loaded properly
head(mdf, 10) 

## Check the number of records to ensure all correct data set has been pulled into mdf
dim(mdf)


## Create required variable datasets pulled from mdf
mdf$Global_active_power <- as.numeric(as.character(mdf$Global_active_power))
mdf$Global_reactive_power <- as.numeric(as.character(mdf$Global_reactive_power))
mdf$Voltage <- as.numeric(as.character(mdf$Voltage))

## add a new data column to mdf dataset by concatenating Date, Time column data into new colum
## Name the column TimeStamp or TS
##mdf2 <- transform(mdf2, ts=POSIXct(paste(mdf2$Date,mdf2$Time)), format = "%d/%m/%Y %H:%M:%S")
mdf <- transform(mdf, ts=as.POSIXct(paste(mdf$Date,mdf$Time)), format = "%d/%m/%Y %H:%M:%S")

## Create required variable datasets pulled from mdf
mdf$Sub_metering_1 <- as.numeric(as.character(mdf$Sub_metering_1))
mdf$Sub_metering_2 <- as.numeric(as.character(mdf$Sub_metering_2))
mdf$Sub_metering_3 <- as.numeric(as.character(mdf$Sub_metering_3))

## All data preperation steps are completed. Now to plotting


## Create Plot(4) with four Quadrants.

## Set the graph output to be a 2x2 matrix

par(mfrow=c(2,2))

##PLOT LeftTop
plot(mdf$ts,mdf$Global_active_power, type="l", xlab="", ylab="Global Active Power")

##PLOT RightTop
plot(mdf$ts,mdf$Voltage, type="l", xlab="datetime", ylab="Voltage")

##PLOT LeftBottom
plot(mdf$ts,mdf$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(mdf$ts,mdf$Sub_metering_2,col="red")
lines(mdf$ts,mdf$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly

##PLOT RightBottom
plot(mdf$ts,mdf$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

##OUTPUT

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()


####	cat("plot4.png has been saved in", getwd())


set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x+f - f*x + rnorm(100, sd=0.5)
#xyplot(y~x |f, layout = c(2,1))
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y~x |f, layout = c(2,1))



