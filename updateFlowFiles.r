######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("EGRET")
library("dataRetrieval")

#############################################################################
######################### Sites DF  #########################################

#################### MC38 McAlpine Upper 02146600 (R) #######################
## High res recent data
siteNumber <- "02146600"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC38NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC38NWIS <- MC38NWIS[,1:6]
names(MC38NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC38_ida.Rdata")

mc38Flow <- rbind(siteMC38[,c("dt", "cfs")],
              MC38NWIS[,c("dt","cfs")])

save(mc38Flow, file="rdata/mc38Flow.Rdata")
saveRDS(mc38Flow, "rdata/MC38.rds")

##load("rdata/mc38Flow.Rdata")
##plot(mc38Flow$dt, mc38Flow$cfs, pch=16)

#################### MC45 McAlpine Lower 02146750 ###########################
rm(list=ls())
## High res recent data
siteNumber <- "02146750"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC45NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC45NWIS <- MC45NWIS[,1:6]
names(MC45NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC45_ida.Rdata")

mc45Flow <- rbind(siteMC45[,c("dt", "cfs")],
              MC45NWIS[,c("dt","cfs")])

save(mc45Flow, file="rdata/mc45Flow.Rdata")
saveRDS(mc45Flow, "rdata/MC45.rds")

##load("rdata/mc45Flow.Rdata")
##plot(mc45Flow$dt, mc45Flow$cfs, pch=16, log="y")

#################### MC42 McAlpine Lower 02146700 ###########################
rm(list=ls())
## High res recent data
siteNumber <- "02146700"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC42NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC42NWIS <- MC42NWIS[,1:6]
names(MC42NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC42_ida.Rdata")

mc42Flow <- rbind(siteMC42[,c("dt", "cfs")],
              MC42NWIS[,c("dt","cfs")])

save(mc42Flow, file="rdata/mc42Flow.Rdata")
saveRDS(mc42Flow, "rdata/MC42.rds")

##load("rdata/mc42Flow.Rdata")
##plot(mc42Flow$dt, mc42Flow$cfs, pch=16, log="y")

#################### MC14A Long Creek 214291555 ########################
rm(list=ls())
## High res recent data
siteNumber <- "0214291555"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC14ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC14ANWIS <- MC14ANWIS[,1:6]
names(MC14ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC14A_ida.Rdata")

mc14AFlow <- rbind(siteMC14A[,c("dt", "cfs")],
              MC14ANWIS[,c("dt","cfs")])

save(mc14AFlow, file="rdata/mc14AFlow.Rdata")
saveRDS(mc14AFlow, "rdata/MC14A.rds")

##load("rdata/mc14AFlow.Rdata")
##plot(mc14AFlow$dt, mc14AFlow$cfs, pch=16, log="y")

#################### MC22A Irwin 02146300 ########################
rm(list=ls())
## High res recent data
siteNumber <- "02146300"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC22ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC22ANWIS <- MC22ANWIS[,1:6]
names(MC22ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC22A_ida.Rdata")

mc22AFlow <- rbind(siteMC22A[,c("dt", "cfs")],
              MC22ANWIS[,c("dt","cfs")])

save(mc22AFlow, file="rdata/mc22AFlow.Rdata")
saveRDS(mc22AFlow, "rdata/MC22A.rds")

##load("rdata/mc22AFlow.Rdata")
##plot(mc22AFlow$dt, mc22AFlow$cfs, pch=16, log="y")

#################### MC45B McAlpine SC 0214676115 ########################
rm(list=ls())
## High res recent data
siteNumber <- "0214676115"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC45BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC45BNWIS <- MC45BNWIS[,1:6]
names(MC45BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC45B_ida.Rdata")

mc45BFlow <- rbind(siteMC45B[,c("dt", "cfs")],
              MC45BNWIS[,c("dt","cfs")])

save(mc45BFlow, file="rdata/mc45BFlow.Rdata")
saveRDS(mc45BFlow, "rdata/MC45B.rds")

##load("rdata/mc45BFlow.Rdata")
##plot(mc45BFlow$dt, mc45BFlow$cfs, pch=16, log="y")

#################### MC49A LSC 02146530 ##################################
rm(list=ls())
## High res recent data
siteNumber <- "02146530"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC49ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC49ANWIS <- MC49ANWIS[,1:6]
names(MC49ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC49A_ida.Rdata")

mc49AFlow <- rbind(siteMC49A[,c("dt", "cfs")],
              MC49ANWIS[,c("dt","cfs")])

save(mc49AFlow, file="rdata/mc49AFlow.Rdata")
saveRDS(mc49AFlow, "rdata/MC49A.rds")

##load("rdata/mc49AFlow.Rdata")
##plot(mc49AFlow$dt, mc49AFlow$cfs, pch=16, log="y")

#################### MC27 Sugar Creek 02146381 ###########################
rm(list=ls())
## High res recent data
siteNumber <- "02146381"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC27NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC27NWIS <- MC27NWIS[,1:6]
names(MC27NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC27_ida.Rdata")

mc27Flow <- rbind(siteMC27[,c("dt", "cfs")],
              MC27NWIS[,c("dt","cfs")])

save(mc27Flow, file="rdata/mc27Flow.Rdata")
saveRDS(mc27Flow, "rdata/MC27.rds")

##load("rdata/mc27Flow.Rdata")
##plot(mc27Flow$dt, mc27Flow$cfs, pch=16, log="y")

#################### MY7B McKee 0212430653 ###############################
rm(list=ls())
## High res recent data
siteNumber <- "0212430653"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MY7BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MY7BNWIS <- MY7BNWIS[,1:6]
names(MY7BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

my7BFlow <- MY7BNWIS[,c("dt","cfs")]

save(my7BFlow, file="rdata/my7BFlow.Rdata")
saveRDS(my7BFlow, "rdata/MY7B.rds")

##load("rdata/my7BFlow.Rdata")
##plot(my7BFlow$dt, my7BFlow$cfs, pch=16, log="y")

#################### MC47A Steele 0214678175 ############################
rm(list=ls())
## High res recent data
siteNumber <- "0214678175"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
MC47ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC47ANWIS <- MC47ANWIS[,1:6]
names(MC47ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC47A_ida.Rdata")

mc47AFlow <- rbind(siteMC47A[,c("dt", "cfs")],
              MC47ANWIS[,c("dt","cfs")])

save(mc47AFlow, file="rdata/mc47AFlow.Rdata")
saveRDS(mc47AFlow, "rdata/MC47A.rds")

##load("rdata/mc47AFlow.Rdata")
##plot(mc47AFlow$dt, mc47AFlow$cfs, pch=16, log="y")








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
