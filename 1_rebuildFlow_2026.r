## NEW!

## Old workflow just constant appending without accounint for Provisionals and
## thus had buried a bunch.

## Archival has some qual flag [91] values that I cannot ID, and same data fecthced
## todya does not.

## Checking Irwin 22A below, oldest data i have are 1986 and I can direct fetch that
## from new system today. That site orig. is 1961, but I may have that for stage

## worked okay for most sites.  MY13A was fussy, not sure the issue.  MC40A has 15
## year gap with no flow data, reuqired special handlig.  A few other sites had to be run
## one off but eventaully ran. Server issues?


######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("dataRetrieval")
library("dplyr")


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
                                   "0212466000"),
                        fetchId=c("USGS-0214291555", "USGS-0214295600",
                                   "USGS-02146300", "USGS-02146348",
                                   "USGS-02146381", "USGS-02146409",
                                   "USGS-0214643820", "USGS-0214645022",
                                   "USGS-02146600", "USGS-02146670",
                                   "USGS-02146700", "USGS-02146750",
                                   "USGS-0214676115", "USGS-0214678175",
                                   "USGS-02146530", "USGS-0214265828",
                                   "USGS-0214685800", "USGS-0214297160",
                                   "USGS-0212414900", "USGS-02124269",
                                   "USGS-0212430293", "USGS-0212427947",
                                   "USGS-0212430653", "USGS-0214266080",
                                   "USGS-0214266000", "USGS-0212393300", ## Last 3 are
                                   "USGS-0212466000")
                        ) ## test county site additions


## ## 8 year calls are to big or other problem
## mc25_Arch <- readRDS("USGS-Flow/rdsNew/MC25.rds")

## ## Mc22A Irwin since '62? My data starts at '86
## mc22a <- readRDS("USGS-Flow/rdsNew/MC22A.rds")
## sDate <- as.Date(mc22a$dt[1])
## eDate <- sDate+365

## recentP <- read_waterdata_continuous(
##     monitoring_location_id="USGS-02146300",
##     parameter_code=QParameterCd,
##     time=c(sDate, eDate),
##     ## time=paste0(as.Date(sDate),"T00:00:00Z/..")
## )
## ## and yes that fetches.  So it seems I can get oldest data I have via this approach
## head(recentP)

## Yup, 2018 to present is bad request

## time=c(sDate, eDate), with eDate as +365 works, so need to chunk out 


## Read the list of .rds files in the .rdata folder
flowFiles <- list.files(path="USGS-Flow/rdsNew", pattern="rds")
QParameterCd <- "00060"


