## For matrix LDC stuff atleast, needed FDCs.  This is a rough implementatation
## See format notes below.  Works with current workflows as is, but..

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

## Result is a single df w/ columns as follows.
## Site   q0.1% q0.2% q0.3% q0.4% q0.5% ....
## MC14A  0     0     0     0     0
## MC17   0.12  0.16  0.16  0.19  0.19
## MC22A  3.5   3.88  4.14  4.2   4.4
## .....


## Save rds
saveRDS(resultDF, "USGS-Flow/refFlowQuantiles.rds")
