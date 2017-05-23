######################### CLEAR STUFF ##########################################
rm(list=ls())
graphics.off()

## IDA data should be static, but will periodically need to update newer data
## via NWIS.  So, replace NWIS txt files with data retrival calls, then joins
## to ida text.  I.e., flow can sit ready to use, and be upadated as needed
## with the single function call.


#############################################################################
######################### Sites DF  #########################################

#############################################################################
#################### MC14A Long Creek @ Pine/Rhyne 0214291555 ###############
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC14A <- read.table(file="textfiles/0214291555_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC14A$dt <- rep(as.POSIXct(NA), nrow(siteMC14A))
siteMC14A$tz <- rep(as.character(NA), nrow(siteMC14A))

siteMC14A$tz[1:241489] <- c("America/Panama")
siteMC14A$tz[241490:312208] <- c("America/New_York")

siteMC14A$dt[1:241489] <- as.POSIXct(siteMC14A$dtNum[1:241489],
                                     tz=siteMC14A$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC14A$dt[241490:312208] <- as.POSIXct(siteMC14A$dtNum[241490:312208],
                                     tz=siteMC14A$tz[241490],
                                     format="%Y%m%d%H%M%S")

siteMC14A$dt <- as.POSIXct(format(siteMC14A$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC14A <- siteMC14A[,c("site","dt","cfs")]

save(siteMC14A,file="rdata/siteMC14A_ida.Rdata")

#############################################################################
#################### MC17 Paw 0214295600 ####################################
rm(list=ls())
siteMC17 <- read.table(file="textfiles/0214295600_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC17$dt <- rep(as.POSIXct(NA), nrow(siteMC17))
siteMC17$tz <- rep(as.character(NA), nrow(siteMC17))

siteMC17$tz[1:363520] <- c("America/Panama")
siteMC17$tz[363521:427669] <- c("America/New_York")

siteMC17$dt[1:363520] <- as.POSIXct(siteMC17$dtNum[1:363520],
                                     tz=siteMC17$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC17$dt[363521:427669] <- as.POSIXct(siteMC17$dtNum[363521:427669],
                                     tz=siteMC17$tz[363521],
                                     format="%Y%m%d%H%M%S")

siteMC17$dt <- as.POSIXct(format(siteMC17$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC17 <- siteMC17[,c("site","dt","cfs")]

save(siteMC17,file="rdata/siteMC17_ida.Rdata")

#############################################################################
#################### MC22A Irwin 02146300 ########################
rm(list=ls())
## Load in earlier flat file from IDA
MC22Aa <- read.table(file="textfiles/02146300_ida_1.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

## Load in later flat file from IDA
#### EDT Switch on 10-01-2005 ####
MC22Ab <- read.table(file="textfiles/02146300_ida_2.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("numeric",4)))

## Rbind files into 1 df
siteMC22A <- rbind(MC22Aa, MC22Ab)

## Initialize columns as.Posix dt and tz flag
siteMC22A$dt <- rep(as.POSIXct(NA), nrow(siteMC22A))
siteMC22A$tz <- rep(as.character(NA), nrow(siteMC22A))

## Manually id row when thing switch, write in tz
siteMC22A$tz[1:651695] <- c("America/Panama")
siteMC22A$tz[651696:720709] <- c("America/New_York")

## Using manual row ids, format to posixct
siteMC22A$dt[1:651695] <- as.POSIXct(siteMC22A$dtNum[1:651695],
                                     tz=siteMC22A$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC22A$dt[651696:720709] <- as.POSIXct(siteMC22A$dtNum[651696:720709],
                                     tz=siteMC22A$tz[651696],
                                     format="%Y%m%d%H%M%S")

## Now format the whole thing to Eastern time, drop unneeded cols
siteMC22A$dt <- as.POSIXct(format(siteMC22A$dt, tz="America/New_York",
                                 usetz=TRUE))

siteMC22A <- siteMC22A[,c("site","dt","cfs")]

## Save to an .rdata
save(siteMC22A,file="rdata/siteMC22A_ida.Rdata")

#############################################################################
#################### MC25 Coffey 02146348 ###################################
rm(list=ls())
siteMC25 <- read.table(file="textfiles/02146348_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC25$dt <- rep(as.POSIXct(NA), nrow(siteMC25))
siteMC25$tz <- rep(as.character(NA), nrow(siteMC25))

siteMC25$tz[1:230966] <- c("America/Panama")
siteMC25$tz[230967:301650] <- c("America/New_York")

siteMC25$dt[1:230966] <- as.POSIXct(siteMC25$dtNum[1:230966],
                                     tz=siteMC25$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC25$dt[230967:301650] <- as.POSIXct(siteMC25$dtNum[230967:301650],
                                     tz=siteMC25$tz[230967],
                                     format="%Y%m%d%H%M%S")

siteMC25$dt <- as.POSIXct(format(siteMC25$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC25 <- siteMC25[,c("site","dt","cfs")]

save(siteMC25,file="rdata/siteMC25_ida.Rdata")

#############################################################################
#################### MC27 Sugar Creek 02146381 ##############################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC27 <- read.table(file="textfiles/02146381_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC27$dt <- rep(as.POSIXct(NA), nrow(siteMC27))
siteMC27$tz <- rep(as.character(NA), nrow(siteMC27))

siteMC27$tz[1:380394] <- c("America/Panama")
siteMC27$tz[380395:450265] <- c("America/New_York")

siteMC27$dt[1:380394] <- as.POSIXct(siteMC27$dtNum[1:380394],
                                     tz=siteMC27$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC27$dt[380395:450265] <- as.POSIXct(siteMC27$dtNum[380395:450265],
                                     tz=siteMC27$tz[380395],
                                     format="%Y%m%d%H%M%S")

siteMC27$dt <- as.POSIXct(format(siteMC27$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC27 <- siteMC27[,c("site","dt","cfs")]

save(siteMC27,file="rdata/siteMC27_ida.Rdata")


#############################################################################
#################### MC29A1 Little Sugar 02146409 ###########################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC29A1 <- read.table(file="textfiles/02146409_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC29A1$dt <- rep(as.POSIXct(NA), nrow(siteMC29A1))
siteMC29A1$tz <- rep(as.character(NA), nrow(siteMC29A1))

siteMC29A1$tz[1:380475] <- c("America/Panama")
siteMC29A1$tz[380476:449957] <- c("America/New_York")

siteMC29A1$dt[1:380475] <- as.POSIXct(siteMC29A1$dtNum[1:380475],
                                     tz=siteMC29A1$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC29A1$dt[380476:449957] <- as.POSIXct(siteMC29A1$dtNum[380476:449957],
                                     tz=siteMC29A1$tz[380476],
                                     format="%Y%m%d%H%M%S")

siteMC29A1$dt <- as.POSIXct(format(siteMC29A1$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC29A1 <- siteMC29A1[,c("site","dt","cfs")]

save(siteMC29A1,file="rdata/siteMC29A1_ida.Rdata")

#############################################################################
#################### MC30A Edwards Branch 0214643820 ########################
## Data starts on EDT Switch 10-01-2005, clean import
rm(list=ls())
siteMC30A <- read.table(file="textfiles/0214643820_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC30A$dt <- rep(as.POSIXct(NA), nrow(siteMC30A))
siteMC30A$tz <- rep("America/New_York", nrow(siteMC30A))

siteMC30A$dt <- as.POSIXct(siteMC30A$dtNum,
                           tz="America/New_York", format="%Y%m%d%H%M%S")

siteMC30A$dt <- as.POSIXct(format(siteMC30A$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC30A <- siteMC30A[,c("site","dt","cfs")]

save(siteMC30A,file="rdata/siteMC30A_ida.Rdata")

#############################################################################
#################### MC33 Briar 0214645022 ##################################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC33 <- read.table(file="textfiles/0214645022_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC33$dt <- rep(as.POSIXct(NA), nrow(siteMC33))
siteMC33$tz <- rep(as.character(NA), nrow(siteMC33))

siteMC33$tz[1:339895] <- c("America/Panama")
siteMC33$tz[339896:408212] <- c("America/New_York")

siteMC33$dt[1:339895] <- as.POSIXct(siteMC33$dtNum[1:339895],
                                     tz=siteMC33$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC33$dt[339896:408212] <- as.POSIXct(siteMC33$dtNum[339896:408212],
                                     tz=siteMC33$tz[339896],
                                     format="%Y%m%d%H%M%S")

siteMC33$dt <- as.POSIXct(format(siteMC33$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC33 <- siteMC33[,c("site","dt","cfs")]

save(siteMC33,file="rdata/siteMC33_ida.Rdata")

#############################################################################
#################### MC38 McAlpine Upper 02146600 ###########################
## Load in earlier flat file from IDA
MC38a <- read.table(file="textfiles/02146600_ida_1.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

## Load in later flat file from IDA
#### EDT Switch on 10-01-2005 ####
MC38b <- read.table(file="textfiles/02146600_ida_2.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("numeric",4)))

## Rbind files into 1 df
siteMC38 <- rbind(MC38a, MC38b)

## Initialize columns as.Posix dt and tz flag
siteMC38$dt <- rep(as.POSIXct(NA), nrow(siteMC38))
siteMC38$tz <- rep(as.character(NA), nrow(siteMC38))

## Manually id row when thing switch, write in tz
siteMC38$tz[1:1028343] <- c("America/Panama")
siteMC38$tz[1028344:1097734] <- c("America/New_York")

## Using manual row ids, format to posixct
siteMC38$dt[1:1028343] <- as.POSIXct(siteMC38$dtNum[1:1028343],
                                     tz=siteMC38$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC38$dt[1028344:1097734] <- as.POSIXct(siteMC38$dtNum[1028344:1097734],
                                     tz=siteMC38$tz[1028344],
                                     format="%Y%m%d%H%M%S")

## Now format the whole thing to Eastern time, drop unneeded cols
siteMC38$dt <- as.POSIXct(format(siteMC38$dt, tz="America/New_York",
                                 usetz=TRUE))

siteMC38 <- siteMC38[,c("site","dt","cfs")]

## Save to an .rdata
save(siteMC38,file="rdata/siteMC38_ida.Rdata")

#############################################################################
#################### MC40A Fourmile 02146670 ################################
## Data ends before EDT switch
rm(list=ls())
siteMC40A <- read.table(file="textfiles/02146670_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC40A$dt <- rep(as.POSIXct(NA), nrow(siteMC40A))
siteMC40A$tz <- rep("America/Panama", nrow(siteMC40A))

siteMC40A$dt <- as.POSIXct(siteMC40A$dtNum,
                           tz="America/Panama", format="%Y%m%d%H%M%S")

siteMC40A$dt <- as.POSIXct(format(siteMC40A$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC40A <- siteMC40A[,c("site","dt","cfs")]

save(siteMC40A,file="rdata/siteMC40A_ida.Rdata")


#############################################################################
#################### MC42 McMullen  02146700 ################################
rm(list=ls())
## Load in earlier flat file from IDA
MC42a <- read.table(file="textfiles/02146700_ida_1.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

## Load in later flat file from IDA
#### EDT Switch on 10-01-2005 ####
MC42b <- read.table(file="textfiles/02146700_ida_2.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("numeric",4)))

## Rbind files into 1 df
siteMC42 <- rbind(MC42a, MC42b)

## Initialize columns as.Posix dt and tz flag
siteMC42$dt <- rep(as.POSIXct(NA), nrow(siteMC42))
siteMC42$tz <- rep(as.character(NA), nrow(siteMC42))

## Manually id row when thing switch, write in tz
siteMC42$tz[1:644802] <- c("America/Panama")
siteMC42$tz[644803:713031] <- c("America/New_York")

## Using manual row ids, format to posixct
siteMC42$dt[1:644802] <- as.POSIXct(siteMC42$dtNum[1:644802],
                                     tz=siteMC42$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC42$dt[644803:713031] <- as.POSIXct(siteMC42$dtNum[644803:713031],
                                     tz=siteMC42$tz[644803],
                                     format="%Y%m%d%H%M%S")

## Now format the whole thing to Eastern time, drop unneeded cols
siteMC42$dt <- as.POSIXct(format(siteMC42$dt, tz="America/New_York",
                                 usetz=TRUE))

siteMC42 <- siteMC42[,c("site","dt","cfs")]

## Save to an .rdata
save(siteMC42,file="rdata/siteMC42_ida.Rdata")

#############################################################################
#################### MC45 McAlpine Lower 02146750 ###########################
rm(list=ls())
MC45a <- read.table(file="textfiles/02146750_ida_1.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))
## 1997....
MC45a2 <- read.table(file="textfiles/02146750_ida_1b.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))
## drop first and last reading which dup other files
MC45a2 <- MC45a2[2:105112,]
## EDT Switch on 10-01-2005
MC45b <- read.table(file="textfiles/02146750_ida_2.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("numeric",4)))

siteMC45 <- rbind(MC45a, MC45a2, MC45b)

siteMC45$dt <- rep(as.POSIXct(NA), nrow(siteMC45))
siteMC45$tz <- rep(as.character(NA), nrow(siteMC45))
siteMC45$tz[1:1007684] <- c("America/Panama")
siteMC45$tz[1007685:1069663] <- c("America/New_York")
siteMC45$dt[1:1007684] <- as.POSIXct(siteMC45$dtNum[1:1007684],
                                     tz=siteMC45$tz[1],
                                     format="%Y%m%d%H%M%S")
siteMC45$dt[1007685:1069663] <- as.POSIXct(siteMC45$dtNum[1007685:1069663],
                                     tz=siteMC45$tz[1007685],
                                     format="%Y%m%d%H%M%S")
siteMC45$dt <- as.POSIXct(format(siteMC45$dt, tz="America/New_York",
                                 usetz=TRUE))
siteMC45 <- siteMC45[,c("site","dt","cfs")]

save(siteMC45, file="rdata/siteMC45_ida.Rdata")

#############################################################################
#################### MC45B McAlpine SC 0214676115 ###########################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC45B <- read.table(file="textfiles/0214676115_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))
#### NOTE Only 1 year of IDA data, all EDT time
siteMC45B$dt <- rep(as.POSIXct(NA), nrow(siteMC45B))

siteMC45B$dt <- as.POSIXct(siteMC45B$dtNum, tz="America/New_York",
                           format="%Y%m%d%H%M%S")
siteMC45B <- siteMC45B[,c("site","dt","cfs")]

save(siteMC45B,file="rdata/siteMC45B_ida.Rdata")

#############################################################################
#################### MC47A Steele 0214678175 ################################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC47A <- read.table(file="textfiles/0214678175_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC47A$dt <- rep(as.POSIXct(NA), nrow(siteMC47A))
siteMC47A$tz <- rep(as.character(NA), nrow(siteMC47A))

siteMC47A$tz[1:257564] <- c("America/Panama")
siteMC47A$tz[257565:326779] <- c("America/New_York")

siteMC47A$dt[1:257564] <- as.POSIXct(siteMC47A$dtNum[1:257564],
                                     tz=siteMC47A$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC47A$dt[257565:326779] <- as.POSIXct(siteMC47A$dtNum[257565:326779],
                                     tz=siteMC47A$tz[257565],
                                     format="%Y%m%d%H%M%S")

siteMC47A$dt <- as.POSIXct(format(siteMC47A$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC47A <- siteMC47A[,c("site","dt","cfs")]

save(siteMC47A,file="rdata/siteMC47A_ida.Rdata")

#############################################################################
#################### MC49A LSC 02146530 #####################################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC49A <- read.table(file="textfiles/02146530_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC49A$dt <- rep(as.POSIXct(NA), nrow(siteMC49A))
siteMC49A$tz <- rep(as.character(NA), nrow(siteMC49A))

siteMC49A$tz[1:287512] <- c("America/Panama")
siteMC49A$tz[287513:358616] <- c("America/New_York")

siteMC49A$dt[1:287512] <- as.POSIXct(siteMC49A$dtNum[1:287512],
                                     tz=siteMC49A$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC49A$dt[287513:358616] <- as.POSIXct(siteMC49A$dtNum[287513:358616],
                                     tz=siteMC49A$tz[287513],
                                     format="%Y%m%d%H%M%S")

siteMC49A$dt <- as.POSIXct(format(siteMC49A$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC49A <- siteMC49A[,c("site","dt","cfs")]

save(siteMC49A,file="rdata/siteMC49A_ida.Rdata")

#############################################################################
#################### MC50 Gar 0214266080 ####################################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC50 <- read.table(file="textfiles/0214266080_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC50$dt <- rep(as.POSIXct(NA), nrow(siteMC50))
siteMC50$tz <- rep(as.character(NA), nrow(siteMC50))

siteMC50$tz[1:99175] <- c("America/Panama")
siteMC50$tz[99176:170321] <- c("America/New_York")

siteMC50$dt[1:99175] <- as.POSIXct(siteMC50$dtNum[1:99175],
                                     tz=siteMC50$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC50$dt[99176:170321] <- as.POSIXct(siteMC50$dtNum[99176:170321],
                                     tz=siteMC50$tz[99176],
                                     format="%Y%m%d%H%M%S")

siteMC50$dt <- as.POSIXct(format(siteMC50$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC50 <- siteMC50[,c("site","dt","cfs")]

save(siteMC50,file="rdata/siteMC50_ida.Rdata")

#############################################################################
#################### MC51 Six Mile 0214685800 ###############################
## No IDA

#############################################################################
#################### MC66 Beaverdam 0214297160 #############################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC66 <- read.table(file="textfiles/0214297160_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

## Has some weird NA crap near the end... drop
siteMC66 <- siteMC66[!is.na(siteMC66$dd),]

siteMC66$dt <- rep(as.POSIXct(NA), nrow(siteMC66))
siteMC66$tz <- rep(as.character(NA), nrow(siteMC66))

siteMC66$tz[1:93092] <- c("America/Panama")
siteMC66$tz[93093:161757] <- c("America/New_York")

siteMC66$dt[1:93092] <- as.POSIXct(siteMC66$dtNum[1:93092],
                                     tz=siteMC66$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC66$dt[93093:161757] <- as.POSIXct(siteMC66$dtNum[93093:161757],
                                     tz=siteMC66$tz[93093],
                                     format="%Y%m%d%H%M%S")

siteMC66$dt <- as.POSIXct(format(siteMC66$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC66 <- siteMC66[,c("site","dt","cfs")]

save(siteMC66,file="rdata/siteMC66_ida.Rdata")

#############################################################################
#################### MY11B Mallard 0212414900 ###############################
rm(list=ls())
siteMY11B <- read.table(file="textfiles/0212414900_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMY11B$dt <- rep(as.POSIXct(NA), nrow(siteMY11B))
siteMY11B$tz <- rep(as.character(NA), nrow(siteMY11B))

siteMY11B$tz[1:356823] <- c("America/Panama")
siteMY11B$tz[356824:426971] <- c("America/New_York")

siteMY11B$dt[1:356823] <- as.POSIXct(siteMY11B$dtNum[1:356823],
                                     tz=siteMY11B$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMY11B$dt[356824:426971] <- as.POSIXct(siteMY11B$dtNum[356824:426971],
                                     tz=siteMY11B$tz[356824],
                                     format="%Y%m%d%H%M%S")

siteMY11B$dt <- as.POSIXct(format(siteMY11B$dt, tz="America/New_York",
                                usetz=TRUE))
siteMY11B <- siteMY11B[,c("site","dt","cfs")]

save(siteMY11B,file="rdata/siteMY11B_ida.Rdata")

#############################################################################
#################### MY12B Back 02124269 ####################################
## No IDA

#############################################################################
#################### MY13 Reedy 0212430293 ##################################
## No IDA

#############################################################################
#################### MY13A Reedy Plaza Rd 0212427947 ########################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMY13A <- read.table(file="textfiles/0212427947_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

## Has some weird NA crap near the end... drop
siteMY13A <- siteMY13A[!is.na(siteMY13A$dd),]

siteMY13A$dt <- rep(as.POSIXct(NA), nrow(siteMY13A))
siteMY13A$tz <- rep(as.character(NA), nrow(siteMY13A))

siteMY13A$tz[1:133890] <- c("America/Panama")
siteMY13A$tz[133891:204090] <- c("America/New_York")

siteMY13A$dt[1:133890] <- as.POSIXct(siteMY13A$dtNum[1:133890],
                                     tz=siteMY13A$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMY13A$dt[133891:204090] <- as.POSIXct(siteMY13A$dtNum[133891:204090],
                                     tz=siteMY13A$tz[133891],
                                     format="%Y%m%d%H%M%S")

siteMY13A$dt <- as.POSIXct(format(siteMY13A$dt, tz="America/New_York",
                                usetz=TRUE))
siteMY13A <- siteMY13A[,c("site","dt","cfs")]

save(siteMY13A,file="rdata/siteMY13A_ida.Rdata")

#################### MY7B McKee 0212430653 ##################################
## No IDA data

#############################################################################
#################### MC4 McDowell @ Beaties Ford 0214266000 #################
## EDT Switch on 10-01-2005
rm(list=ls())
siteMC4 <- read.table(file="textfiles/0214266000_ida.txt",
    sep="", header=FALSE, skip=67, fill=TRUE, as.is=TRUE,
    col.names=c("site", "dtNum", "TZ", "dd", "acCode", "cfs", "prec"),
    colClasses=c(rep("character",3), rep("integer",2), "double",
                 "integer"))

siteMC4$dt <- rep(as.POSIXct(NA), nrow(siteMC4))
siteMC4$tz <- rep(as.character(NA), nrow(siteMC4))

siteMC4$tz[1:535050] <- c("America/Panama")
siteMC4$tz[535051:602509] <- c("America/New_York")

siteMC4$dt[1:535050] <- as.POSIXct(siteMC4$dtNum[1:535050],
                                     tz=siteMC4$tz[1],
                                     format="%Y%m%d%H%M%S")

siteMC4$dt[535051:602509] <- as.POSIXct(siteMC4$dtNum[535051:602509],
                                     tz=siteMC4$tz[535051],
                                     format="%Y%m%d%H%M%S")

siteMC4$dt <- as.POSIXct(format(siteMC4$dt, tz="America/New_York",
                                usetz=TRUE))
siteMC4 <- siteMC4[,c("site","dt","cfs")]

save(siteMC4,file="rdata/siteMC4_ida.Rdata")




####################
####################
####################
####################




######################### Sites DF  #########################################

siteName <- c("McAlpine Upper", "McAlpine Lower", "McAlpine SC",
              "McMullen", "Upper Little Sugar", "Lower Little Sugar")

cmCode <- c("MC38", "MC45", "MC45B",
            "MC42", "MC29A1", "MC49A")

usgsCode <- c("02146600", "02146750", "0214676115",
              "02146700", "02146507", "02146530")

usgsArea <- c(38.6, 92.4, 95.9,
            6.95, 42.6, 49.2) #mi2