rebuildOnce <- function(site) {

    ## Read file. Just need the sDate 
    archQ <- readRDS(paste0("USGS-Flow/rdsNew/", site))
    
    ## Need to go back before the Provisionals at the tail of the 2018 pull...
    sDate <- as.Date(min(archQ$dt))

    ## MC40AMod
    ## sDate <- as.Date("2018-01-01")
    
    ## Get fetchId for current site
    fetchCode <- usgsCodes$fetchId[which(usgsCodes$cityCode==substr(site, 1, nchar(site)-4))]
    uCode <- usgsCodes$usgsCode[which(usgsCodes$cityCode==substr(site, 1, nchar(site)-4))]

    ## loop print
    print("....PRE-Fetch")
    print(paste(site, fetchCode, sDate))

    ## Init end data for first pull as plus 2 years
    eDate <- sDate + 365*2
 
    ## Pull first two years to start
    recentQ <- read_waterdata_continuous(
        monitoring_location_id=fetchCode,
        parameter_code=QParameterCd,
        time=c(sDate, eDate),
        properties = c("time", "value", "approval_status", "qualifier"))

    ## Increment next eDate
    sDate <- as.Date(max(recentQ$time))
    eDate <- as.Date(max(recentQ$time)) + 365*2


    ## While start bins remain before present, keep going
    while (sDate < Sys.Date()) {

        ## Fetch based on start end
        nextQ <- read_waterdata_continuous(
            monitoring_location_id=fetchCode,
            parameter_code=QParameterCd,
            time=c(sDate, eDate),
            properties = c("time", "value", "approval_status", "qualifier"))

        ## Join and clean up
        recentQ <- rbind(recentQ, nextQ)
        rm(nextQ)

        ## reset data pull window
        sDate <- as.Date(max(recentQ$time))
        eDate <- as.Date(max(recentQ$time)) + 365*2

    }

    ## Now convert recent P from UTC to local
    recentQ$dt <- as.POSIXct(recentQ$time, tz="America/New_York")
    
    ## Convert colums as needed and rbind on to archQ.. new names or old names?
    ## agency_cd ("USGS", site_no, dt, cfs, cfsCd, tz
    recentQ <- recentQ %>%
        mutate(site_no=uCode) %>%
        select(site_no, dt, cfs=value, cfsCd=approval_status,
               cfsFlag=qualifier) %>%
        as.data.frame()

    
    ## Drop query time attr
    attr(recentQ, "request") <- NULL
    attr(recentQ, "queryTime") <- NULL

    ## Sort
    recentQ <- recentQ[order(recentQ$dt),] 

    ## If there are time dupes, drop them
    ## if (any(duplicated(mergedQ$dt))) {
    ##     mergedQ <- mergedQ[which(!(duplicated(mergedQ$dt))),]
    ## }

    ## Save and more cleanup
    saveRDS(recentQ, paste0("USGS-Flow/rdsArchUpdated/", site))
    rm(recentQ, sDate, eDate, archQ, uCode, fetchCode)
    gc()
}


## Feed list of files to function
system.time({
    invisible(lapply(flowFiles[11], rebuildOnce))
})

## Missing: MC40A, MY13A, MY7B, MY1B, MY8

## MC40A from 10-01-2018 on
mc40A_fresh <- readRDS("USGS-Flow/rdsArchUpdated/MC40A.rds")

mc40Ara <- readRDS("USGS-Flow/rdsArch/MC40A.rds") ## through "2003-09-30 19:45:00 EDT"
mc40Arn <- readRDS("USGS-Flow/rdsNew/MC40A.rds") ## through "2026-06-04 09:45:00 EDT"

## And if we drop new to only data in the arch range, they match on row count
## So even though ra 
mc40Arn2 <- mc40Arn %>%
    filter(dt<=max(mc40Ara$dt, na.rm=TRUE))

## but not sums because (1) rn2 stops 5 hours short?
> sum(mc40Arn2$cfs, na.rm=TRUE)
[1] 4516281
> sum(mc40Ara$cfs, na.rm=TRUE)
[1] 4516312

## but both dataset agree, 1.4 cfs from 19:45 back to first wobbles of 1.7 cfs
## at 14:00 and 13:30.  So clippng is weird, but NOT indicative of a 

## SO, lets stitch
mc40Aold <- mc40Arn %>%
    filter(dt<min(mc40A_fresh$dt,na.rm=TRUE)) %>%
    mutate(cfsFlag="") %>%
    select(site_no, dt, cfs, cfsCd, cfsFlag)


mc40A_use <- rbind(mc40A_fresh, ## new stuff
                   mc40Aold)

mc40A_use <- mc40A_use[order(mc40A_use$dt),] ## sort


## What about NA backfill for temporal gap?
dtFill <- seq.POSIXt(from=mc40A_use$dt[201107]+(15*60),
                     to=mc40A_use$dt[201108]-(15*60),
                     by="15 min")

fillDf <- data.frame(site_no=mc40A_use$site_no[1],
                     dt=dtFill, cfs=as.numeric(NA),
                     cfsCd=as.character(NA), cfsFlag=as.character(NA),
                     stringsAsFactors=FALSE)

mc40A_use <- rbind(mc40A_use, fillDf)
mc40A_use <- mc40A_use[order(mc40A_use$dt),]

plot(mc40A_use$dt, mc40A_use$cfs, typ="l")



