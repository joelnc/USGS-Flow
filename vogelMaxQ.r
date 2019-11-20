######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("dataRetrieval")
library("Kendall")
source("globalFuns/logSpace.r")

#############################################################################
## NWIS Input Stuff
QParameterCd <- "00060"
StartDate <- "2007-10-01"

## Hard code lookups for usgs vs city codes
usgsCodes <- data.frame(cityCode=c("Irwin1", "McAlpineSardis",
                                   "McMullenSharon", "LongPaw",
                                   "McAlpinePineville", "LSArchdale",
                                   "IrwinStatesville", "LittleHope"),
                        usgsCode=c("02146300", "02146600",
                                   "02146700", "02142900",
                                   "02146750", "02146507",
                                   "02146211", "02146470"))

#############################################################################
## Aberjona
ds <- readNWISpeak(siteNumbers="01102500")
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)
ds$log10Q <- log10(ds$peak_va)
ds<- ds[which(ds$yr<=2007),]

## Plot, look at summary stats
plot(ds$yr, ds$log10Q, ylim=c(1,10))
plot(ds$yr, ds$peak_va, ylog=TRUE, ylim=c(10,10000))

## matches usgs peak flow plot through nwis site
plot(ds$yr, ds$peak_va, ylim=c(0,2000), col="blue",cex=1.2)

## vogel fig
plot(ds$yr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(10,10000))
axis(side=2, at=c(10,100,1000,10000), las=2)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$yr, exp(lm1pred))

#############################################################################
xMin <- 1960
xMax <- 2018
yMin <- 200
yMax <- 30000
titleLine <- 0.75
daYr  <- 1971

png(file="USGS-Flow/vogelFig.png", height=8, width=7.5,
   units="in", res=500)
## dev.new(width=7, height=7.5)
par(mfrow=c(4,2),mai=c(.35, 1.25, 0.35, 0.25), yaxs="i")

#############################################################################
## LittleHope UP .0447/0.0159 p/b mkp .066
## full <- readRDS("USGS-Flow/littleHopeStage.rds")
## full$mo <- as.numeric(format(full$dateTime, "%m"))
## full$wYr <- as.numeric(NA)
## ## for (i in 1:nrow(full)) {
## for (i in 1:50000) {
##     if (full$mo[i]>=10) {
##         full$wYr[i] <- as.numeric(format(full$dateTime, "%Y")) + 1
##     } else {
##         full$wYr[i] <- as.numeric(format(full$dateTime, "%Y"))
##     }
## }

ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[8])
ds$logQ <- log(ds$peak_va)

## Add water year column
ds$mo <- as.numeric(format(ds$peak_dt, "%m"))
ds$wYr <- as.numeric(NA)

for (i in 1:nrow(ds)) {
    if (ds$mo[i]>=10) {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y")) + 1
    } else {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y"))
    }
}

## back fill nas
allYrs <- seq(min(ds$wYr), max(ds$wYr))
missingYrs <- allYrs[!(allYrs %in% ds$wYr)]
missingDf  <- data.frame(wYr=missingYrs, peak_va=NA, stringsAsFactors=FALSE)
ds1  <-  ds[,c("wYr", "peak_va")]
ds2 <- rbind(missingDf, ds1)
ds2 <- ds2[order(ds2$wYr),]
ds2$logQ <- log(ds2$peak_va)

MannKendall(ds2$peak_va) 

## p val and da
da <- attr(ds, "siteInfo")$drain_area_va
    
## Plot, look at summary stats
plot(ds2$wYr, ds2$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.02)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
axis(1, at=missingYrs, labels=FALSE, tck=.02, lwd=1, col="red")
mtext(2, text="Annual Max. Inst.", line=6, font=2, cex=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2, cex=1.1)
mtext(3, text="Little Hope @ Seneca", font=2, cex=1.2, line=titleLine)
text(x=daYr, y=18000, labels=paste0("DA = ", da, " sq. mi"),
     font=2) 
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds2)
summary(lm1)
lm1pred<- predict(lm1, newdata=ds2)
lines(ds2$wYr, exp(lm1pred), lwd=2, lty=2)

#############################################################################
## IrwinStatesville UP p/b .0357/0.0216 mkp = 0.039
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[7])
ds$logQ <- log(ds$peak_va)

## Add water year column
ds$mo <- as.numeric(format(ds$peak_dt, "%m"))
ds$wYr <- as.numeric(NA)
for (i in 1:nrow(ds)) {
    if (ds$mo[i]>=10) {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y")) + 1
    } else {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y"))
    }
}
allYrs <- seq(min(ds$wYr), max(ds$wYr))
missingYrs <- allYrs[!(allYrs %in% ds$wYr)]

MannKendall(ds$peak_va) 

## p val and da
da <- attr(ds, "siteInfo")$drain_area_va
    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.02)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
