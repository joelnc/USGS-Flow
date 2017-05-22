rm(list=ls())

hourlyAg <- function(df) {
    hourSeq <- seq.POSIXt(min(df$dt), max(df$dt), by='1 hour')

    hourly <- df %>%
        group_by(Hourly = cut(dt, breaks=hourSeq)) %>%
        summarise_each(funs(mean=mean(., na.rm=T)))

    hourly2 <- data.frame(dt=as.POSIXct(hourly$Hourly),
                          cfs=hourly$cfs_mean)
    return(hourly2)
}


hourlyFlow <- hourlyAg(readRDS("rdata/MC27.rds"))
saveRDS(hourlyFlow, "rdata/MC27Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC14A.rds"))
saveRDS(hourlyFlow, "rdata/MC14AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC22A.rds"))
saveRDS(hourlyFlow, "rdata/MC22AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC38.rds"))
saveRDS(hourlyFlow, "rdata/MC38Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC42.rds"))
saveRDS(hourlyFlow, "rdata/MC42Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC45.rds"))
saveRDS(hourlyFlow, "rdata/MC45Hourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC47A.rds"))
saveRDS(hourlyFlow, "rdata/MC47AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC49A.rds"))
saveRDS(hourlyFlow, "rdata/MC49AHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MY7B.rds"))
saveRDS(hourlyFlow, "rdata/MY7BHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MY11B.rds"))
saveRDS(hourlyFlow, "rdata/MY11BHourly.rds")

hourlyFlow <- hourlyAg(readRDS("rdata/MC33.rds"))
saveRDS(hourlyFlow, "rdata/MC33Hourly.rds")
