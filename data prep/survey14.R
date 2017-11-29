library(readr)
library(stringr)
library(dplyr)
setwd("C:/Users/ChingPau/Desktop")
getwd()
mental_health <- read.csv("survey2014.csv", stringsAsFactors = TRUE )

#print the structure of the column
str(mental_health)

#remove unused or imcompatible data column
mental_health <-mental_health[-c(1,4,5,27)]

#Gender Processing
mental_health$Gender <- str_to_lower(mental_health$Gender)
male_str <- c("male", "guy (-ish) ^_^","m", "male-ish", "maile", "mal", "male (cis)", "make", "male ", "man","msle", "mail", "malr","cis man","cis male")
female_str <- c("cis female", "f", "female", "woman",  "femake", "female ","cis-female/femme", "female (cis)", "femail")
trans_str <- c("a little about you","p","trans-female", "something kinda male?", "queer/she/they", "non-binary","nah", "all", "enby", "fluid", "genderqueer", "androgyne", "agender", "male leaning androgynous", "guy (-ish) ^_^", "trans woman", "neuter", "female (trans)", "queer", "ostensibly male, unsure what that really means" )

mental_health$Gender <- sapply(as.vector(mental_health$Gender), function(x) if(x %in% male_str) "male" else x )
mental_health$Gender <- sapply(as.vector(mental_health$Gender), function(x) if(x %in% female_str) "female" else x )
mental_health$Gender <- sapply(as.vector(mental_health$Gender), function(x) if(x %in% trans_str) "trans" else x )
mental_health$Gender <- as.factor(mental_health$Gender)
#unique(mental_health$Gender)

#remove outlier in age column
mental_health <- subset(mental_health, Age>14 & Age < 66)

#replace the NA columns with the mode of the columns
mental_health$work_interfere[is.na(mental_health$work_interfere)] <- "Often"
mental_health$self_employed[is.na(mental_health$self_employed)] <- "No"
#print out the column that is have NA column
for(count in c(1:23))
{
  if(any(is.na(mental_health[count])) == TRUE)
  {
    print(paste(colnames(mental_health[count]),"-> nullable",any(is.na(mental_health[count])) ))
  }
}

summary(mental_health)
str(mental_health)

write.csv(mental_health, file="C:/Users/ChingPau/Desktop/mental_health2014.csv", row.names = FALSE, col.names = TRUE)
