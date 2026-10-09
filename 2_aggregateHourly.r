## File to load 15 data and aggregate to average hourly flow time series
## For rainfall and modeling, I have assigned hourly values at center of
## hour (on the 30 min mark including data from 0:00-0:59) but that is
## not implemented here presently

## 2026 no changes expected.  Thhis does not pull data, merely aggregating what is on file

rm(list=ls())
library(dplyr)
library(plotly)


## Define function to read instantaneous ts, aggregate to hourly
hourlyAg <- function(fileName) {

    ## Read in data
    data <- readRDS(paste0("USGS-Flow/rdsNew/", fileName))

    ## Set up seq .... Grrr
    ## Added plus 1 sec b/c otherwise date dates '10/1/2018' will not
    ## format from factor sames as dt dates '10/1/2018 01:00'
    hourSeq <- seq.POSIXt(min(data$dt), max(data$dt), by='1 hour',
                          tz="America/New_York")+1

    ## Use dply to group by hour, compute mean
    ## Odd the grouping seems to drop the extra 1 second....
    hourly <- data %>%
        group_by(Hourly = cut(dt, breaks=hourSeq)) %>%
        summarise(cfs_mean=mean(cfs, na.rm=TRUE)) %>%
        ungroup() %>%
        as.data.frame(stringsAsFactors=FALSE)

    ## Fix factro issue
    hourly$Hourly <- as.POSIXct(hourly$Hourly, "%Y-%m-%d %H:%M", tz="America/New_York")
    
    ## dump to df and save
    hourly2 <- data.frame(dt=as.POSIXct(hourly$Hourly),
                          cfs=hourly$cfs_mean)

    ## sort
    hourly2 <- hourly2[order(hourly2$dt),]
    saveRDS(hourly2, paste0("USGS-Flow/rdsHourly/", fileName))
    print(paste("Saved:  ", fileName))
    rm(hourly, hourly2, hourSeq, data)
    gc()
}

flowFiles <- list.files(path="USGS-Flow/rdsNew", pattern="rds")

system.time({
    junk <- lapply(flowFiles, hourlyAg)
})

 ##   user  system elapsed 
 ## 270.14   11.64  386.56 


#############################################################################
## Misc test plot
mc14ah <- readRDS("USGS-Flow/rdsHourly/MC14A.rds")
my13h <- readRDS("USGS-Flow/rdsHourly/MY13.rds")
my13ah <- readRDS("USGS-Flow/rdsHourly/MY13A.rds")

my13 <- readRDS("USGS-Flow/rdsNew/MY13.rds")


## How about a basic plot? looks good!
plot(tail(my13$dt,10000), tail(my13$cfs,10000), typ='l')
lines(tail(my13h$dt,10000), tail(my13h$cfs,10000), typ='l', col="red")


mc14ah <- mc14ah %>%
    filter(dt > as.POSIXct("2018-08-15 0:00"),
           dt < as.POSIXct("2019-10-11 0:00"))

my13h <- my13h %>%
    filter(dt > as.POSIXct("2018-08-15 0:00"),
           dt < as.POSIXct("2019-10-11 0:00"))

my13ah <- my13ah %>%
    filter(dt > as.POSIXct("2018-08-15 0:00"),
           dt < as.POSIXct("2019-10-11 0:00"))


## View final
p14a <- plot_ly() %>%
    add_trace(data=mc14ah, x=~dt, y=~cfs, type="scatter", mode="lines") %>%
    add_trace(data=my13h, x=~dt, y=~cfs, type="scatter", mode="lines") %>%
    add_trace(data=my13ah, x=~dt, y=~cfs, type="scatter", mode="lines")
    
p14a
