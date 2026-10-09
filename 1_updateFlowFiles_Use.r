#### 2026 Stuff
## Just rebuilt archive so now need to update adn append to that.  Per precip,
## first run uses new archive, then a second runner version.

## This will be the routine runner following Oct 9. 2026 initial update run to fresh pulls

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




## First run: Read the list of .rds files in rdsArchUpdated
flowFiles <- list.files(path="USGS-Flow/rdsNew", pattern="rds")
QParameterCd <- "00060"

#############################################################################
## Init df
pullDf <- data.frame(siteFile=NULL, sDate=NULL)

## clear warnings to help catch lurking file read warning?
## assign("last.warning", NULL, envir = baseenv())

for (i in 1:length(flowFiles)) {

    ## Load in current data 
    print(paste("Loading", i))
    dTemp <- readRDS(paste0("USGS-Flow/rdsNew/", flowFiles[i]))
    ## warnings()
    
    ## Set the "data to be aggregated" mark to the day before the first P flag
    ## data in the hourly archive
    aggrFDate <- as.Date(min(dTemp$dt[which(dTemp$cfsCd=="Provisional")]))-1

    sDf <- data.frame(siteFile=flowFiles[i], sDate=aggrFDate,
                      stringsAsFactors=FALSE)

    pullDf <- rbind(pullDf, sDf)
    
    rm(aggrFDate, dTemp,sDf); gc()
} ## 60 sec

warnings() ## gone.  Ok

## Sort -- need to look at this and decide fetch binning based on head and tail
pullDf <- pullDf[order(pullDf$sDate),]
plot(pullDf$sDate, rep(2, nrow(pullDf)))



## Spec size for head, tail and back fill middle.
## on first runs there is one very old site, then 4 laggards, then a bunch
headTag <- 1
tailTag <- 22 ## 15
mSeq <- seq(headTag+1, nrow(pullDf)-tailTag)

str(pullDf)
## 'data.frame':	27 obs. of  2 variables:
##  $ siteFile: chr  "MC40A.rds" "MC29A1.rds" "MC47A.rds" "MC33.rds" ...
 ## $ sDate   : Date, format: "2025-06-10" "2025-11-03" "2025-11-18" "2026-02-04" ...

str(usgsCodes)
## 'data.frame':	27 obs. of  3 variables:
##  $ cityCode: chr  "MC14A" "MC17" "MC22A" "MC25" ...
##  $ usgsCode: chr  "0214291555" "0214295600" "02146300" "02146348" ...
##  $ fetchId : chr  "USGS-0214291555" "USGS-0214295600" "USGS-02146300" "USGS-02146348" ...

## Don't think nchar is not going to work as is, .. or it does

## Get Fetch Ids
headFetchIds <-
    usgsCodes$fetchId[which(usgsCodes$cityCode %in%
                            substr(
                                head(pullDf$siteFile, headTag),
                                1,
                                nchar(head(pullDf$siteFile, headTag))-4
                            ))]

## run head fetch
system.time({
    headPull <- read_waterdata_continuous(
        monitoring_location_id=headFetchIds,
        parameter_code=QParameterCd,
        time=paste0(min(head(pullDf$sDate, headTag)),"T00:00:00Z/.."),
        attach_request=FALSE)
})
## First run: 61 sec 


## Get Fetch Ids
midFetchIds <-
    usgsCodes$fetchId[which(usgsCodes$cityCode %in%
                            substr(
                                pullDf$siteFile[mSeq],
                                1,
                                nchar(pullDf$siteFile[mSeq])-4
                            ))]
## run head fetch
system.time({
    middlePull <- read_waterdata_continuous(
        monitoring_location_id=midFetchIds,
        parameter_code=QParameterCd,
        time=paste0(min(pullDf$sDate[mSeq]),"T00:00:00Z/.."),                  
        attach_request=FALSE)
})
## First run: 159 sec (4 sites)


tailFetchIds <-
    usgsCodes$fetchId[which(usgsCodes$cityCode %in%
                            substr(
                                tail(pullDf$siteFile, tailTag),
                                1,
                                nchar(tail(pullDf$siteFile, tailTag))-4
                            ))]

## run head fetch
system.time({
    tailPull <- read_waterdata_continuous(
        monitoring_location_id=tailFetchIds,
        parameter_code=QParameterCd,
        time=paste0(min(tail(pullDf$sDate, tailTag)),"T00:00:00Z/.."),
        attach_request=FALSE)
})
## First run: 425 s or 7 min. not bad



## combine into one thing
bulkPull <- rbind(headPull, middlePull)
bulkPull <- rbind(bulkPull, tailPull)

## Ok, 3.5 M records

## do this here
bulkPull <- bulkPull %>%
    mutate(dt=as.POSIXct(bulkPull$time, tz="America/New_York")) %>%
    select(dt, cfs=value, cfsCd=approval_status, cfsFlag=qualifier,
           fetchId=monitoring_location_id) %>%
    ## mutate(across(everything(), as.vector)) %>%
    as.data.frame()

## Drop query time attr
attr(bulkPull, "queryTime") <- NULL


## To proceed, precip steps not all needed. No regularizatin, etc.  Simpler loop

## NEED TO rerun precip as i think the head tail referenceing is screwy and probably
## bunged up.



## For below, flow updates are already in mem as bulkPull. So loop over sites,
## match, append.  Since they are fresh pulls in archive, col matching should be
## straight forward
archQTest <- readRDS(paste0("USGS-Flow/rdsArchUpdated/MC22A.rds"))



updateFlow <- function(site) {

    ## Read file from dis
    archQ <- readRDS(paste0("USGS-Flow/rdsNew/", site))

    ## Added this to drop EOF NA row from CRN19
    archQ <- archQ[which(!is.na(archQ$dt)),]

    ## Paste up a site match
    matchCode <- archQ$site_no[2]
    
    ## Archive file has plain numeric site code.  Fresh has USGS-number
    siteNew <- bulkPull %>%
        filter(fetchId==matchCode) %>%
        select(site_no=fetchId, dt, cfs, cfsCd, cfsFlag) %>%
        arrange(dt) %>%
        as.data.frame()
    

    ## We have new data
    siteUpdated <- rbind(siteNew,
                         archQ[which(archQ$dt<min(siteNew$dt, na.rm=TRUE)),])

    ## sort
    siteUpdated <- siteUpdated[order(siteUpdated$dt),]
    
    ## unify site_no
    ## siteUpdated$site_no <- siteNew$site_no[1]
    
    ## If there are time dupes, drop them
    ## On first run there are a bunch, all 9/23-9/29 various years, 20:00
    ## That's not EDT, so maybe prior step stitching error?
    if (any(duplicated(siteUpdated$dt))) {
        siteUpdated <- siteUpdated[which(!(duplicated(siteUpdated$dt))),]
    }    

    ## Save and more cleanup
    saveRDS(siteUpdated, paste0("USGS-Flow/rdsNew/", site))
    rm(archQ, siteUpdated, matchCode)
    gc()
}


## Feed list of files to function
system.time({
    invisible(lapply(flowFiles, updateFlow))
})

## 4 minutes here
 

## Looks good
before22a <- readRDS("USGS-Flow/rdsArchUpdated/MC22A.rds")
after22a <- readRDS("USGS-Flow/rdsNew2026/MC22A.rds")

plot(tail(after22a$dt,10000),tail(after22a$cfs,10000), typ="l")
lines(tail(before22a$dt,10000),tail(before22a$cfs,10000), typ="l", col="red")




#############################################################################
## OlderNWIS Input Stuff
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
