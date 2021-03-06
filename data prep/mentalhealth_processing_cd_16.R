library(readr)
library(stringr)
library(dplyr)
setwd("C:/Users/ChingPau/Desktop")

#############################################################################################

#Cleaning 2016 dataset#
#read raw data of 2016 dataset
mentalhealth16 <- read.csv("survey2016.csv",na.strings=c("", "N/A"), stringsAsFactors = FALSE )
str(mentalhealth16)

#print and check the name of columns
names(mentalhealth16)

#drop unuseful columns
mentalhealth16 <-mentalhealth16[-c(4,6,13,14,15,16,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,38,40,41,42,43,44,45,47,48,49,50,51,52,54,58,59,60,61,62)]

#rearrange column following 2014 dataset
mentalhealth16 <- mentalhealth16[c(21,22,1,18,19,20,2,23,3,4,11,5,6,7,8,9,10,12,13,17,16,14,15)]

#replace column name following 2014 dataset
colnames(mentalhealth16) <- c("Age",	"Gender",	"self_employed",	"family_history",	"treatment", "work_interfere",	"no_employees",	"remote_work",	"tech_company","benefits",	"care_options",	"wellness_program",	"seek_help","anonymity",	"leave",	"mental_health_consequence","phys_health_consequence",	"coworkers",	"supervisor",	"mental_health_interview",	"phys_health_interview","mental_vs_physical",	"obs_consequence")

#Obs_consequence
mentalhealth16$obs_consequence[is.na(mentalhealth16$obs_consequence)] <- "None of them"
mentalhealth16$obs_consequence[mentalhealth16$obs_consequence == "Some of them" ] <- "Yes"
mentalhealth16$obs_consequence[mentalhealth16$obs_consequence == "Yes, all of them" ] <- "Yes"
mentalhealth16$obs_consequence[mentalhealth16$obs_consequence == "None of them" ] <- "No"

#Mental_vs_physical
mentalhealth16$mental_vs_physical[is.na(mentalhealth16$mental_vs_physical)] <- "Don't know"
mentalhealth16$mental_vs_physical[mentalhealth16$mental_vs_physical == "I don't know" ] <- "Don't know"
mentalhealth16$mental_vs_physical[mentalhealth16$mental_vs_physical == "Some did" ] <- "Yes"
mentalhealth16$mental_vs_physical[mentalhealth16$mental_vs_physical == "None did" ] <- "No"
mentalhealth16$mental_vs_physical[mentalhealth16$mental_vs_physical == "Yes, they all did" ] <- "Yes"
mentalhealth16$mental_vs_physical[mentalhealth16$mental_vs_physical == "I dont't know" ] <- "Don't know"

#Phys_health_interview
mentalhealth16$phys_health_interview[is.na(mentalhealth16$phys_health_interview)] <- "Maybe"

#Mental_health_interview
mentalhealth16$mental_health_interview[is.na(mentalhealth16$mental_health_interview)] <- "Maybe"

#Supervisor
mentalhealth16$supervisor[is.na(mentalhealth16$supervisor)] <- "Maybe"
mentalhealth16$supervisor[mentalhealth16$supervisor == "Some of my previous employers" ] <- "Yes"
mentalhealth16$supervisor[mentalhealth16$supervisor == "I don't know" ] <- "Maybe"
mentalhealth16$supervisor[mentalhealth16$supervisor == "No, at none of my previous employers" ] <- "No"
mentalhealth16$supervisor[mentalhealth16$supervisor == "Yes, at all of my previous employers" ] <- "Yes"
mentalhealth16$supervisor[mentalhealth16$supervisor == "Maybe" ] <- "Some of them"

#Co-workers
mentalhealth16$coworkers[is.na(mentalhealth16$coworkers)] <- "No"
mentalhealth16$coworkers[mentalhealth16$coworkers == "Some of my previous employers" ] <- "Some of them"
mentalhealth16$coworkers[mentalhealth16$coworkers == "No, at none of my previous employers" ] <- "No"
mentalhealth16$coworkers[mentalhealth16$coworkers == "Yes, at all of my previous employers" ] <- "Yes"
mentalhealth16$coworkers[mentalhealth16$coworkers == "NA" ] <- "No"

#Phys_health_consequence
mentalhealth16$phys_health_consequence[is.na(mentalhealth16$phys_health_consequence)] <- "No"

#Mental_health_consequence
mentalhealth16$mental_health_consequence[is.na(mentalhealth16$mental_health_consequence)] <- "No"

#Leave
mentalhealth16$leave[is.na(mentalhealth16$leave)] <- "Don't know"
mentalhealth16$leave[mentalhealth16$leave == "Neither easy nor difficult" ] <- "Don't know"
mentalhealth16$leave[mentalhealth16$leave == "I don't know" ] <- "Don't know"

#Anonymity
mentalhealth16$anonymity[is.na(mentalhealth16$anonymity)] <- "No"
mentalhealth16$anonymity[mentalhealth16$anonymity == "I don't know" ] <- "Don't know"

#Seek_help
mentalhealth16$seek_help[is.na(mentalhealth16$seek_help)] <- "No"
mentalhealth16$seek_help[mentalhealth16$seek_help == "I don't know" ] <- "Don't know"

#Wellness_program
mentalhealth16$wellness_program[is.na(mentalhealth16$wellness_program)] <- "No"
mentalhealth16$wellness_program[mentalhealth16$wellness_program == "I don't know" ] <- "Don't know"