## save that
saveRDS(mc40A_use, paste0("USGS-Flow/rdsArchUpdated/MC40A.rds"))


                           


#############################################################################
## 13A
lapply(flowFiles[24], rebuildOnce) ## MY13A quit at 24 hours
## I think this had 2 or 3 good pulls, then 2009 dated one posted 10+ times in a row
## and then went into doom loop
fetchCode <- "USGS-0212427947"
QParameterCd <- "00060"
sDate <- as.Date("2007-01-01")
eDate <- sDate + (365.25*2)

pull_1 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

sDate <- eDate
eDate <- sDate + (365.25*2)
pull_2 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


sDate <- eDate
eDate <- sDate + (365.25*2)
pull_3 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


sDate <- eDate
eDate <- sDate + (365.25*2)
pull_4 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


sDate <- eDate
eDate <- sDate + (365.25*2)
pull_5 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


## This one is over written
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_5b <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## 970s wait on this one.. but only one (16 min) and then it finishes?
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_6 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


sDate <- eDate
eDate <- sDate + (365.25*2)
pull_7 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


sDate <- eDate
eDate <- sDate + (365.25*2)
pull_8 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## and this one goes thorugh 2027
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_9 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## Now need to clean up and merge and save them

## merge first, then do other data operations 1x?
my13A <- rbind(pull_1, pull_2)
my13A <- rbind(my13A, pull_3)
my13A <- rbind(my13A, pull_4)
my13A <- rbind(my13A, pull_5)
my13A <- rbind(my13A, pull_5b)
my13A <- rbind(my13A, pull_6)
my13A <- rbind(my13A, pull_7)
my13A <- rbind(my13A, pull_8)
my13A <- rbind(my13A, pull_9)


## Strip attributes
## Drop query time attr
attr(my13A, "request") <- NULL
attr(my13A, "queryTime") <- NULL

## Now convert recent P from UTC to local
my13A$dt <- as.POSIXct(my13A$time, tz="America/New_York")
    
## Convert colums as needed and rbind on to archQ.. new names or old names?
## agency_cd ("USGS", site_no, dt, cfs, cfsCd, tz
recentQ <- my13A %>%
    mutate(site_no="0212427947") %>%
    select(site_no, dt, cfs=value, cfsCd=approval_status,
           cfsFlag=qualifier) %>%
    as.data.frame()

## sort
recentQ <- recentQ[order(recentQ$dt),] 

## dupes
dupes <- which(duplicated(recentQ$dt))
recentQ <- recentQ[-dupes,]

## save
saveRDS(recentQ, "USGS-Flow/rdsArchUpdated/MY13A.rds")

## And that might be good for MY13A but need a non-sleepy eyed review

#############################################################################
## Now 40A WTF older explortarly, implementation is above 
fetchCode <- "USGS-02146670"
QParameterCd <- "00060"

## Data checks.. weird, 1 year pulls back to at least 2019, so far so good
## Maybe it's a 2 year thing? Nope, Oct 2018 start date. 
## that is actually confirmed on NWISX page that discharge is 2018 to presetn?
mc40ArdsArch <- readRDS("USGS-Flow/rdsArch/MC40A.rds") ## through 2003
mc22ArdsArch <- readRDS("USGS-Flow/rdsArch/MC22A.rds") ## through 2018
my13rdsArch <- readRDS("USGS-Flow/rdsArch/MY13.rds") ## through 2018

mc40ArdsNew <- readRDS("USGS-Flow/rdsNew/MC40A.rds") ## through 2003

## So there is a big gap with data from 1997-2003, and then 2018 to present
## dataRetierval CAN fetch 2018 onward
## dataRetrieval CANNOT fetch teh earlier data.

## So need a start data that does 2018, then a post process to append the older data.


sDate <- as.Date("1997-01-01")
eDate <- sDate + (365.25*2)
pull_1997_99 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## 'data.frame':	0 obs. of  4 variables:

