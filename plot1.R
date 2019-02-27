## ===== FUNCTION: plot1 =====
## +INPUT 
## function reads a zip file (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
## and extracts the household_power_consumption.txt file for processing for two days Feb 1-2, 2007
## +OUTPUT
## plots a histogram for Global Active Power and copies to a PNG in the working directory
## +ASSUMPTIONS
## depends on zip file (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
plot1<-function(){
    ##dowload zip file and extract the data
    temp <- tempfile()
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',temp)
    d <- read.table(unz(temp, 'household_power_consumption.txt'), header=TRUE, sep=';', na.strings = '?', stringsAsFactors = FALSE)
    unlink(temp)
    
    ##convert to date
    d$Date<-as.Date(d$Date,'%d/%m/%Y')
    d<-subset(d, d$Date=='2007-02-01'| d$Date=='2007-02-02')

    ## plot initialize
    ## clear screen and set dimensions
    graphics.off() 
    plot.new()    
    
    ## plot the histogram
    hist(d$Global_active_power, col='red', main="Global Active Power", xlab="Global Active Power (kilowatts)", ylim=c(0,1200))
    
    ## write the chart as a png
    dev.copy(png, file="plot1.png", height=480, width=480) 
    dev.off()   
}
