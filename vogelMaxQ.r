######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("dataRetrieval")
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

par(mfrow=c(4,2),mai=c(.5,1,.5,.25), yaxs="i")
#############################################################################
## Irwin1, UP, 0.00347/0.0098 p/B
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[1])
ds$logQ <- log(ds$peak_va)

## Add water year column
monthFinal <- as.numeric(format(tail(ds$peak_dt,1), "%m"))
wyFinal <- ifelse(monthFinal<=8,
                  as.numeric(format(tail(ds$peak_dt,1), "%Y")),
                  as.numeric(format(tail(ds$peak_dt, 1), "%Y"))+1)
ds$wYr <- seq(wyFinal-nrow(ds)+1, wyFinal,1)
   
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2, font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.01)
axis(1, at=seq(1958,2018,10), font=2, cex.axis=1.1)
mtext(2, text="Streamflow, cfs", line=4.3, font=2)
mtext(3, text="Irwin at CW/Billy Graham", font=2, cex=1.2, line=titleLine)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lwd=2)

#############################################################################
## McAlpineSardis up, .1066/.0052 p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[2])
ds$logQ <- log(ds$peak_va)

## Add water year column
monthFinal <- as.numeric(format(tail(ds$peak_dt,1), "%m"))
wyFinal <- ifelse(monthFinal<=8,
                  as.numeric(format(tail(ds$peak_dt,1), "%Y")),
                  as.numeric(format(tail(ds$peak_dt, 1), "%Y"))+1)
ds$wYr <- seq(wyFinal-nrow(ds)+1, wyFinal,1)
    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.01)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
mtext(2, text="Streamflow, cfs", line=4.3, font=2)
mtext(3, text="McAlpine @ Sardis Rd.", font=2, cex=1.2, line=titleLine)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lty=2, lwd=2)

#############################################################################
## McMullenSharon UP, .0001/.01617, p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[3])
ds$logQ <- log(ds$peak_va)

## Add water year column
monthFinal <- as.numeric(format(tail(ds$peak_dt,1), "%m"))
wyFinal <- ifelse(monthFinal<=8,
                  as.numeric(format(tail(ds$peak_dt,1), "%Y")),
                  as.numeric(format(tail(ds$peak_dt, 1), "%Y"))+1)
ds$wYr <- seq(wyFinal-nrow(ds)+1, wyFinal,1)

    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.01)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
mtext(2, text="Streamflow, cfs", line=4.3, font=2)
mtext(3, text="McMullen @ Sharon View Rd.", font=2, cex=1.2, line=titleLine)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lwd=2)

#############################################################################
## LongPaw up .091/.0073 p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[4])
ds$logQ <- log(ds$peak_va)

## Add water year column
monthFinal <- as.numeric(format(tail(ds$peak_dt,1), "%m"))
wyFinal <- ifelse(monthFinal<=8,
                  as.numeric(format(tail(ds$peak_dt,1), "%Y")),
                  as.numeric(format(tail(ds$peak_dt, 1), "%Y"))+1)
ds$wYr <- seq(wyFinal-nrow(ds)+1, wyFinal,1)

    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.01)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
mtext(2, text="Streamflow, cfs", line=4.3, font=2)
mtext(3, text="Long Creek @ Oakdale", font=2, cex=1.2, line=titleLine)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lty=2, lwd=2)

#############################################################################
## McAlpinePineville DOWN, .093/-0.0089
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[5])
ds <- ds[2:44,] ## first year has an NA as peak flow
ds$logQ <- log(ds$peak_va)

## Add water year column
monthFinal <- as.numeric(format(tail(ds$peak_dt,1), "%m"))
wyFinal <- ifelse(monthFinal<=8,
                  as.numeric(format(tail(ds$peak_dt,1), "%Y")),
                  as.numeric(format(tail(ds$peak_dt, 1), "%Y"))+1)
ds$wYr <- seq(wyFinal-nrow(ds)+1, wyFinal,1)

    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.01)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
mtext(2, text="Streamflow, cfs", line=4.3, font=2)
mtext(3, text="McAlpine below McMullen", font=2, cex=1.2, line=titleLine)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred),lty=2, lwd=2)

#############################################################################
## LSArchdale up, 0.247/.0058
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[6])
ds$logQ <- log(ds$peak_va)

## Add water year column
monthFinal <- as.numeric(format(tail(ds$peak_dt,1), "%m"))
wyFinal <- ifelse(monthFinal<=8,
                  as.numeric(format(tail(ds$peak_dt,1), "%Y")),
                  as.numeric(format(tail(ds$peak_dt, 1), "%Y"))+1)
ds$wYr <- seq(wyFinal-nrow(ds)+1, wyFinal,1)

    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.01)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
mtext(2, text="Streamflow, cfs", line=4.3, font=2)
mtext(3, text="LSugar @ Archdale", font=2, cex=1.2, line=titleLine)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
## lines(ds$wYr, exp(lm1pred))

#############################################################################
## IrwinStatesville UP .0357/0.0216p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[7])
ds$logQ <- log(ds$peak_va)

## Add water year column
monthFinal <- as.numeric(format(tail(ds$peak_dt,1), "%m"))
wyFinal <- ifelse(monthFinal<=8,
                  as.numeric(format(tail(ds$peak_dt,1), "%Y")),
                  as.numeric(format(tail(ds$peak_dt, 1), "%Y"))+1)
ds$wYr <- seq(wyFinal-nrow(ds)+1, wyFinal,1)

    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.01)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
mtext(2, text="Streamflow, cfs", line=4.3, font=2)
mtext(3, text="Irwin @ Statesville/Atando", font=2, cex=1.2, line=titleLine)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr[which(!(is.na(ds$peak_va)))], exp(lm1pred), lwd=2)

#############################################################################
## LittleHope UP .0447/0.0159 p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[8])
ds$logQ <- log(ds$peak_va)

## Add water year column
monthFinal <- as.numeric(format(tail(ds$peak_dt,1), "%m"))
wyFinal <- ifelse(monthFinal<=8,
                  as.numeric(format(tail(ds$peak_dt,1), "%Y")),
                  as.numeric(format(tail(ds$peak_dt, 1), "%Y"))+1)
ds$wYr <- seq(wyFinal-nrow(ds)+1, wyFinal,1)

    
## Plot, look at summary stats
plot(ds$wYr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(yMin,yMax), xlim=c(xMin,xMax),xlab=NA, ylab=NA)
axis(side=2, at=c(100,1000,10000), las=2,font=2, cex.axis=1.2)
axis(side=2, at=logSpace(100,3), labels=FALSE, tck=-.01)
axis(1, at=seq(1958,2018,10),font=2, cex.axis=1.2)
mtext(2, text="Streamflow, cfs", line=4.3, font=2)
mtext(3, text="Little Hope @ Seneca", font=2, cex=1.2, line=titleLine)
box()

## Fit regressions to ln values
lm1 <- lm(logQ~wYr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$wYr, exp(lm1pred), lwd=2)

## p vale and da
da <- attr(ds, "siteInfo")$drain_area_va

## get p value
## put both on plots


