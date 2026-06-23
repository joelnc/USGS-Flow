## For model eval, want ot look beyond 5 min.
## could manually aggregate, but lets try to grab official

######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("EGRET")
library("dataRetrieval")
## library("beepr")

#############################################################################
######################### Sites DF  #########################################

QParameterCd <- "00060" ## Flow



#############################################################################
#################### MY13 Reedy 0212430293 ##################################
siteNumber <- "0212430293"

## High res pull... umm 10 min?
MY13NWIS_uv<- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); 

MY13NWIS_uv<- MY13NWIS_uv[,1:6]
names(MY13NWIS_uv) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

## Daily
MY13NWIS_dv <- readNWISdv(siteNumbers=siteNumber, parameterCd=QParameterCd) 

MY13NWIS_dv <- MY13NWIS_dv[,1:5]



