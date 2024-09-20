## File to load 15 data and aggregate to average hourly flow time series
## For rainfall and modeling, I have assigned hourly values at center of
## hour (on the 30 min mark including data from 0:00-0:59) but that is
## not implemented here presently

rm(list=ls())
library(dplyr)

## Define function to read instantaneous ts, aggregate to hourly
hourlyAg <- function(fileName) {

    ## browser()
    
    ## Read in data
    data <- readRDS(paste0("USGS-Flow/rdsNew/", fileName))

    ## Set up seq
    hourSeq <- seq.POSIXt(min(data$dt), max(data$dt), by='1 hour')

    ## Use dply to group by hour, compute mean
    hourly <- data %>%
        group_by(Hourly = cut(dt, breaks=hourSeq)) %>%
        summarize(cfs_mean=mean(cfs, na.rm=TRUE)) %>%
        as.data.frame(stringsAsFactors=FALSE)

    ## Fix factro issue
    hourly$Hourly <- as.POSIXct(hourly$Hourly, "%Y-%d-%m %H:%M", tz="America/New_York")
    
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

