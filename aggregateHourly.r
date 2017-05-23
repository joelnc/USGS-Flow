rm(list=ls())
library(dplyr)

## Define function to read instantaneous ts, aggregate to hourly
hourlyAg <- function(df) {
    ## Set up seq
    hourSeq <- seq.POSIXt(min(df$dt), max(df$dt), by='1 hour')

    ## Use dply to group by hour, compute mean (median??)
    hourly <- df %>%
        group_by(Hourly = cut(dt, breaks=hourSeq)) %>%
        summarise_each(funs(mean=mean(., na.rm=T)))

    hourly2 <- data.frame(dt=as.POSIXct(hourly$Hourly),
                          cfs=hourly$cfs_mean)
    return(hourly2)
}

## For now, individually call files.  Could file path /match
## ".rds hourly", or manually config a list for apply
hourlyFlow <- hourlyAg(readRDS("rdata/MC14A.rds"))
saveRDS(hourlyFlow, "rdata/MC14AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC17.rds"))
saveRDS(hourlyFlow, "rdata/MC17Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC22A.rds"))
saveRDS(hourlyFlow, "rdata/MC22AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC25.rds"))
saveRDS(hourlyFlow, "rdata/MC25Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC27.rds"))
saveRDS(hourlyFlow, "rdata/MC27Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC29A1.rds"))
saveRDS(hourlyFlow, "rdata/MC29A1Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC30A.rds"))
saveRDS(hourlyFlow, "rdata/MC30AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC33.rds"))
saveRDS(hourlyFlow, "rdata/MC33Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC38.rds"))
saveRDS(hourlyFlow, "rdata/MC38Hourly.rds")

## Fourmile ##

hourlyFlow <- hourlyAg(readRDS("rdata/MC42.rds"))
saveRDS(hourlyFlow, "rdata/MC42Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC45.rds"))
saveRDS(hourlyFlow, "rdata/MC45Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC45B.rds"))
saveRDS(hourlyFlow, "rdata/MC45BHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC47A.rds"))
saveRDS(hourlyFlow, "rdata/MC47AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC49A.rds"))
saveRDS(hourlyFlow, "rdata/MC49AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC50.rds"))
saveRDS(hourlyFlow, "rdata/MC50Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC51.rds"))
saveRDS(hourlyFlow, "rdata/MC51Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC66.rds"))
saveRDS(hourlyFlow, "rdata/MC66Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MY11B.rds"))
saveRDS(hourlyFlow, "rdata/MY11BHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MY12B.rds"))
saveRDS(hourlyFlow, "rdata/MY12BHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MY13.rds"))
saveRDS(hourlyFlow, "rdata/MY13Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MY13A.rds"))
saveRDS(hourlyFlow, "rdata/MY13AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MY7B.rds"))
saveRDS(hourlyFlow, "rdata/MY7BHourly.rds")