sDate <- as.Date("1999-01-01")
eDate <- sDate + (365.25*2)
pull_1999_00 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## 'data.frame':	0 obs. of  4 variables:





sDate <- as.Date("2024-01-01")
eDate <- sDate + (365.25*2)
pull_2024_25<- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [209,181 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2022-01-01")
eDate <- sDate + (365.25*2)
pull_2022_23 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [201,339 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2020-01-01")
eDate <- sDate + (365.25*2)
pull_2020_21 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [208,004 × 4] (S3: tbl_df/tbl/data.frame)


## Data starts Oct 01 2018
sDate <- as.Date("2018-01-01")
eDate <- sDate + (365.25*2)
pull_2018_19 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [131,520 × 4] (S3: tbl_df/tbl/data.frame) <<- seems low


sDate <- as.Date("2016-01-01")
eDate <- sDate + (365.25*2)
pull_2016_17 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## 'data.frame':	0 obs. of  4 variables:







sDate <- as.Date("2026-01-01")
eDate <- sDate + (365.25)
pull_2026 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [78,687 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2025-01-01")
eDate <- sDate + (365.25)
pull_2025 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [103,998 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2024-01-01")
eDate <- sDate + (365.25)
pull_2024 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [105,184 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2023-01-01")
eDate <- sDate + (365.25)
pull_2023 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [99,817 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2022-01-01")
eDate <- sDate + (365.25)
pull_2022 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [101,523 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2021-01-01")
eDate <- sDate + (365.25)
pull_2021 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [104,180 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2020-01-01")
eDate <- sDate + (365.25)
pull_2020 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [104,180 × 4] (S3: tbl_df/tbl/data.frame)


sDate <- as.Date("2019-01-01")
eDate <- sDate + (365.25)
pull_2019 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))
## tibble [105,027 × 4] (S3: tbl_df/tbl/data.frame)





## Weird, first actual data coming through by strting 2025?
sDate <- as.Date("2025-10-01")
## sDate <- as.Date("1996-01-01")
eDate <- sDate + (365.25*2)

## No data  at all?
pull_1 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## No data
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_2 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## No data
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_3 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## No data
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_4 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## No data
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_5 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


## No data
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_6 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## 970s wait on this one.. but only one (16 min) and then it finishes?
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_7 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


sDate <- eDate
eDate <- sDate + (365.25*2)
pull_8 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))


sDate <- eDate
eDate <- sDate + (365.25*2)
pull_9 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## and this one goes thorugh 2027
sDate <- eDate
eDate <- sDate + (365.25*2)
pull_9 <- read_waterdata_continuous(
    monitoring_location_id=fetchCode,
    parameter_code=QParameterCd,
    time=c(sDate, eDate),
    properties = c("time", "value", "approval_status", "qualifier"))

## Now need to clean up and merge and save them

## merge first, then do other data operations 1x?
mc40A <- rbind(pull_1, pull_2)
mc40A <- rbind(mc40A, pull_3)
mc40A <- rbind(mc40A, pull_4)
mc40A <- rbind(mc40A, pull_5)
mc40A <- rbind(mc40A, pull_5b)
mc40A <- rbind(mc40A, pull_6)
mc40A <- rbind(mc40A, pull_7)
mc40A <- rbind(mc40A, pull_8)
mc40A <- rbind(mc40A, pull_9)


## Strip attributes
## Drop query time attr
attr(mc40A, "request") <- NULL
attr(mc40A, "queryTime") <- NULL

## Now convert recent P from UTC to local
mc40A$dt <- as.POSIXct(mc40A$time, tz="America/New_York")
    
## Convert colums as needed and rbind on to archQ.. new names or old names?
## agency_cd ("USGS", site_no, dt, cfs, cfsCd, tz
recentQ <- mc40A %>%
    mutate(site_no="0212427947") %>%
    select(site_no, dt, cfs=value, cfsCd=approval_status,
           cfsFlag=qualifier) %>%
    as.data.frame()

## sort
recentQ <- recentQ[order(recentQ$dt),] 

## dupes
dupes <- which(duplicated(recentQ$dt))
recentQ <- recentQ[-dupes,]

## save
saveRDS(recentQ, "USGS-Flow/rdsArchUpdated/MY13A.rds")





#############################################################################



lapply(flowFiles[11], rebuildOnce) ## MC40A
## [1] "MC40A.rds USGS-02146670 1997-07-01"
## Requesting:
## https://api.waterdata.usgs.gov/ogcapi/v1/collections/continuous/items?f=json&lang=en-US&properties=time%2Cvalue%2Capproval_status%2Cqualifier&monitoring_location_id=USGS-02146670&parameter_code=00060&time=1997-07-01T00%3A00%3A00Z%2F1999-07-01T00%3A00%3A00Z&skipGeometry=TRUE&limit=50000
## Requesting:
## https://api.waterdata.usgs.gov/ogcapi/v1/collections/continuous/items?f=json&lang=en-US&properties=time%2Cvalue%2Capproval_status%2Cqualifier&monitoring_location_id=USGS-02146670&parameter_code=00060&time=-Inf%2F-Inf&skipGeometry=TRUE&limit=50000
## Error in `req_perform()`:
## ! HTTP 400 Bad Request.
## Run `rlang::last_trace()` to see where the error occurred.
## Warning messages:
## 1: In max.default(numeric(0), na.rm = FALSE) :
##   no non-missing arguments to max; returning -Inf
## 2: In max.default(numeric(0), na.rm = FALSE) :
##   no non-missing arguments to max; returning -Inf






#############################################################################
## These kicked on first run but did eventualy run through on single call
lapply(flowFiles[26], rebuildOnce) ## MY7B ran ok, conccludes with gc report?
## â ¹ iterating 2 done (0.2/s) | 9.8s
## â ¸ iterating 3 done (0.21/s) | 14.4s
## [[1]]
##           used (Mb) gc trigger  (Mb) max used  (Mb)
## Ncells 1162820 62.2    3717000 198.6  8042721 429.6
## Vcells 2863143 21.9   46533685 355.1 58160027 443.8

lapply(flowFiles[25], rebuildOnce) ## MY1B ... Good
lapply(flowFiles[27], rebuildOnce) ## MY8 .. Goood





#############################################################################
## Older post pull checking
## Let's check a newbie
mc25 <- readRDS("USGS-Flow/rdsArchUpdated/MC25.rds")
str(mc25)
head(mc25) ## not sure what thos [91] codes back in 98 are
tail(mc25)

mc25New <- readRDS("USGS-Flow/rdsNew/MC25.rds")
head(mc25New)


mm <- updateOnce(site=flowFiles) ## whats up with 7?






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
                        usgsCode=c("USGS-0214291555", "USGS-0214295600",
                                   "USGS-02146300", "USGS-02146348",
                                   "USGS-02146381", "USGS-02146409",
                                   "USGS-0214643820", "USGS-0214645022",
                                   "USGS-02146600", "USGS-02146670",
                                   "USGS-02146700", "USGS-02146750",
                                   "USGS-0214676115", "USGS-0214678175",
                                   "USGS-02146530", "USGS-0214265828",
                                   "USGS-0214685800", "USGS-0214297160",
                                   "USGS-0212414900", "USGS-02124269",
                                   "USGS-0212430293", "USGS-0212427947",
                                   "USGS-0212430653", "USGS-0214266080",
                                   "USGS-0214266000", "USGS-0212393300", ## Last 3 are
                                   "USGS-0212466000")) ## test county site additions

## Read the list of .rds files in the .rdata folder
flowFiles <- list.files(path="USGS-Flow/rdsArch", pattern="rds")

## MY8 only
## flowFiles <- flowFiles[27]
## usgsCodes <- usgsCodes[27,]

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

## a couple of months but run on laptop
## +    user  system elapsed 
## 2261.07 3407.09 6333.92 

## 12/5, a few months of data, 
## 2 hours, yep
