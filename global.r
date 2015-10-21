
# Load the data
  load("data/Cam2013.Rdata")
  load("data/Cam2012.Rdata")
  load("data/Cam2011.Rdata")
  load("data/Cam2010.Rdata")
  load("data/Cam2009.Rdata")
  load("data/Cam2008.Rdata")
  load("data/Cam2007.Rdata")
  load("data/Cam2006.Rdata")
  load("data/Cam2005.Rdata")
  load("data/Cam2004.Rdata")
  load("data/Cam2003.Rdata")
  load("data/Cam2002.Rdata")
  load("data/Cam2001.Rdata")
  load("data/Cam2000.Rdata")
  
  


# Function to plot
plotCalendar <- function(dates, values, date.form = "%Y-%m-%d") {
  
  # Grid color
  gridColor <- "#ffffff"
  
  # Find number of weeks
  dates.ordered <- dates[order(as.Date(dates, format=date.form))]
  startDate <- strptime(dates.ordered[1], format=date.form)
  endDate <- strptime(dates.ordered[length(dates.ordered)], format=date.form)
  timespan <- difftime(endDate, startDate, units="weeks")
  numweeks <- as.numeric(timespan, units="weeks") + 2
  
  # Setup blank plot
  plot(0, 0, type="n", 
       xlim=c(0, numweeks), 
       ylim=c(0, 8), asp=1, 
       xaxt='n', yaxt='n', 
       ann=FALSE, bty="n")
  
  # Draw days
  for (i in 1:length(dates)) {
    if (values[i] == 2) {
      currDate <- strptime(dates[i], date.form)
      dayofweek <- currDate$wday
      
      # Figure out what color cell should be
      diff <- difftime(currDate, startDate, units="weeks") + startDate$wday/6
      weeknum <- ceiling( as.numeric(diff, units="weeks") )
      rect(weeknum, dayofweek, (weeknum+1), (dayofweek+1), col="#07457b", border=NA)
    }
    if (values[i] == 1) {
      currDate <- strptime(dates[i], date.form)
      dayofweek <- currDate$wday
      
      # Figure out what color cell should be
      diff <- difftime(currDate, startDate, units="weeks") + startDate$wday/6
      weeknum <- ceiling( as.numeric(diff, units="weeks") )
      rect(weeknum, dayofweek, (weeknum+1), (dayofweek+1), col="#008000", border=NA)
    }
    if (values[i] == 0) {
      currDate <- strptime(dates[i], date.form)
      dayofweek <- currDate$wday
      
      # Figure out what color cell should be
      diff <- difftime(currDate, startDate, units="weeks") + startDate$wday/6
      weeknum <- ceiling( as.numeric(diff, units="weeks") )
      rect(weeknum, dayofweek, (weeknum+1), (dayofweek+1), col="#808080", border=NA)
    }
    if (values[i] == 3) {
      currDate <- strptime(dates[i], date.form)
      dayofweek <- currDate$wday
      
      # Figure out what color cell should be
      diff <- difftime(currDate, startDate, units="weeks") + startDate$wday/6
      weeknum <- ceiling( as.numeric(diff, units="weeks") )
      rect(weeknum, dayofweek, (weeknum+1), (dayofweek+1), col="#FEFEFE", border=NA)
    }
  }
  
  
  # Draw calendar grid
  for (i in 1:numweeks) {
    lines(c(i, i), c(0, 7), col=gridColor, lwd=.5)
  }
  for (j in 0:7) {
    lines(c(1, numweeks), c(j, j), col=gridColor, lwd=0.5)
  }
  
  
  # Month lines
  dateseq <- seq(startDate, endDate, by="1 month")
  for (i in 1:(length(dateseq)-1)) {
    
    lastDay <- lastDayOfMonth( format(dateseq[i], date.form) )
    diff <- difftime(lastDay, startDate, units="weeks") + startDate$wday/6
    weeknum <- ceiling( as.numeric(diff, units="weeks") )
    dayofweek <- strptime(lastDay, date.form)$wday
    lines( c( (weeknum+1), (weeknum+1) ), c(0, (dayofweek+1)), col=gridColor, lwd=3, lend=2  )
    
    if (dayofweek != 6) {
      lines(c( (weeknum+1), weeknum ), c( (dayofweek+1), (dayofweek+1)), col=gridColor, lwd=3, lend=2 )
      lines(c(weeknum, weeknum), c((dayofweek+1), 7), col=gridColor, lwd=3, lend=2)
    }
  }
  
  
  # Title
  text(0, 8, paste(startDate, "to", endDate), pos=4, cex=0.7)
  
  # Day labels
  daylabs <- c('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat')
  for (k in 1:7) {
    text(0, k-1/2, daylabs[k], cex=0.5)
  }
  
  
}


# Helper function to find the last day of month in datestring
lastDayOfMonth <- function(datestring, date.form = "%Y-%m-%d") {
  
  thedate <- strptime(datestring, date.form)
  theyear <- thedate$year + 1900
  themonth <- thedate$mon + 1
  
  themonth.posix <- as.POSIXct(paste(theyear, themonth, '1', sep='-'), format=date.form)
  month.next <- seq(themonth.posix, length=2, by='1 month')[2]
  last.day <- seq(month.next, length=2, by='-1 day')[2]
  
  return(strptime(last.day, date.form))
}