source("readData.R")

#deal with the name prefixes, create columt 'Title'
df.test$Survived <- NA

df.train <- rbind(df.train, df.test)

df.train$Title <- sapply (df.train$Name, function(x) strsplit (x, split='[,.]')[[1]][2])
df.train$LastName <- sapply (df.train$Name, function(x) strsplit (x, split='[,.]')[[1]][1])
#df.train$Title <- sapply (df.train$Name, function(x) strsplit (x, split=c(". ",", "))[[1]][2])

###Create initial Child column in the whole dataset
df.train$Child <- NA
df.train$Child[df.train$Age<=14] <- 1
df.train$Child[df.train$Age>14] <- 0

#make boys to Masters
df.train$Title[df.train$Age<=14 & df.train$Sex =="male" & df.train$Title==" Mr" ] <- " Master"

select(filter (df.train, Age<=15, Title==" Mr", Sex=="male"), Title, Name, Age, Survived, PassengerId)


df.train<-arrange(df.train, LastName) ## Arrange by Last Name

## Let's find how many families were there (2 or more people with same Last Name)
# Criteria
# Same Last Name
# Same Cabin
# Same Class
# Same embark point
# Same ticket No
# Close Ticket no
# Same Fare (close fare)


t <- table (df.train$LastName)
tt <- as.data.frame(t)
FamilyList <- tt$Var1[tt$Freq >1]

## Same Last Name
df.train$SameFamilyName <- df.train$LastName %in% FamilyList

## Same Ticket number

t <- table (df.train$Ticket)
tt <- as.data.frame(t)
TicketList <- tt$Var1[tt$Freq >1]

df.train$SameTicket <- df.train$Ticket %in% TicketList
 

## map missing data by provided feature
require(Amelia)
missmap(df.train, main="Titanic Training Data - Missings Map", 
        col=c("yellow", "black"), legend=TRUE)