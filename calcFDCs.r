rm(list=ls())

## List files present
flowFiles <- list.files(path="USGS-Flow/rdsNew", pattern="rds")

## Make a list of sites for which flow data are present
listSites <- function(fileName) {
    siteName <- substr(fileName, 1, nchar(fileName)-4)
}
flowSites <- unlist(lapply(X=flowFiles, FUN=listSites))

fdcStats <- function(site) {

    qData <- readRDS(
        paste0("USGS-Flow/rdsNew/", site,".rds"))
    res <- c(site, quantile(qData$cfs, probs=seq(.001,.999,.001)))
    #### Manual FDC code, but i think quanitle algo 7 (default) does
    ####   what is needed
    ## qData <- qData[order(qData$cfs, decreasing=FALSE), ]
    ## qData$rank <- seq(1,nrow(qData))
    ## qData$qiIV <- (1-(qData$rank/(nrow(qData)+1)))*100
}

## Apply fun
resres <- lapply(X=flowSites, FUN=fdcStats)
resultDF <- as.data.frame(do.call("rbind", resres), stringsAsFactors=FALSE)

names(resultDF)[1] <- "Site"
names(resultDF)[2:1000] <- paste0("q", names(resultDF)[2:1000])

## Name results
## row.names(resultDF) <- flowSites
## colnames(resultDF) <- paste0("qExc", format(seq(99.9,0.1,-0.1),
##                                             trim=TRUE, nsmall=01))

## resultDF <- as.data.frame(resultDF)
## resultDF$siteCode <- rownames(resultDF)

## Save rds
saveRDS(resultDF, "USGS-Flow/refFlowQuantiles.rds")
