## File to load 15 data and aggregate to average hourly flow time series
## For rainfall and modeling, I have assigned hourly values at center of
## hour (on the 30 min mark including data from 0:00-0:59) but that is
## not implemented here presently

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
    rm(hourly, hourly2, hourSeq, data)
}

flowFiles <- list.files(path="USGS-Flow/rdsNew", pattern="rds")

system.time({
    junk <- lapply(flowFiles, hourlyAg)
})
##   user  system elapsed
## 155.47    1.20  156.78

#############################################################################
## Misc test plot
mc14a <- readRDS("USGS-Flow/rdsHourly/MC14A.rds")
my13 <- readRDS("USGS-Flow/rdsHourly/MY13.rds")
my13a <- readRDS("USGS-Flow/rdsHourly/MY13A.rds")

mc14a <- mc14a %>%
    filter(dt > as.POSIXct("2018-08-15 0:00"),
           dt < as.POSIXct("2019-10-11 0:00"))

my13 <- my13 %>%
    filter(dt > as.POSIXct("2018-08-15 0:00"),
           dt < as.POSIXct("2019-10-11 0:00"))

my13a <- my13a %>%
    filter(dt > as.POSIXct("2018-08-15 0:00"),
           dt < as.POSIXct("2019-10-11 0:00"))


## View final
p14a <- plot_ly() %>%
    add_trace(data=mc14a, x=~dt, y=~cfs, type="scatter", mode="lines") %>%
    add_trace(data=my13, x=~dt, y=~cfs, type="scatter", mode="lines") %>%
    add_trace(data=my13a, x=~dt, y=~cfs, type="scatter", mode="lines")
    
p14a
