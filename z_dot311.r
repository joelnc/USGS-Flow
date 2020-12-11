library(dplyr)
rm(list=ls())

## go to loop, stormwater, cityworks swtp reports, request summary report, dropdown, csv

ds <- read.csv("USGS-Flow/311.csv", header=TRUE, stringsAsFactors=FALSE)
ds$DateIn <- as.Date(ds$DATETIMEINIT1, "%m/%d/%Y")
ds$yr <- as.numeric(format(ds$DateIn, "%Y"))
ds <- ds[ds$yr!=1979,]
ds <- ds[ds$yr!=1953,]
ds <- ds[ds$yr!=1909,]

## Flooding related
dsF <- ds %>%
    filter(RequestType1 %in% c("Flooding","CDOT Flooding"))

## Hist of flooding calls per year
hist(dsF$yr,breaks=seq(1992,2019))

## hist of all calls per year
dev.new()
hist(ds$yr, breaks=seq(1992,2019))

## proportion of calls as flooding
dsFlood <- data.frame(yr=seq(1992, 2019), calls=rep(NA,28), fCalls=rep(NA,28),
                  fProp=rep(NA, 28), stringsAsFactors=FALSE)

for (i in 1:nrow(dsFlood)) {
    dsFlood$calls[i] <- length(which(ds$yr==dsFlood$yr[i]))
    dsFlood$fCalls[i] <- length(which(ds$RequestType1 %in% c("Flooding", "CDOT Flooding") &
                                  ds$yr==dsFlood$yr[i]))
}
dsFlood$fProp <- dsFlood$fCalls/dsFlood$calls

dev.new()

## PNG
png(file="USGS-Flow/311Floods.png", height=2.8, width=3.2,
   units="in", res=500)
## dev.new(height=2.8, width=3.2,units="in")
## plot(dsFlood$yr, dsFlood$fProp, axes=FALSE, xlab=NA, ylab=NA)
par(yaxs="i", mai=c(.3,.7,.4,.7))
hist(dsF$yr, breaks=seq(1991,2019), ylim=c(0,2000), col="grey",
     axes=FALSE, xlab=NA, ylab=NA, main=NA)
box()
## ax 1
axis(1,at=seq(1992,2019,1), labels=FALSE, tck=-.04)
axis(1,at=c(1992,1999,2009,2019), labels=FALSE, tck=-.07)
mtext(text=c(1992,1999,2009,2019), side=1, at=c(1992,1999,2009,2019,5),
      cex=.8, font=2, line=.35)
## ax 2
axis(2, at=seq(0,2000,500), labels=FALSE, tck=-.04) ##las=2, font=2, cex.axis=.8, gap.axis=.1)
mtext(text=seq(0,2000,500), at=seq(0,2000,500), side=2, font=2,
      las=2,line=.5,cex=.8)
mtext(text="Number of Flooding Calls", side=2, line=2.3, font=2, cex=1.1)
par(new=TRUE)
plot(dsFlood$yr, dsFlood$fProp, xlim=c(1992,2019),
     pch=16, col="darkred", cex=.8,
     axes=FALSE, xlab=NA, ylab=NA, ylim=c(0,.5))
## ax 4
axis(4, at=c(0,.1,.2,.3,.4,.5),
     labels=FALSE, tck=-.04) ## c("0%", "10%", "20%", "30%", "40%", "50%"),
     ## las=2, font=2, col.axis="darkred", cex.axis=.8)
mtext(text=c("0%", "10%", "20%", "30%", "40%", "50%"),
      side=4, at=c(0,.1,.2,.3,.4,.5), font=2, las=2, line=.5,
      cex=.8, col="darkred")
mtext(text="Percent of All Calls", side=4, line=2, font=2, cex=1.1, col="darkred")
mtext(text="311 Calls - Flooding / CDOT Flooding", side=3, line=1,
      font=2, cex=1)
graphics.off()

#############################################################################
## proportion of calls as blockage
## blockage related
dsB <- ds %>%
    filter(RequestType1=="Blockage")

dsBlock <- data.frame(yr=seq(1992, 2019), calls=rep(NA,28), fCalls=rep(NA,28),
                  fProp=rep(NA, 28), stringsAsFactors=FALSE)

for (i in 1:nrow(dsBlock)) {
    dsBlock$calls[i] <- length(which(ds$yr==dsBlock$yr[i]))
    dsBlock$fCalls[i] <- length(which(ds$RequestType1=="Blockage" &
                                  ds$yr==dsBlock$yr[i]))
}
dsBlock$fProp <- dsBlock$fCalls/dsBlock$calls


## PNG
png(file="USGS-Flow/311Blockage.png", height=2.8, width=3.2,
   units="in", res=500)
## dev.new(height=2.8, width=3.2,units="in")
## plot(dsFlood$yr, dsFlood$fProp, axes=FALSE, xlab=NA, ylab=NA)
par(yaxs="i", mai=c(.3,.7,.4,.7))
hist(dsB$yr, breaks=seq(1991,2019), ylim=c(0,2000), col="grey",
     axes=FALSE, xlab=NA, ylab=NA, main=NA)
