## Basic script to use dataRetrieval once per site to pull all avaialbe
## flow data to populate the rdsArch folder.  Then for regular updates
## only have to pull data from when this was last run and append (next script)

## Last run May 2018

######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("EGRET")
library("dataRetrieval")
library("beepr")

#############################################################################
######################### Sites DF  #########################################

QParameterCd <- "00060" ## Flow

#############################################################################
#################### MC14A Long Creek 214291555 #############################
## High res recent data
siteNumber <- "0214291555"
MC14ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                        tz="America/New_York"); beep(8)

MC14ANWIS <- MC14ANWIS[,1:6]
names(MC14ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC14ANWIS, "USGS-Flow/rdsArch/MC14A.rds")
rm(MC14ANWIS)

#############################################################################
#################### MC17 Paw 0214295600 ####################################
## High res recent data
siteNumber <- "0214295600"
MC17NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC17NWIS <- MC17NWIS[,1:6]
names(MC17NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC17NWIS, "USGS-Flow/rdsArch/MC17.rds")
rm(MC17NWIS)

#############################################################################
#################### MC22A Irwin 02146300 ###################################
## High res recent data
siteNumber <- "02146300"
MC22ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                        tz="America/New_York"); beep(8)

MC22ANWIS <- MC22ANWIS[,1:6]
names(MC22ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC22ANWIS, "USGS-Flow/rdsArch/MC22A.rds")
rm(MC22ANWIS)

#############################################################################
#################### MC25 Coffey 02146348 ###################################
##High res recent data
siteNumber <- "02146348"
MC25NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC25NWIS <- MC25NWIS[,1:6]
names(MC25NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC25NWIS, "USGS-Flow/rdsArch/MC25.rds")
rm(MC25NWIS)

#############################################################################
#################### MC27 Sugar Creek 02146381 ##############################
## High res recent data
siteNumber <- "02146381"
MC27NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC27NWIS <- MC27NWIS[,1:6]
names(MC27NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC27NWIS, "USGS-Flow/rdsArch/MC27.rds")
rm(MC27NWIS)

#############################################################################
#################### MC29A1 Little Sugar 02146409 ###########################
## High res recent data
siteNumber <- "02146409"
MC29A1NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC29A1NWIS <- MC29A1NWIS[,1:6]
names(MC29A1NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC29A1NWIS, "USGS-Flow/rdsArch/MC29A1.rds")
rm(MC29A1NWIS)

#############################################################################
#################### MC30A Edwards Branch 0214643820 ########################
## High res recent data
siteNumber <- "0214643820"
MC30ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC30ANWIS <- MC30ANWIS[,1:6]
names(MC30ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC30ANWIS, "USGS-Flow/rdsArch/MC30A.rds")
rm(MC30ANWIS)

#############################################################################
#################### MC33 Briar 0214645022 ##################################
## High res recent data
siteNumber <- "0214645022"
MC33NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC33NWIS <- MC33NWIS[,1:6]
names(MC33NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC33NWIS, "USGS-Flow/rdsArch/MC33.rds")
rm(MC33NWIS)

#############################################################################
#################### MC38 McAlpine Upper 02146600 (R) #######################
## High res recent data
siteNumber <- "02146600"
MC38NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC38NWIS <- MC38NWIS[,1:6]
names(MC38NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC38NWIS, "USGS-Flow/rdsArch/MC38.rds")
rm(MC38NWIS)

#############################################################################
#################### MC40A Fourmile 02146670 ################################
## No NWIS DATA??????

## High res recent data
siteNumber <- "02146670"
MC40ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC40ANWIS <- MC40ANWIS[,1:6]
names(MC40ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC40ANWIS, "USGS-Flow/rdsArch/MC40A.rds")
rm(MC40ANWIS)
#############################################################################
#################### MC42 McMullen Lower 02146700 ###########################
## High res recent data
siteNumber <- "02146700"
MC42NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC42NWIS <- MC42NWIS[,1:6]
names(MC42NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC42NWIS, "USGS-Flow/rdsArch/MC42.rds")
rm(MC42NWIS)

#############################################################################
#################### MC45 McAlpine Lower 02146750 ###########################
## High res recent data
siteNumber <- "02146750"
MC45NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC45NWIS <- MC45NWIS[,1:6]
names(MC45NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC45NWIS, "USGS-Flow/rdsArch/MC45.rds")
rm(MC45NWIS)

#############################################################################
#################### MC45B McAlpine SC 0214676115 ###########################
## High res recent data
siteNumber <- "0214676115"
MC45BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC45BNWIS <- MC45BNWIS[,1:6]
names(MC45BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC45BNWIS, "USGS-Flow/rdsArch/MC45B.rds")
rm(MC45BNWIS)

#############################################################################
#################### MC47A Steele 0214678175 ################################
## High res recent data
siteNumber <- "0214678175"
MC47ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC47ANWIS <- MC47ANWIS[,1:6]
names(MC47ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC47ANWIS, "USGS-Flow/rdsArch/MC47A.rds")
rm(MC47ANWIS)

#############################################################################
#################### MC49A LSC 02146530 #####################################
## High res recent data
siteNumber <- "02146530"
MC49ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC49ANWIS <- MC49ANWIS[,1:6]
names(MC49ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC49ANWIS, "USGS-Flow/rdsArch/MC49A.rds")
rm(MC49ANWIS)

#############################################################################
#################### MC50 Gar 0214266080 ####################################
siteNumber <- "0214266080"
MC50NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC50NWIS <- MC50NWIS[,1:6]
names(MC50NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC50NWIS, "USGS-Flow/rdsArch/MC50.rds")
rm(MC50NWIS)

