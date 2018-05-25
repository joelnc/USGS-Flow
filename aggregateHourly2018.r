rm(list=ls())
library(dplyr)

## Define function to read instantaneous ts, aggregate to hourly
hourlyAg <- function(fileName) {
    ## Read in data
    data <- readRDS(paste0("USGS-Flow/rdsNew/", fileName))

    ## Set up seq
    hourSeq <- seq.POSIXt(min(data$dt), max(data$dt), by='1 hour')

    ## Use dply to group by hour, compute mean
    hourly <- data %>%
        group_by(Hourly = cut(dt, breaks=hourSeq)) %>%
        summarize(cfs_mean=mean(cfs, na.rm=TRUE))

    ## dump to df and save
    hourly2 <- data.frame(dt=as.POSIXct(hourly$Hourly),
                          cfs=hourly$cfs_mean)
    saveRDS(hourly2, paste0("USGS-Flow/rdsHourly2018/", fileName))
}

flowFiles <- list.files(path="USGS-Flow/rdsNew", pattern="rds")

system.time({
    junk <- lapply(flowFiles, hourlyAg)
})
##   user  system elapsed
## 155.47    1.20  156.78


#############################################################################
#############################################################################

## ## For now, individually call files.  Could file path /match
## ## ".rds hourly", or manually config a list for apply
hourlyFlowBetter <- hourlyAg("MC14A.rds")


saveRDS(hourlyFlow, "rdataHourly/MC14AHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC17.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC17Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC22A.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC22AHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC25.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC25Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC27.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC27Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC29A1.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC29A1Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC30A.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC30AHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC33.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC33Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC38.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC38Hourly.rds")

## ## Fourmile ##

## hourlyFlow <- hourlyAg(readRDS("rdata/MC42.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC42Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC45.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC45Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC45B.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC45BHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC47A.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC47AHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC49A.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC49AHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC50.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC50Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC51.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC51Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MC66.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MC66Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MY11B.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MY11BHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MY12B.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MY12BHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MY13.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MY13Hourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MY13A.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MY13AHourly.rds")

## hourlyFlow <- hourlyAg(readRDS("rdata/MY7B.rds"))
## saveRDS(hourlyFlow, "rdataHourly/MY7BHourly.rds")