axis(1, at=missingYrs, labels=FALSE, tck=.02, lwd=1, col="red")
mtext(2, text="Annual Max. Inst.", line=6, font=2, cex=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2, cex=1.1)
mtext(3, text="Irwin @ Statesville/Atando", font=2, cex=1.2, line=titleLine)
text(x=daYr, y=18000, labels=paste0("DA = ", da, " sq. mi"),
     font=2) 
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr[which(!(is.na(ds$peak_va)))], exp(lm1pred), lwd=2)

#############################################################################
## McMullenSharon UP, .0001/.01617, p/b mkp = 0.0002
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[3])
ds$logQ <- log(ds$peak_va)

## Add water year column
ds$mo <- as.numeric(format(ds$peak_dt, "%m"))
ds$wYr <- as.numeric(NA)
for (i in 1:nrow(ds)) {
    if (ds$mo[i]>=10) {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y")) + 1
    } else {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y"))
    }
}
MannKendall(ds$peak_va) 
allYrs <- seq(min(ds$wYr), max(ds$wYr))
missingYrs <- allYrs[!(allYrs %in% ds$wYr)]

## p val and da
da <- attr(ds, "siteInfo")$drain_area_va
    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.02)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
axis(1, at=missingYrs, labels=FALSE, tck=.02, lwd=1, col="red")
mtext(2, text="Annual Max. Inst.", line=6, font=2, cex=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2, cex=1.1)
mtext(3, text="McMullen @ Sharon View Rd.", font=2, cex=1.2, line=titleLine)
text(x=daYr, y=18000, labels=paste0("DA = ", da, " sq. mi"),
     font=2) 
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lwd=2)

#############################################################################
## LongPaw up .091/.0073 p/b mkp = 0.034
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[4])
ds$logQ <- log(ds$peak_va)

## Add water year column
ds$mo <- as.numeric(format(ds$peak_dt, "%m"))
ds$wYr <- as.numeric(NA)
for (i in 1:nrow(ds)) {
    if (ds$mo[i]>=10) {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y")) + 1
    } else {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y"))
    }
}
MannKendall(ds$peak_va) 
allYrs <- seq(min(ds$wYr), max(ds$wYr))
missingYrs <- allYrs[!(allYrs %in% ds$wYr)]

## p val and da
da <- attr(ds, "siteInfo")$drain_area_va

## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.02)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
axis(1, at=missingYrs, labels=FALSE, tck=.02, lwd=1, col="red")
mtext(2, text="Annual Max. Inst.", line=6, font=2, cex=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2, cex=1.1)
mtext(3, text="Long Creek @ Oakdale", font=2, cex=1.2, line=titleLine)
text(x=daYr, y=18000, labels=paste0("DA = ", da, " sq. mi"),
     font=2) 
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lwd=2)


#############################################################################
## Irwin1, UP, 0.00347/0.0098 p/B mkp = 0.0017
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[1])
ds$logQ <- log(ds$peak_va)

## Add water year column
ds$mo <- as.numeric(format(ds$peak_dt, "%m"))
ds$wYr <- as.numeric(NA)
for (i in 1:nrow(ds)) {
    if (ds$mo[i]>=10) {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y")) + 1
    } else {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y"))
    }
}
MannKendall(ds$peak_va) 
allYrs <- seq(min(ds$wYr), max(ds$wYr))
missingYrs <- allYrs[!(allYrs %in% ds$wYr)]

## p val and da
da <- attr(ds, "siteInfo")$drain_area_va

## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2, font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.02)
axis(1, at=seq(1958,2018,10), font=2, cex.axis=1.1)
axis(1, at=missingYrs, labels=FALSE, tck=.02, lwd=1, col="red")
mtext(2, text="Annual Max. Inst.", line=6, font=2, cex=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2, cex=1.1)
mtext(3, text="Irwin at CW/Billy Graham", font=2, cex=1.2, line=titleLine)
text(x=daYr, y=300, labels=paste0("DA = ", da, " sq. mi"),
     font=2) 
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lwd=2)

#############################################################################
## McAlpineSardis up, .1066/.0052 p/b mkp = 0.208
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[2])
ds$logQ <- log(ds$peak_va)

## Add water year column
ds$mo <- as.numeric(format(ds$peak_dt, "%m"))
ds$wYr <- as.numeric(NA)
for (i in 1:nrow(ds)) {
    if (ds$mo[i]>=10) {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y")) + 1
    } else {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y"))
    }
}
MannKendall(ds$peak_va) 
allYrs <- seq(min(ds$wYr), max(ds$wYr))
missingYrs <- allYrs[!(allYrs %in% ds$wYr)]


## p val and da
da <- attr(ds, "siteInfo")$drain_area_va

## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.02)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
axis(1, at=missingYrs, labels=FALSE, tck=.02, lwd=1, col="red")
mtext(2, text="Annual Max. Inst.", line=6, font=2, cex=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2, cex=1.1)
mtext(3, text="McAlpine @ Sardis Rd.", font=2, cex=1.2, line=titleLine)
text(x=daYr, y=300, labels=paste0("DA = ", da, " sq. mi"),
     font=2) 
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
## lines(ds$wYr, exp(lm1pred), lty=2, lwd=2)


#############################################################################
## LSArchdale up, 0.247/.0058 mkp = .305
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[6])
ds$logQ <- log(ds$peak_va)

## Add water year column
ds$mo <- as.numeric(format(ds$peak_dt, "%m"))
ds$wYr <- as.numeric(NA)
for (i in 1:nrow(ds)) {
    if (ds$mo[i]>=10) {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y")) + 1
    } else {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y"))
    }
}
MannKendall(ds$peak_va) 
allYrs <- seq(min(ds$wYr), max(ds$wYr))
missingYrs <- allYrs[!(allYrs %in% ds$wYr)]

## p val and da
da <- attr(ds, "siteInfo")$drain_area_va
    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.02)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
axis(1, at=missingYrs, labels=FALSE, tck=.02, lwd=1, col="red")
mtext(2, text="Annual Max. Inst.", line=6, font=2, cex=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2, cex=1.1)
mtext(3, text="Little Sugar @ Archdale", font=2, cex=1.2, line=titleLine)
text(x=daYr, y=300, labels=paste0("DA = ", da, " sq. mi"),
     font=2) 
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
## lines(ds$wYr, exp(lm1pred))

#############################################################################
## McAlpinePineville DOWN, .093/-0.0089 mkp = 0.098
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[5])
ds <- ds[2:44,] ## first year has an NA as peak flow
ds$logQ <- log(ds$peak_va)

## Add water year column
ds$mo <- as.numeric(format(ds$peak_dt, "%m"))
ds$wYr <- as.numeric(NA)
for (i in 1:nrow(ds)) {
    if (ds$mo[i]>=10) {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y")) + 1
    } else {
        ds$wYr[i] <- as.numeric(format(ds$peak_dt[i], "%Y"))
    }
}
MannKendall(ds$peak_va) 
allYrs <- seq(min(ds$wYr), max(ds$wYr))
missingYrs <- allYrs[!(allYrs %in% ds$wYr)]


## p val and da
da <- attr(ds, "siteInfo")$drain_area_va
    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.02)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
axis(1, at=missingYrs, labels=FALSE, tck=.02, lwd=1, col="red")
mtext(2, text="Annual Max. Inst.", line=6, font=2, cex=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2, cex=1.1)
mtext(3, text="McAlpine below McMullen", font=2, cex=1.2, line=titleLine)
text(x=daYr, y=300, labels=paste0("DA = ", da, " sq. mi"),
     font=2) 
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lty=2, lwd=2)


##

##
graphics.off()

## p vale and da

## Meta 
das <- c(2.63, 5.79, 6.95, 16.4, 30.7, 38.6, 42.6, 92.4)
bs <- c(0.0159, 0.0216, 0.01617, 0.0073, 0.0098, 0.0052, 0.0058, -.0089)
plot(das, bs)

lm1 <- lm(bs~das)
summary(lm1)
lm1pred<- predict(lm1)
lines(das, lm1pred, lty=2, lwd=2)



#############################################################################

yr100 <- data.frame(mins=seq(0,365,5),
                    depths=c(.000, .017, .017, .018, .018, .019, .020, .020,
                             .020, .021, .022, .022, .023, .023, .024, .025,
                             .026, .027, .028, .032, .034, .035, .037, .039,
                             .041, .053, .056, .060, .035, .071, .078, .113,
                             .126, .147, .226, .282, .555, .830, .386, .250,
                             .160, .136, .119, .082, .074, .068, .063, .058,
                             .055, .042, .040, .038, .036, .034, .033, .029,
                             .027, .026, .025, .025, .024, .023, .022, .022,
                             .021, .021, .020, .020, .019, .019, .018, .018,
                             .017, .000))

0.000
0.017
0.017
0.018
0.018
0.019
0.020
0.020
0.020
0.021
0.022
0.022
0.023
0.023
0.024
0.025
0.026
0.027
0.028
0.032
0.034
0.035
0.037
0.039
0.041
0.053
0.056
0.060
0.035
0.071
0.078
0.113
0.126
0.147
0.226
0.282
0.555
0.830
0.386
0.250
0.160
0.136
0.119
0.082
0.074
0.068
0.063
0.058
0.055
0.042
0.040
0.038
0.036
0.034
0.033
0.029
0.027
0.026
0.025
0.025
0.024
0.023
0.022
0.022
0.021
0.021
0.020
0.020
0.019
0.019
0.018
0.018
0.017
0.000