#Care_options
mentalhealth16$care_options[is.na(mentalhealth16$care_options)] <- "No"
mentalhealth16$care_options[mentalhealth16$care_options == "N/A (not currently aware)" ] <- "No"
mentalhealth16$care_options[mentalhealth16$care_options == "NA (not currently aware)" ] <- "No"
mentalhealth16$care_options[mentalhealth16$care_options == "I was aware of some" ] <- "Yes"
mentalhealth16$care_options[mentalhealth16$care_options == "Yes, I was aware of all of them" ] <- "Yes"
mentalhealth16$care_options[mentalhealth16$care_options == "No, I only became aware later" ] <- "Not sure"

#Benefits
mentalhealth16$benefits[is.na(mentalhealth16$benefits)] <- "No"
mentalhealth16$benefits[mentalhealth16$benefits == "Not eligible for coverage / NA" ] <- "No"
mentalhealth16$benefits[mentalhealth16$benefits == "Not eligible for coverage / N/A" ] <- "No"
mentalhealth16$benefits[mentalhealth16$benefits == "I don't know" ] <- "Don't know"

#Tech_company
mentalhealth16$tech_company[is.na(mentalhealth16$tech_company)] <- "No"
mentalhealth16$tech_company[mentalhealth16$tech_company == "1" ] <- "Yes"
mentalhealth16$tech_company[mentalhealth16$tech_company == "0" ] <- "No"
mentalhealth16$tech_company[mentalhealth16$tech_company == "NA" ] <- "No"

#Remote_work
mentalhealth16$remote_work[is.na(mentalhealth16$remote_work)] <- "No"
mentalhealth16$remote_work[mentalhealth16$remote_work == "Sometimes" ] <- "Yes"
mentalhealth16$remote_work[mentalhealth16$remote_work == "Never" ] <- "No"
mentalhealth16$remote_work[mentalhealth16$remote_work == "Always" ] <- "Yes"

#No_employees
mentalhealth16$no_employees[is.na(mentalhealth16$no_employees)] <- "26-100"
mentalhealth16$no_employees[mentalhealth16$no_employees == "25-Jun" ] <- "6-25"
mentalhealth16$no_employees[mentalhealth16$no_employees == "5-Jan" ] <- "1-5"

#Work_interfere
mentalhealth16$work_interfere[is.na(mentalhealth16$work_interfere)] <- "Never"
mentalhealth16$work_interfere[mentalhealth16$work_interfere == "Not applicable to me" ] <- "Never"

#Treatment
mentalhealth16$treatment[is.na(mentalhealth16$treatment)] <- "No"
mentalhealth16$treatment[mentalhealth16$treatment == "1" ] <- "Yes"
mentalhealth16$treatment[mentalhealth16$treatment == "0" ] <- "No"

#Family_history
mentalhealth16$family_history[is.na(mentalhealth16$family_history)] <- "No"
mentalhealth16$family_history[mentalhealth16$family_history == "I don't know" ] <- "No"

#Self_employed
mentalhealth16$self_employed[is.na(mentalhealth16$self_employed)] <- "No"
mentalhealth16$self_employed[mentalhealth16$self_employed == "0" ] <- "No"
mentalhealth16$self_employed[mentalhealth16$self_employed == "1" ] <- "Yes"

#Gender
mentalhealth16$Gender[is.na(mentalhealth16$Gender)] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Female" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Female " ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "male " ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Male" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Male." ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Male " ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "female " ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "m" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "I identify as female." ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Bigender" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "non-binary" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Female assigned at birth" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "F" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Woman" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "f" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Cis female" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "female/woman" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Cis male" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Androgynous" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "NA" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "male 9:1 female, roughly" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Male (cis)" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Other" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Cisgender Female" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Sex is male" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Other/Transfeminine" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Female or Multi-Gender Femme" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "woman" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "nb masculine" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "none of your business" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Human" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "cis male" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Genderfluid" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Enby" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Malr" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "genderqueer woman" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender  == "mtf" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "man" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Queer" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Agender" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Dude" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Fluid" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Male/genderqueer" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Nonbinary" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Female (props for making this a freeform field, though)" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Unicorn" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Cis Male" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Male (trans, FtM)" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Cis-woman" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Genderqueer" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "cisdude" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Genderflux demi-girl" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Man" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "female-bodied; no feelings about gender" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "AFAB" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Transgender woman" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "MALE" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "fm" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Transitioned, M2F" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "Genderfluid (born female)" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "genderqueer" ] <- "trans"
mentalhealth16$Gender[mentalhealth16$Gender == "mail" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "M" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "fem" ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "human" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "cis man" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "Cis female " ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "Female assigned at birth " ] <- "female"
mentalhealth16$Gender[mentalhealth16$Gender == "M|" ] <- "male"
mentalhealth16$Gender[mentalhealth16$Gender == "I'm a man why didn't you make this a drop down question. You should of asked sex? And I would of answered yes please. Seriously how much text can this take? " ] <- "male"

#set range of acceptable age
mentalhealth16 <- subset(mentalhealth16, Age>15 & Age < 66)

#save clean 2016 dataset as mydata2016_2
write.csv(mentalhealth16, "mental_health2016.csv", row.names = FALSE, col.names = TRUE)

#########################################################################################

#Combining two datasets#

#read dataset 2014 (Cleaned data)
mydata2014 <- read.csv("mental_health2014.csv", stringsAsFactors = TRUE)
mydata2016 <- read.csv("mental_health2016.csv", stringsAsFactors = TRUE)
str(mydata2016)

#combine dataset 2014 and 2016 using rbind function
mentalHealthData <- rbind(mydata2014,mydata2016) 

#save combined datasets as mentalHealthData
write.csv(mentalHealthData, "mentalHealthData.csv", row.names = FALSE, col.names = TRUE)