box()
## ax 1
axis(1,at=seq(1992,2019,1), labels=FALSE, tck=-.04)
axis(1,at=c(1992,1999,2009,2019), labels=FALSE, tck=-.07)
mtext(text=c(1992,1999,2009,2019), side=1, at=c(1992,1999,2009,2019,5),
      cex=.8, font=2, line=.35)
## ax 2
axis(2, at=seq(0,2000,500), labels=FALSE, tck=-.04) ##las=2, font=2, cex.axis=.8, gap.axis=.1)
mtext(text=seq(0,2000,500), at=seq(0,2000,500), side=2, font=2,
      las=2,line=.5,cex=.8)
mtext(text="Number of Blockage Calls", side=2, line=2.3, font=2, cex=1.1)
par(new=TRUE)
plot(dsBlock$yr, dsBlock$fProp, xlim=c(1992,2019),
     pch=16, col="darkred", cex=.8,
     axes=FALSE, xlab=NA, ylab=NA, ylim=c(0,.5))
## ax 4
axis(4, at=c(0,.1,.2,.3,.4,.5),
     labels=FALSE, tck=-.04) ## c("0%", "10%", "20%", "30%", "40%", "50%"),
     ## las=2, font=2, col.axis="darkred", cex.axis=.8)
mtext(text=c("0%", "10%", "20%", "30%", "40%", "50%"),
      side=4, at=c(0,.1,.2,.3,.4,.5), font=2, las=2, line=.5,
      cex=.8, col="darkred")
mtext(text="Percent of All Calls", side=4, line=2, font=2, cex=1.1, col="darkred")
mtext(text="311 Calls - Blockages", side=3, line=1,
      font=2, cex=1)
graphics.off()



dev.new()    
## plot(dsBlock$yr, dsBlock$fProp)
## plot(dsFlood$yr, dsFlood$fProp, axes=FALSE, xlab=NA, ylab=NA)
par(yaxs="i", mai=c(.5,1.25,.75,1.25))
hist(dsB$yr, breaks=seq(1991,2019), ylim=c(0,2000), col="grey",
     axes=FALSE, xlab=NA, ylab=NA, main=NA)
box()
axis(1,at=seq(1991,2019), font=2)
axis(2, at=seq(0,2000,500), las=2, font=2)
par(new=TRUE)
plot(dsBlock$yr, dsBlock$fProp, xlim=c(1992,2019),
     pch=16, col="darkred",
     axes=FALSE, xlab=NA, ylab=NA, ylim=c(0,.5))
axis(4, at=c(0,.1,.2,.3,.4,.5),
     labels=c("0%", "10%", "20%", "30%", "40%", "50%"),
     las=2, font=2,col.axis="darkred")
mtext(text="Number of Blockage Calls", side=2, line=4, font=2, cex=1.7)
mtext(text="Percent of All Calls", side=4, line=4, font=2, cex=1.7,
      col="darkred",)
mtext(text="311 Calls - Blockage", side=3, line=1.2,
      font=2, cex=2.1)

#############################################################################
## proportion of calls as erosion
## blockage related
dsE <- ds %>%
    filter(RequestType1=="Erosion")

dsErosion <- data.frame(yr=seq(1992, 2019), calls=rep(NA,28), fCalls=rep(NA,28),
                  fProp=rep(NA, 28), stringsAsFactors=FALSE)

for (i in 1:nrow(dsErosion)) {
    dsErosion$calls[i] <- length(which(ds$yr==dsErosion$yr[i]))
    dsErosion$fCalls[i] <- length(which(ds$RequestType1=="Erosion" &
                                  ds$yr==dsErosion$yr[i]))
}
dsErosion$fProp <- dsErosion$fCalls/dsErosion$calls

dev.new()    
par(yaxs="i", mai=c(.5,1.25,.75,1.25))
hist(dsE$yr, breaks=seq(1991,2019), ylim=c(0,2000), col="grey",
     axes=FALSE, xlab=NA, ylab=NA, main=NA)
box()
axis(1,at=seq(1991,2019), font=2)
axis(2, at=seq(0,2000,500), las=2, font=2)
par(new=TRUE)
plot(dsErosion$yr, dsErosion$fProp, xlim=c(1992,2019),
     pch=16, col="darkred",
     axes=FALSE, xlab=NA, ylab=NA, ylim=c(0,.5))
axis(4, at=c(0,.1,.2,.3,.4,.5),
     labels=c("0%", "10%", "20%", "30%", "40%", "50%"),
     las=2, font=2,col.axis="darkred")
mtext(text="Number of Erosion Calls", side=2, line=4, font=2, cex=1.7)
mtext(text="Percent of All Calls", side=4, line=4, font=2, cex=1.7,
      col="darkred",)
mtext(text="311 Calls - Erosion", side=3, line=1.2,
      font=2, cex=2.1)




