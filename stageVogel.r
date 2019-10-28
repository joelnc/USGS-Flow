######################### CLEAR STUFF #######################################
rm(list=ls())
graphics.off()
library("dataRetrieval")

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
## Irwin1, up, 0.003575/0.0097 p/B
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[1])
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)

## Plot, look at summary stats
plot(ds$yr, ds$peak_va, log="y", ylog=TRUE, axes=FALSE,
     ylim=c(1000,20000))
axis(side=2, at=c(1000,10000), las=2)
box()
## plot(ds$yr, ds$logQ)
## plot(ds$yr, ds$gage_ht)


## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)
lm1pred<- predict(lm1)
lines(ds$yr, exp(lm1pred))

#############################################################################
## McAlpineSardis up, .114/.0051 p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[2])
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)

## Plot, look at summary stats
plot(ds$yr, ds$peak_va)
plot(ds$yr, ds$logQ, ylim=c(6,10))

## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)

#############################################################################
## McMullenSharon UP, .0001/.016323, p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[3])
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)

## Plot, look at summary stats
## plot(ds$yr, ds$peak_va)
plot(ds$yr, ds$logQ, ylim=c(6,10))

## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)

#############################################################################
## LongPaw up .099/.0071 p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[4])
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)

## Plot, look at summary stats
## plot(ds$yr, ds$peak_va)
plot(ds$yr, ds$logQ, ylim=c(6,10))

## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)

#############################################################################
## McAlpinePineville down, .088/-0.009
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[5])
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)

## Plot, look at summary stats
## plot(ds$yr, ds$peak_va)
plot(ds$yr, ds$logQ, ylim=c(6,10))

## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)

#############################################################################
## LSArchdale up, 0.23/.0059
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[6])
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)

## Plot, look at summary stats
## plot(ds$yr, ds$peak_va)
plot(ds$yr, ds$logQ, ylim=c(6,10))

## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)

#############################################################################
## IrwinStatesville up .022/0.0188 p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[7])
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)

## Plot, look at summary stats
## plot(ds$yr, ds$peak_va)
plot(ds$yr, ds$logQ, ylim=c(6,10))

## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)

#############################################################################
## LittleHope up .036/0.0113 p/b
ds <- readNWISpeak(siteNumbers=usgsCodes$usgsCode[8])
ds$yr <- as.numeric(format(ds$peak_dt, "%Y"))
ds$logQ <- log(ds$peak_va)

## Plot, look at summary stats
## plot(ds$yr, ds$peak_va)
plot(ds$yr, ds$logQ)

## Fit regressions to ln values
lm1 <- lm(logQ~yr, data=ds)
summary(lm1)





