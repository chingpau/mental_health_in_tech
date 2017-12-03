library(RSQLite)

setwd("C:/Users/ChingPau/Desktop")
db <- dbConnect(SQLite(), dbname="mental_health_db.sqlite")
mental_health <- read.csv("mentalHealthData.csv")

dbWriteTable(conn = db, name = "mental_health", value = mental_health, row.names = FALSE)
dbListTables(db)
dbListFields(db, "mental_health")
mental_health = dbReadTable(db,"mental_health")

dbDisconnect(db)