#############################################################################
#################### MC51 Six Mile 0214685800 ###############################
siteNumber <- "0214685800"
MC51NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC51NWIS <- MC51NWIS[,1:6]
names(MC51NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

mc51Flow <-  MC51NWIS[,c("dt","cfs")]

saveRDS(MC51NWIS, "USGS-Flow/rdsArch/MC51.rds")
rm(MC51NWIS)

#############################################################################
#################### MC66 Beaverdam 0214297160 ##############################
siteNumber <- "0214297160"
MC66NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MC66NWIS <- MC66NWIS[,1:6]
names(MC66NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MC66NWIS, "USGS-Flow/rdsArch/MC66.rds")
rm(MC66NWIS)

#################### MY11B Mallard 0212414900 ###############################
## High res recent data
siteNumber <- "0212414900"
MY11BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MY11BNWIS <- MY11BNWIS[,1:6]
names(MY11BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MY11BNWIS, "USGS-Flow/rdsArch/MY11B.rds")
rm(MY11BNWIS)

#############################################################################
#################### MY12B Back 02124269 ####################################
siteNumber <- "02124269"
MY12BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MY12BNWIS <- MY12BNWIS[,1:6]
names(MY12BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

my12BFlow <-  MY12BNWIS[,c("dt","cfs")]

saveRDS(MY12BNWIS, "USGS-Flow/rdsArch/MY12B.rds")
rm(MY12BNWIS)

#############################################################################
#################### MY13 Reedy 0212430293 ##################################
siteNumber <- "0212430293"
MY13NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MY13NWIS <- MY13NWIS[,1:6]
names(MY13NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

my13Flow <-  MY13NWIS[,c("dt","cfs")]

saveRDS(MY13NWIS, "USGS-Flow/rdsArch/MY13.rds")
rm(MY13NWIS)

#############################################################################
#################### MY13A Reedy Plaza Rd 0212427947 ########################
siteNumber <- "0212427947"
MY13ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8)

MY13ANWIS <- MY13ANWIS[,1:6]
names(MY13ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

saveRDS(MY13ANWIS, "USGS-Flow/rdsArch/MY13A.rds")
rm(MY13ANWIS)

#############################################################################
#################### MY7B McKee 0212430653 ###############################
## High res recent data
siteNumber <- "0212430653"
MY7BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       tz="America/New_York"); beep(8

MY7BNWIS <- MY7BNWIS[,1:6]
names(MY7BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

my7BFlow <- MY7BNWIS[,c("dt","cfs")]

saveRDS(MY7BNWIS, "USGS-Flow/rdsArch/MY7B.rds")
rm(MY7BNWIS)

#############################################################################
#############################################################################








######################### Sites DF  #########################################

siteName <- c("McAlpine Upper", "McAlpine Lower", "McAlpine SC",
              "McMullen", "Upper Little Sugar", "Lower Little Sugar")

cmCode <- c("MC38", "MC45", "MC45B",
            "MC42", "MC29A1", "MC49A")

usgsCode <- c("02146600", "02146750", "0214676115",
              "02146700", "02146507", "02146530")

usgsArea <- c(38.6, 92.4, 95.9,
            6.95, 42.6, 49.2) #mi2



rm(site02146600)
site02146600 <- data.frame(dt=as.POSIXct(character()),cfs=numeric())




1980-27-04 2:00, 1980-26-10 2:00
1981-26-04 2:00, 1981-25-10 2:00
1982-25-04 2:00, 1982-31-10 2:00
1983-24-04 2:00, 1983-30-10 2:00
1984-29-04 2:00, 1984-28-10 2:00
1985-28-04 2:00, 1985-27-10 2:00
1986-27-04 2:00, 1986-26-10 2:00
1987-5-04 2:00, 1987-25-10 2:00
1988-3-04 2:00, 1988-30-10 2:00
1989-2-04 2:00, 1989-29-10 2:00
1990-1-04 2:00, 1990-28-10 2:00
1991-7-04 2:00, 1991-27-10 2:00
1992-5-04 2:00, 1992-25-10 2:00
1993-4-04 2:00, 1993-31-10 2:00
1994-3-04 2:00, 1994-30-10 2:00
1995-2-04 2:00, 1995-29-10 2:00
1996-7-04 2:00, 1996-27-10 2:00
1997-6-04 2:00, 1997-26-10 2:00
1998-5-04 2:00, 1998-25-10 2:00
1999-4-04 2:00, 1999-31-10 2:00
2000-2-04 2:00 2000-29-10 2:00
2001-1-04 2:00, 2001-28-10 2:00
2002-7-04 2:00, 2002-27-10 2:00
2003-6-04 2:00, 2003-26-10 2:00
2004-4-04 2:00, 2004-31-10 2:00
2005-3-04 2:00, 2005-30-10 2:00
2006-2-04 2:00, 2006-29-10 2:00
2007-11-03 2:00, 2007-4-11 2:00
2008-9-03 2:00, 2008-2-11 2:00
2009-8-03 2:00, 2009-1-11 2:00
2010-14-03 2:00, 2010-7-11 2:00
2011-13-03 2:00, 2011-6-11 2:00
2012-11-03 2:00, 2012-4-11 2:00
2013-10-03 2:00, 2013-3-11 2:00
2014-9-03 2:00, 2014-2-11 2:00
2015-8-03 2:00, 2015-1-11 2:00
2016-13-03 2:00, 2016-6-11 2:00
2017-12-03 2:00, 2017-5-11 2:00
2018-11-03 2:00, 2018-4-11 2:00
2019-10-03 2:00, 2019-3-11 2:00
