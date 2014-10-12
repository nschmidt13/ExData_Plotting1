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
plot1png <- function () {
    png(file = "./plot1.png")
    
    # Plot 1
    hist(d2$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
    
    dev.off()
}

#This funtion will get the data and create the plot in one funciton
plot1 <- function() { getData() 
                      plot1png()}