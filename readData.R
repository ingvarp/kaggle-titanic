rm(list=ls())
require(dplyr)


#setwd("~/Dropbox/bigdata/titanic/")
train.column.types <- c('integer',   # PassengerId
                        'factor',    # Survived 
                        'factor',    # Pclass
                        'character', # Name
                        'factor',    # Sex
                        'numeric',   # Age
                        'integer',   # SibSp
                        'integer',   # Parch
                        'character', # Ticket
                        'numeric',   # Fare
                        'character', # Cabin
                        'factor' 
)    # Embarked
test.column.types <- train.column.types[-2]
missing.types<- c("NA","")
df.train <- read.csv("train.csv", stringsAsFactors=FALSE, colClasses=train.column.types, na.strings=missing.types)
df.test <- read.csv("test.csv", stringsAsFactors=FALSE, colClasses=test.column.types,  na.strings=missing.types)

