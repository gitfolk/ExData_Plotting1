## ===== FUNCTION: plot2 =====
## +INPUT 
## function reads a zip file (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
## and extracts the household_power_consumption.txt file for processing for two days Feb 1-2, 2007
## +OUTPUT
## plots a line graph for Global Active Power by day and copies to a PNG in the working directory
## +ASSUMPTIONS
## depends on zip file (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
plot2<-function(){
    ##dowload zip file and extract the data
    temp <- tempfile()
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',temp)
    d <- read.table(unz(temp, 'household_power_consumption.txt'), header=TRUE, sep=';', na.strings = '?', stringsAsFactors = FALSE)
    unlink(temp)
    
    ##convert to date
    d$Date<-as.Date(d$Date,'%d/%m/%Y')
    d<-subset(d, d$Date=='2007-02-01'| d$Date=='2007-02-02')
    
    ##convert time
    d$dateTime<-as.POSIXct(paste(d$Date, d$Time))

    ## plot initialize
    ## clear screen and set dimensions
    graphics.off() 
    plot.new()    
    
    ## plot the chart
    plot(d$Global_active_power~d$dateTime, type='l', ylab='Global Active Power (kilowatts)', xlab='')
     
    ## write the chart as a png
    dev.copy(png, file='plot2.png', height=480, width=480) 
    dev.off()   
}
