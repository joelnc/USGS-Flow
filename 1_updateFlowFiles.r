## File to pull flow data from the newest data in rdsArch through present.
## Much quicker than pulling all data, and will overwrite provisional data
## with finalized data from end of last run.

######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("dataRetrieval")

#############################################################################
## NWIS Input Stuff
QParameterCd <- "00060"
StartDate <- "2007-10-01"

## Hard code lookups for usgs vs city codes
usgsCodes <- data.frame(cityCode=c("MC14A", "MC17", "MC22A", "MC25",
                                   "MC27", "MC29A1", "MC30A", "MC33",
                                   "MC38", "MC40A", "MC42", "MC45",
                                   "MC45B", "MC47A", "MC49A", "MC5",
                                   "MC51", "MC66", "MY11B", "MY12B",
                                   "MY13", "MY13A", "MY7B", "MC50",
                                   "MC4","MY1B","MY8"),
                        usgsCode=c("0214291555", "0214295600",
                                   "02146300", "02146348",
                                   "02146381", "02146409",
                                   "0214643820", "0214645022",
                                   "02146600", "02146670",
                                   "02146700", "02146750",
                                   "0214676115", "0214678175",
                                   "02146530", "0214265828",
                                   "0214685800", "0214297160",
                                   "0212414900", "02124269",
                                   "0212430293", "0212427947",
                                   "0212430653", "0214266080",
                                   "0214266000", "0212393300", ## Last 3 are
                                   "0212466000")) ## test county site additions

## Read the list of .rds files in the .rdata folder
flowFiles <- list.files(path="USGS-Flow/rdsArch", pattern="rds")

## MY8 only
flowFiles <- flowFiles[27]
usgsCodes <- usgsCodes[27,]

## Function to load current file, nwis request new data, rbind and save
## NOTE: rdsArch is currently all data through 5/24/2018. So updateFlow
##       does fresh pull on from that date forward.
updateFlow <- function(site) {
    archQ <- readRDS(file=paste0("USGS-Flow/rdsArch/", site))
    sDate <- as.Date(tail(archQ$dt,6)[6])
    archQ <- archQ[as.Date(archQ$dt)!=sDate,]

    uCode <- usgsCodes$usgsCode[usgsCodes$cityCode==
                            substr(site, 1, nchar(site)-4)]


    recentQ <- readNWISuv(siteNumbers=uCode,
                             parameterCd=QParameterCd,
                             startDate=sDate, tz="America/New_York")
    recentQ <- recentQ[,1:6]
    names(recentQ) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

    newQ <- rbind(archQ, recentQ)
    newQ <- newQ[order(newQ$dt),]
    saveRDS(newQ, paste0("USGS-Flow/rdsNew/", site))
}

## Feed list of files to function
system.time({
    junk <- lapply(flowFiles, updateFlow)
})

## took only ~1 minute to pull ~6 days worth of data.
## took  ~ 1.5 minute to pull ~17 days worth of data.

