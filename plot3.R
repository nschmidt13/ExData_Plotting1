#This function loads the data from the working directory and adds a time/date column and filters to the correct dates
getData <- function () {
    # Create columns types vector
    colTypes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
    #Read in data from file in project folder
    elecData <- read.table ("./household_power_consumption.txt", header = TRUE, sep=";", na.strings="?", colClasses=colTypes)
    
    # Combine the data and time fields into one date/time field
    elecData$dt <- as.POSIXlt(paste(elecData$Date, elecData$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")
    
    # Set the start and end dates to be used to filter only dates to be used in plots
    startDate <- as.POSIXlt("1/2/2007", format="%d/%m/%Y")
    endDate <- as.POSIXlt("3/2/2007", format="%d/%m/%Y")
    
    # filter data based on start and end dates above and return data set
    d1 <- elecData[elecData$dt>=startDate, ]
    d1 <- d1[d1$dt<endDate, ]
    d1
}

#This function creates a png of the plot and places it in the working directory
plot3png <- function () {
    png(file = "./plot3.png")
    
    #Plot 3
    with(d1, plot(dt, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
    with(subset(d1), points(dt, Sub_metering_2, col = "red", type="l"))
    with(subset(d1), points(dt, Sub_metering_3, col = "blue", type="l"))
    legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_meterin_2","Sub_metering_3"))
    
    dev.off()
}

#This funtion will get the data and create the plot in one funciton
plot3 <- function() { getData() 
                      plot3png()}