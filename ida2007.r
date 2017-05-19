######################### CLEAR STUFF ##########################################
rm(list=ls())
graphics.off()

## IDA data should be static, but will periodically need to update newer data
## via NWIS.  So, replace NWIS txt files with data retrival calls, then joins
## to ida text.  I.e., flow can sit ready to use, and be upadated as needed
## with the single function call.


#############################################################################
######################### Sites DF  #########################################

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
#################### MC14A Long Creek @ Pine/Rhyne 0214291555 ################
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

#################### MY7B McKee 0212430653 ##################################
## No IDA data

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




######################### Sites DF  #########################################

siteName <- c("McAlpine Upper", "McAlpine Lower", "McAlpine SC",
              "McMullen", "Upper Little Sugar", "Lower Little Sugar")

cmCode <- c("MC38", "MC45", "MC45B",
            "MC42", "MC29A1", "MC49A")

usgsCode <- c("02146600", "02146750", "0214676115",
              "02146700", "02146507", "02146530")

usgsArea <- c(38.6, 92.4, 95.9,
            6.95, 42.6, 49.2) #mi2





