######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("EGRET")
library("dataRetrieval")

#############################################################################
######################### Sites DF  #########################################

QParameterCd <- "00060"
StartDate <- "2007-10-01"

#################### MC14A Long Creek 214291555 ########################
## High res recent data
siteNumber <- "0214291555"
MC14ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC14ANWIS <- MC14ANWIS[,1:6]
names(MC14ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC14A_ida.Rdata")

mc14AFlow <- rbind(siteMC14A[,c("dt", "cfs")],
              MC14ANWIS[,c("dt","cfs")])

save(mc14AFlow, file="rdata/mc14AFlow.Rdata")
saveRDS(mc14AFlow, "rdata/MC14A.rds")
rm(MC14ANWIS, mc14AFlow)

#############################################################################
#################### MC17 Paw 0214295600 ####################################
## High res recent data
siteNumber <- "0214295600"
MC17NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC17NWIS <- MC17NWIS[,1:6]
names(MC17NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC17_ida.Rdata")

mc17Flow <- rbind(siteMC17[,c("dt", "cfs")],
              MC17NWIS[,c("dt","cfs")])

save(mc17Flow, file="rdata/mc17Flow.Rdata")
saveRDS(mc17Flow, "rdata/MC17.rds")
rm(MC17NWIS, mc17Flow)

#################### MC22A Irwin 02146300 ########################
## High res recent data
siteNumber <- "02146300"
MC22ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC22ANWIS <- MC22ANWIS[,1:6]
names(MC22ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC22A_ida.Rdata")

mc22AFlow <- rbind(siteMC22A[,c("dt", "cfs")],
              MC22ANWIS[,c("dt","cfs")])

save(mc22AFlow, file="rdata/mc22AFlow.Rdata")
saveRDS(mc22AFlow, "rdata/MC22A.rds")
rm(MC22ANWIS, mc22AFlow)

#############################################################################
#################### MC25 Coffey 02146348 ###################################
##High res recent data
siteNumber <- "02146348"
MC25NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC25NWIS <- MC25NWIS[,1:6]
names(MC25NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC25_ida.Rdata")

mc25Flow <- rbind(siteMC25[,c("dt", "cfs")],
              MC25NWIS[,c("dt","cfs")])

save(mc25Flow, file="rdata/mc25Flow.Rdata")
saveRDS(mc25Flow, "rdata/MC25.rds")
rm(MC25NWIS, mc25Flow)

#################### MC27 Sugar Creek 02146381 ###########################
## High res recent data
siteNumber <- "02146381"
MC27NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC27NWIS <- MC27NWIS[,1:6]
names(MC27NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC27_ida.Rdata")

mc27Flow <- rbind(siteMC27[,c("dt", "cfs")],
              MC27NWIS[,c("dt","cfs")])

save(mc27Flow, file="rdata/mc27Flow.Rdata")
saveRDS(mc27Flow, "rdata/MC27.rds")
rm(MC27NWIS, mc27Flow)


#############################################################################
#################### MC29A1 Little Sugar 02146409 ###########################
## High res recent data
siteNumber <- "02146409"
MC29A1NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC29A1NWIS <- MC29A1NWIS[,1:6]
names(MC29A1NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC29A1_ida.Rdata")

mc29A1Flow <- rbind(siteMC29A1[,c("dt", "cfs")],
              MC29A1NWIS[,c("dt","cfs")])

save(mc29A1Flow, file="rdata/mc29A1Flow.Rdata")
saveRDS(mc29A1Flow, "rdata/MC29A1.rds")
rm(MC29A1NWIS, mc29A1Flow)

#############################################################################
#################### MC30A Edwards Branch 0214643820 ########################
## High res recent data
siteNumber <- "0214643820"
MC30ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC30ANWIS <- MC30ANWIS[,1:6]
names(MC30ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC30A_ida.Rdata")

mc30AFlow <- rbind(siteMC30A[,c("dt", "cfs")],
              MC30ANWIS[,c("dt","cfs")])

save(mc30AFlow, file="rdata/mc30AFlow.Rdata")
saveRDS(mc30AFlow, "rdata/MC30A.rds")
rm(MC30ANWIS, mc30AFlow)


#################### MC33 Briar 0214645022 ##################################
## High res recent data
siteNumber <- "0214645022"
MC33NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC33NWIS <- MC33NWIS[,1:6]
names(MC33NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC33_ida.Rdata")

mc33Flow <- rbind(siteMC33[,c("dt", "cfs")],
              MC33NWIS[,c("dt","cfs")])

save(mc33Flow, file="rdata/mc33Flow.Rdata")
saveRDS(mc33Flow, "rdata/MC33.rds")
rm(MC33NWIS, mc33Flow)

#################### MC38 McAlpine Upper 02146600 (R) #######################
## High res recent data
siteNumber <- "02146600"
MC38NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC38NWIS <- MC38NWIS[,1:6]
names(MC38NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC38_ida.Rdata")

mc38Flow <- rbind(siteMC38[,c("dt", "cfs")],
              MC38NWIS[,c("dt","cfs")])

save(mc38Flow, file="rdata/mc38Flow.Rdata")
saveRDS(mc38Flow, "rdata/MC38.rds")
rm(MC38NWIS, mc38Flow)

#############################################################################
#################### MC40A Fourmile 02146670 ################################
## No NWIS DATA??????

## High res recent data
## siteNumber <- "02146670"
## MC40ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
##                        startDate=StartDate, tz="America/New_York")

## MC40ANWIS <- MC40ANWIS[,1:6]
## names(MC40ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

## load("rdata/siteMC40A_ida.Rdata")

## mc40AFlow <- rbind(siteMC40A[,c("dt", "cfs")],
##               MC40ANWIS[,c("dt","cfs")])

## save(mc40AFlow, file="rdata/mc40AFlow.Rdata")
## saveRDS(mc40AFlow, "rdata/MC40A.rds")


#################### MC42 McMullen Lower 02146700 ###########################
## High res recent data
siteNumber <- "02146700"
MC42NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC42NWIS <- MC42NWIS[,1:6]
names(MC42NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC42_ida.Rdata")

mc42Flow <- rbind(siteMC42[,c("dt", "cfs")],
              MC42NWIS[,c("dt","cfs")])

save(mc42Flow, file="rdata/mc42Flow.Rdata")
saveRDS(mc42Flow, "rdata/MC42.rds")


#################### MC45 McAlpine Lower 02146750 ###########################
## High res recent data
siteNumber <- "02146750"
MC45NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC45NWIS <- MC45NWIS[,1:6]
names(MC45NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC45_ida.Rdata")

mc45Flow <- rbind(siteMC45[,c("dt", "cfs")],
              MC45NWIS[,c("dt","cfs")])

save(mc45Flow, file="rdata/mc45Flow.Rdata")
saveRDS(mc45Flow, "rdata/MC45.rds")
rm(MC45NWIS, mc45Flow)


#################### MC45B McAlpine SC 0214676115 ########################
## High res recent data
siteNumber <- "0214676115"
MC45BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC45BNWIS <- MC45BNWIS[,1:6]
names(MC45BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC45B_ida.Rdata")

mc45BFlow <- rbind(siteMC45B[,c("dt", "cfs")],
              MC45BNWIS[,c("dt","cfs")])

save(mc45BFlow, file="rdata/mc45BFlow.Rdata")
saveRDS(mc45BFlow, "rdata/MC45B.rds")
rm(MC45BNWIS, mc45BFlow)


#################### MC47A Steele 0214678175 ############################
## High res recent data
siteNumber <- "0214678175"
MC47ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC47ANWIS <- MC47ANWIS[,1:6]
names(MC47ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC47A_ida.Rdata")

mc47AFlow <- rbind(siteMC47A[,c("dt", "cfs")],
              MC47ANWIS[,c("dt","cfs")])

save(mc47AFlow, file="rdata/mc47AFlow.Rdata")
saveRDS(mc47AFlow, "rdata/MC47A.rds")
rm(MC47ANWIS, mc47AFlow)


#################### MC49A LSC 02146530 ##################################
## High res recent data
siteNumber <- "02146530"
MC49ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC49ANWIS <- MC49ANWIS[,1:6]
names(MC49ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC49A_ida.Rdata")

mc49AFlow <- rbind(siteMC49A[,c("dt", "cfs")],
              MC49ANWIS[,c("dt","cfs")])

save(mc49AFlow, file="rdata/mc49AFlow.Rdata")
saveRDS(mc49AFlow, "rdata/MC49A.rds")
rm(MC49ANWIS, mc49AFlow)


#############################################################################
#################### MC50 Gar 0214266080 ####################################
siteNumber <- "0214266080"
MC50NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC50NWIS <- MC50NWIS[,1:6]
names(MC50NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC50_ida.Rdata")

mc50Flow <- rbind(siteMC50[,c("dt", "cfs")],
              MC50NWIS[,c("dt","cfs")])

save(mc50Flow, file="rdata/mc50Flow.Rdata")
saveRDS(mc50Flow, "rdata/MC50.rds")
rm(MC50NWIS, mc50Flow)


#############################################################################
#################### MC51 Six Mile 0214685800 ###############################
siteNumber <- "0214685800"
MC51NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC51NWIS <- MC51NWIS[,1:6]
names(MC51NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

mc51Flow <-  MC51NWIS[,c("dt","cfs")]

save(mc51Flow, file="rdata/mc51Flow.Rdata")
saveRDS(mc51Flow, "rdata/MC51.rds")
rm(MC51NWIS, mc51Flow)


#############################################################################
#################### MC66 Beaverdam 0214297160 #############################
siteNumber <- "0214297160"
MC66NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MC66NWIS <- MC66NWIS[,1:6]
names(MC66NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMC66_ida.Rdata")

mc66Flow <- rbind(siteMC66[,c("dt", "cfs")],
              MC66NWIS[,c("dt","cfs")])

save(mc66Flow, file="rdata/mc66Flow.Rdata")
saveRDS(mc66Flow, "rdata/MC66.rds")
rm(MC66NWIS, mc66Flow)

#################### MY11B Mallard 0212414900 ###############################
## High res recent data
siteNumber <- "0212414900"
MY11BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MY11BNWIS <- MY11BNWIS[,1:6]
names(MY11BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMY11B_ida.Rdata")

my11BFlow <- rbind(siteMY11B[,c("dt", "cfs")],
              MY11BNWIS[,c("dt","cfs")])

save(my11BFlow, file="rdata/my11BFlow.Rdata")
saveRDS(my11BFlow, "rdata/MY11B.rds")
rm(MY11BNWIS, my11BFlow)


#############################################################################
#################### MY12B Back 02124269 ####################################
siteNumber <- "02124269"
MY12BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MY12BNWIS <- MY12BNWIS[,1:6]
names(MY12BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

my12BFlow <-  MY12BNWIS[,c("dt","cfs")]

save(my12BFlow, file="rdata/my12BFlow.Rdata")
saveRDS(my12BFlow, "rdata/MY12B.rds")
rm(MY12BNWIS, my12BFlow)

#############################################################################
#################### MY13 Reedy 0212430293 ##################################
siteNumber <- "0212430293"
MY13NWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MY13NWIS <- MY13NWIS[,1:6]
names(MY13NWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

my13Flow <-  MY13NWIS[,c("dt","cfs")]

save(my13Flow, file="rdata/my13Flow.Rdata")
saveRDS(my13Flow, "rdata/MY13.rds")
rm(MY13NWIS, my13Flow)

#############################################################################
#################### MY13A Reedy Plaza Rd 0212427947 ########################
siteNumber <- "0212427947"
MY13ANWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MY13ANWIS <- MY13ANWIS[,1:6]
names(MY13ANWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

load("rdata/siteMY13A_ida.Rdata")

my13AFlow <- rbind(siteMY13A[,c("dt", "cfs")],
              MY13ANWIS[,c("dt","cfs")])

save(my13AFlow, file="rdata/my13AFlow.Rdata")
saveRDS(my13AFlow, "rdata/MY13A.rds")
rm(MY13ANWIS, my13AFlow)

#################### MY7B McKee 0212430653 ###############################
## High res recent data
siteNumber <- "0212430653"
MY7BNWIS <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate, tz="America/New_York")

MY7BNWIS <- MY7BNWIS[,1:6]
names(MY7BNWIS) <- c("agency_cd", "site_no", "dt", "cfs", "cfsCd", "tz")

my7BFlow <- MY7BNWIS[,c("dt","cfs")]

save(my7BFlow, file="rdata/my7BFlow.Rdata")
saveRDS(my7BFlow, "rdata/MY7B.rds")
rm(MY7BNWIS, my7BFlow)








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
