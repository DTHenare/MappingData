#Import csv file from election statistics
fileData <- read.csv("VotesForRegPartyByElectorate.csv",skip = 1,encoding = "UTF-8")
#Convert electorate names to latin1 encoding
fileData$X<- iconv(fileData$X,"UTF-8" ,"latin1")

fileData$index <- match(fileData$X,Gboundaries$name)

orderedVotes <- numeric(64)
for (electorate in 1:length(fileData$index)){
  if (is.na(fileData$index[electorate])){
    
  } else {
    orderedVotes[fileData$index[electorate]]=fileData$NATIONAL.PARTY[electorate]
  }
}