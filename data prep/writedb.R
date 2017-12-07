library(RSQLite)

setwd("C:/Users/ChingPau/Desktop")
#create db name mental_health_db, and open the connection
db <- dbConnect(SQLite(), dbname="mental_health_db.sqlite")
mental_health <- read.csv("mentalHealthData.csv")

#write the mental_health data frame into the database
dbWriteTable(conn = db, name = "mental_health", value = mental_health, row.names = FALSE)

#show the tables in the db
dbListTables(db)

#show the fields of the mental_health in the db
dbListFields(db, "mental_health")

#dry run of reading table to variable
mental_health = dbReadTable(db,"mental_health")

#save the db and disconnect it
dbDisconnect(db)
