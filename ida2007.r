######################### CLEAR STUFF ##########################################
rm(list=ls())
graphics.off()
source("usgsFormat.R")

## IDA data should be static, but will periodically need to update newer data
## via NWIS.  So, replace NWIS txt files with data retrival calls, then joins
## to ida text.  I.e., flow can sit ready to use, and be upadated as needed
## with the single function call.


#############################################################################
######################### Sites DF  #########################################

#################### MC38 McAlpine Upper 02146600 ###########################
MC38a <- read.table(
    file="c:/Users/95218.CHARLOTTE/Documents/R/USGS-Flow/textfiles/02146600_ida_1.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

## EDT Switch on 10-01-2005
MC38b <- read.table(
    file="c:/Users/95218.CHARLOTTE/Documents/R/USGS-Flow/textfiles/02146600_ida_2.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("numeric",4)))

siteMC38 <- rbind(MC38a, MC38b)

siteMC38$DT <- rep(as.POSIXct(NA), nrow(siteMC38))
siteMC38$TZ <- rep(as.character(NA), nrow(siteMC38))

siteMC38$TZ[1:1028343] <- c("America/Panama")
siteMC38$TZ[1028344:1097734] <- c("America/New_York")

siteMC38$DT[1:1028343] <- as.POSIXct(siteMC38$dt[1:1028343],
                                     tz=siteMC38$TZ[1],
                                     format="%Y%m%d%H%M%S")

siteMC38$DT[1028344:1097734] <- as.POSIXct(siteMC38$dt[1028344:1097734],
                                     tz=siteMC38$TZ[1028344],
                                     format="%Y%m%d%H%M%S")


save(siteMC38,file="siteMC38_ida.Rdata")


#################### MC4 McDowell @ Beaties Ford 0214266000 ################
## EDT Switch on 10-01-2005
siteMC4 <- read.table(
    file="c:/Users/95218.CHARLOTTE/Documents/R/USGS-Flow/textfiles/0214266000_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC4$DT <- rep(as.POSIXct(NA), nrow(siteMC4))
siteMC4$TZ <- rep(as.character(NA), nrow(siteMC4))

siteMC4$TZ[1:535050] <- c("America/Panama")
siteMC4$TZ[535051:602509] <- c("America/New_York")

siteMC4$DT[1:535050] <- as.POSIXct(siteMC4$dt[1:535050],
                                     tz=siteMC4$TZ[1],
                                     format="%Y%m%d%H%M%S")

siteMC4$DT[535051:602509] <- as.POSIXct(siteMC4$dt[535051:602509],
                                     tz=siteMC4$TZ[535051],
                                     format="%Y%m%d%H%M%S")

save(siteMC4,file="siteMC4_ida.Rdata")

#################### MC45 McAlpine Lower 02146750 ################################
MC45a <- read.table(
    file="c:/Users/95218.CHARLOTTE/Documents/R/USGS-Flow/textfiles/02146750_ida_1.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

## EDT Switch on 10-01-2005
MC45b <- read.table(
    file="c:/Users/95218.CHARLOTTE/Documents/R/USGS-Flow/textfiles/02146750_ida_2.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("numeric",4)))

siteMC45 <- rbind(MC45a, MC45b)

siteMC45$DT <- rep(as.POSIXct(NA), nrow(siteMC45))
siteMC45$TZ <- rep(as.character(NA), nrow(siteMC45))

siteMC45$TZ[1:902573] <- c("America/Panama")
siteMC45$TZ[902574:964552] <- c("America/New_York")

siteMC45$DT[1:902573] <- as.POSIXct(siteMC45$dt[1:902573],
                                     tz=siteMC45$TZ[1],
                                     format="%Y%m%d%H%M%S")

siteMC45$DT[902574:964552] <- as.POSIXct(siteMC45$dt[902574:964552],
                                     tz=siteMC45$TZ[902574],
                                     format="%Y%m%d%H%M%S")

save(siteMC45,file="siteMC45_ida.Rdata")

#############################################################################
#############################################################################







## High res recent data
siteNumber <- "02146600"
QParameterCd <- "00060"
StartDate <- "2007-10-01"
##EndDate <- "2012-09-30"
dataData <- readNWISuv(siteNumbers=siteNumber, parameterCd=QParameterCd,
                       startDate=StartDate)
##Daily <- readNWISDaily(siteNumber, QParameterCd, startDate=StartDate, endDate="")
INFO <- readNWISInfo(siteNumber, parameterCd="00060")

eList <- as.egret(INFO,dataData)
eList <- setPA(eList)




## NWIS Data
siteC38 <-
    read.table(file="c:/Users/95218/Documents/R/usgs flow/text files/02146600_nwis.txt",
                sep="", header=FALSE, skip=29, fill=TRUE, as.is=TRUE,
                col.names=c("v1", "v2", "date", "time", "tz", "cfs", "cfsCd",
                            "ft", "ftCd", "in", "inCd"))

siteC38$DT <- rep(as.POSIXct(NA), nrow(siteC38))
siteC38$TZ <- rep(as.character(NA), nrow(siteC38))

siteC38$TZ[which(siteC38$tz=="EST")] <- c("America/Panama")
siteC38$TZ[which(siteC38$tz=="EDT")] <- c("America/New_York")


qs <- unname(floor(quantile(seq(1, length(siteC38$date)),
                            probs=seq(0, 1, .01))))

for (n in 1:length(siteC38$DT)){

    siteC38$DT[n] <- as.POSIXct(paste(siteC38$date[n],siteC38$time[n],sep=" "),
                                tz=siteC38$TZ[n])
    if (n %in% qs) {
        print(Sys.time())
        print(n/length(siteC38$date))
    }
}

save(siteC38,file="siteC38.Rdata")
siteC38s <- siteC38[ ,c("DT", "cfs")]
save(siteC38s,file="siteC38s.Rdata")
rm(list=ls())

load("siteMC38s.Rdata")
load("siteC38s.Rdata")
flowMC38 <- rbind(siteAB38s, siteC38s)
save(site38s, file="flowMC38.Rdata")

















#################### MC45 McAlpine Lower 02146750 (R:3) ##########################
a45 <-
    read.table(file="c:/Users/95218/Documents/R/usgs flow/02146750_ida_1.txt",
                sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
                col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
                colClasses=c(rep("character",3), rep("integer",2), "double",
                             "integer"))

b45 <-
    read.table(file="c:/Users/95218/Documents/R/usgs flow/02146750_ida_2.txt",
                sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
                col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
                colClasses=c(rep("character",3), rep("numeric",4)))

siteAB45 <- rbind(a45,b45)

siteAB45$DT <- rep(as.POSIXct(NA), nrow(siteAB45))

siteAB45$TZ <- rep(as.character(NA), nrow(siteAB45))

siteAB45$TZ[which(siteAB45$tz=="EST")] <- c("America/Panama")
siteAB45$TZ[which(siteAB45$tz=="EDT")] <- c("America/New_York")

qs <- unname(floor(quantile(seq(1, length(siteAB45$dt)),
                            probs=seq(0, 1, .01))))

for (n in 1:length(siteAB45$DT)){
    siteAB45$DT[n] <- as.POSIXct(siteAB45$dt[n],tz=siteAB45$TZ[n],
                                       format="%Y%m%d%H%M%S")
    if (n %in% qs) {
        print(Sys.time())
        print(n/length(siteAB45$dt))
    }
}

save(siteAB45,file="siteAB45.Rdata")
siteAB45s <- siteAB45[ ,c("DT", "cfs")]
save(siteAB45s,file="siteAB45s.Rdata")
rm(list=ls())


## NWIS Data
siteC45 <-
    read.table(file="c:/Users/95218/Documents/R/usgs flow/02146750_nwis.txt",
                sep="", header=FALSE, skip=29, fill=TRUE, as.is=TRUE,
                col.names=c("v1", "v2", "date", "time", "tz", "cfs", "cfsCd",
                            "ft", "ftCd", "in", "inCd"))

siteC45$DT <- rep(as.POSIXct(NA), nrow(siteC45))
siteC45$TZ <- rep(as.character(NA), nrow(siteC45))

siteC45$TZ[which(siteC45$tz=="EST")] <- c("America/Panama")
siteC45$TZ[which(siteC45$tz=="EDT")] <- c("America/New_York")


qs <- unname(floor(quantile(seq(1, length(siteC45$date)),
                            probs=seq(0, 1, .01))))

for (n in 1:length(siteC45$DT)){

    siteC45$DT[n] <- as.POSIXct(paste(siteC45$date[n],siteC45$time[n],sep=" "),
                                tz=siteC45$TZ[n])
    if (n %in% qs) {
        print(Sys.time())
        print(n/length(siteC45$date))
    }
}

save(siteC45,file="siteC45.Rdata")
siteC45s <- siteC45[ ,c("DT", "cfs")]
save(siteC45s,file="siteC45s.Rdata")
rm(list=ls())


load("siteAB45s.Rdata")
load("siteC45s.Rdata")
flowMC45 <- rbind(siteAB45s, siteC45s)
save(flowMC45, file="flowMC45.Rdata")

#################### MC42 McMullen  02146700 (R:2) #############################
a42 <-
    read.table(file="c:/Users/95218/Documents/R/usgs flow/02146700_ida_1.txt",
                sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
                col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
                colClasses=c(rep("character",3), rep("integer",2), "double",
                             "integer"))

b42 <-
    read.table(file="c:/Users/95218/Documents/R/usgs flow/02146700_ida_2.txt",
                sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
                col.names=c("site", "dt", "tz", "dd", "acCode", "cfs", "prec"),
                colClasses=c(rep("character",3), rep("numeric",4)))

siteAB42 <- rbind(a42,b42)

siteAB42$DT <- rep(as.POSIXct(NA), nrow(siteAB42))

siteAB42$TZ <- rep(as.character(NA), nrow(siteAB42))

siteAB42$TZ[which(siteAB42$tz=="EST")] <- c("America/Panama")
siteAB42$TZ[which(siteAB42$tz=="EDT")] <- c("America/New_York")

qs <- unname(floor(quantile(seq(1, length(siteAB42$dt)), probs=seq(0, 1, .01))))

for (n in 1:length(siteAB42$DT)){

    siteAB42$DT[n] <- as.POSIXct(siteAB42$dt[n],tz=siteAB42$TZ[n],
                                       format="%Y%m%d%H%M%S")
    if (n %in% qs) {
        print(Sys.time())
        print(n/length(siteAB42$dt))
    }
}


save(siteAB42,file="siteAB42.Rdata")
siteAB42s <- siteAB42[ ,c("DT", "cfs")]
save(siteAB42s,file="siteAB42s.Rdata")
rm(list=ls())

## NWIS Data
siteC42 <-
    read.table(file="c:/Users/95218/Documents/R/usgs flow/02146700_nwis.txt",
                sep="", header=FALSE, skip=29, fill=TRUE, as.is=TRUE,
                col.names=c("v1", "v2", "date", "time", "tz", "cfs", "cfsCd",
                            "ft", "ftCd", "in", "inCd"))

siteC42$DT <- rep(as.POSIXct(NA), nrow(siteC42))
siteC42$TZ <- rep(as.character(NA), nrow(siteC42))

siteC42$TZ[which(siteC42$tz=="EST")] <- c("America/Panama")
siteC42$TZ[which(siteC42$tz=="EDT")] <- c("America/New_York")


qs <- unname(floor(quantile(seq(1, length(siteC42$date)),
                            probs=seq(0, 1, .01))))

for (n in 1:length(siteC42$DT)){

    siteC42$DT[n] <- as.POSIXct(paste(siteC42$date[n],siteC42$time[n],sep=" "),
                                tz=siteC42$TZ[n])
    if (n %in% qs) {
        print(Sys.time())
        print(n/length(siteC42$date))
    }
}

save(siteC42,file="siteC42.Rdata")
siteC42s <- siteC42[ ,c("DT", "cfs")]
save(siteC42s,file="siteC42s.Rdata")
rm(list=ls())

## Combine
load("siteAB42s.Rdata")
load("siteC42s.Rdata")
flowMC42 <- rbind(siteAB42s, siteC42s)
save(flowMC42,file="flowMC42")



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
