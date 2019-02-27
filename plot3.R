## ===== FUNCTION: plot3 =====
## +INPUT 
## function reads a zip file (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
## and extracts the household_power_consumption.txt file for processing for two days Feb 1-2, 2007
## +OUTPUT
## plots a line graph for Energy sub metering by day and copies to a PNG in the working directory
## +ASSUMPTIONS
## depends on zip file (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
plot3<-function(){
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
    plot(d$Sub_metering_1~d$dateTime, type='l', ylab='Energy sub metering', xlab='', col='black')
    lines(d$Sub_metering_2~d$dateTime,col='red')
    lines(d$Sub_metering_3~d$dateTime,col='blue')
    legend('topright', lty = 1, lwd = 1, legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col = c('black', 'red', 'blue'), cex=0.8)
    ## write the chart as a png
    dev.copy(png, file='plot3.png', height=480, width=480) 
    dev.off()   
}
