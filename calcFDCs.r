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
    #### Manual FDC code, but i think quanitle algo 7 (default) does
    ####   what is needed
    ## qData <- qData[order(qData$cfs, decreasing=FALSE), ]
    ## qData$rank <- seq(1,nrow(qData))
    ## qData$qiIV <- (1-(qData$rank/(nrow(qData)+1)))*100

    res <- quantile(qData$cfs, probs=seq(.01,.99,.01))

}

## Apply fun
resres <- lapply(X=flowSites, FUN=fdcStats)
resultDF <- do.call("rbind", resres)

## Name results
row.names(resultDF) <- flowSites
colnames(resultDF) <- paste0(format(seq(.99,0.01,-.01),nsmall=2), "%")

## Save rds
saveRDS(resultDF, "USGS-Flow/refFlowQuantiles.rds")
