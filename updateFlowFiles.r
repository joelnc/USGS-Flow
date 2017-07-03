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
                                   "MC45B", "MC47A", "MC49A",
                                   "MC51", "MC66", "MY11B", "MY12B",
                                   "MY13", "MY13A", "MY7B"),
                        usgsCode=c("0214291555", "0214295600",
                                   "02146300", "02146348",
                                   "02146381", "02146409",
                                   "0214643820", "0214645022",
                                   "02146600", "NA",
                                   "02146700", "02146750",
                                   "0214676115", "0214678175",
                                   "02146530",
                                   "0214685800", "0214297160",
                                   "0212414900", "02124269",
                                   "0212430293", "0212427947",
                                   "0212430653"))

## Read the list of .rds files in the .rdata folder
flowFiles <- list.files(path="./rdata", pattern="rds")

## Function to load current file, nwis request new data, rbind and save
updateFlow <- function(site) {
    archQ <- readRDS(file=paste0("rdata/", site))
    sDate <- as.Date(tail(archQ$dt,6)[6])
    archQ <- archQ[as.Date(archQ$dt)!=sDate,]

    uCode <- usgsCodes$usgsCode[usgsCodes$cityCode==
                            substr(site, 1, nchar(site)-4)]


    recentQ <- readNWISuv(siteNumbers=uCode,
                             parameterCd=QParameterCd,
                             startDate=sDate, tz="America/New_York")
    recentQ <- recentQ[,3:4]
    names(recentQ) <- c("dt", "cfs")

    newQ <- rbind(archQ, recentQ)
    newQ <- newQ[order(newQ$dt),]
    saveRDS(newQ, paste0("rdata/", site))
}

## Feed list of files to function
system.time({
    junk <- lapply(flowFiles, updateFlow)
})

## took only ~1 minute to pull ~6 days worth of data.
## took  ~ 1.5 minute to pull ~17 days worth of data.








#############################################################################
## Calling these to sites individually takes half as long as passing a list
## with both
system.time({
    flow1 <- readNWISuv(siteNumbers="02146300", parameterCd=QParameterCd,
                       startDate="2015-01-01", tz="America/New_York")
})
  ##  user  system elapsed
  ## 37.74   14.75   65.77

system.time({
    flow2 <- readNWISuv(siteNumbers="02146381", parameterCd=QParameterCd,
                       startDate="2015-01-01", tz="America/New_York")
})
  ##  user  system elapsed
  ## 29.24   15.64   57.64

system.time({
    flow3 <- readNWISuv(siteNumbers=c("02146381", "02146300"),
                        parameterCd=QParameterCd,
                       startDate="2015-01-01", tz="America/New_York")
})
  ##  user  system elapsed
  ## 91.82   72.37  196.39



## flowFile1 <- flowFiles[1]
## archFlow <- readRDS(file=paste0("rdata/", flowFile1))
## sDate <- as.Date(tail(archFlow$dt,6)[6])
## archFlow <- archFlow[as.Date(archFlow$dt)!=sDate,]

## uCode <- usgsCodes$usgsCode[usgsCodes$cityCode==
##                             substr(flowFile1, 1, nchar(flowFile1)-4)]

## recentFlow <- readNWISuv(siteNumbers=uCode,
##                          parameterCd=QParameterCd,
##                          startDate=sDate, tz="America/New_York")

## recentFlow <- recentFlow[,3:4]
## names(recentFlow) <- c("dt", "cfs")

## newFlow <- rbind(archFlow, recentFlow)

## saveRDS(newFlow, paste0("rdata/", flowFile1))

## rm(list=ls())
## test <- readRDS("rdata/MC14A.rds")



updateFlow <- function(site) {
    recentFlow <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate="2015-01-01", tz="America/New_York")

MC38NWIS <- MC38NWIS[,1:6]
names(MC38NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC38_ida.Rdata")
