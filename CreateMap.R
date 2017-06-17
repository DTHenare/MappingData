library(maptools)
library(RColorBrewer)
library(classInt)
setwd("C:/Users/Dion/Documents/NZ electorate boundaries/")


## General Roll -------------------------------------------------

#Load general electorate boundaries
Gboundaries <- readShapePoly("GED Final 20140318_region.shp")


# Importing vote information ===================================
#Import csv file which holds colour coding values
fileData <- read.csv("VotesForRegPartyByElectorate.csv",skip = 1,encoding = "UTF-8")
#Convert electorate names to latin1 encoding
fileData$X<- iconv(fileData$X,"UTF-8" ,"latin1")

fileData$index <- match(fileData$X,Gboundaries$name)

#Select the party you wish to plot
partyName="NATIONAL.PARTY"

orderedVotes <- numeric(64)
for (electorate in 1:length(fileData$index)){
  if (is.na(fileData$index[electorate])){
    
  } else {
    partyVotes <- eval(parse(text = paste0("fileData$",partyName,"[electorate]")))
    totalVotes <- fileData$Total.Valid.Party.Votes[electorate]
    
    #Assign %votes to correct row of orderedVotes for mapping
    orderedVotes[fileData$index[electorate]]=partyVotes/totalVotes*100
  }
}

# Perform colour coding and plot general electorate map ========
GcolourValues <- orderedVotes

#Attach colour values to boundaries
Gboundaries$cValue = GcolourValues

#select color palette and the number colors to represent on the map
colors <- brewer.pal(9, "YlOrRd") #set breaks for the 9 colors 
brks<-classIntervals(Gboundaries$cValue, n=9, style="quantile")
brks<- brks$brks #plot the map

brks <- c(10,20,30,40,50,60,70,80,90,100)
plot(Gboundaries, col=colors[findInterval(Gboundaries$cValue, brks,all.inside=TRUE)], axes=F)





## Maori Roll ----------------------------------------------------

#Load Maori electorate boundaries
Mboundaries <- readShapePoly("MED Final 20140226_region.shp")

#Create Values that will be used for colour coding
McolourValues <- 1:7

#Attach colour values to boundaries
Mboundaries$cValue = McolourValues

#select color palette and the number colors to represent on the map
colors <- brewer.pal(7, "YlOrRd") #set breaks for the 9 colors 
brks<-classIntervals(Mboundaries$cValue, n=7, style="quantile")
brks<- brks$brks #plot the map
plot(Mboundaries, col=colors[findInterval(Mboundaries$cValue, brks,all.inside=TRUE)], axes=F)
