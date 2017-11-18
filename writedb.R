library(RSQLite)

setwd("C:/Users/ChingPau/Desktop/mental_health_in_tech")
db <- dbConnect(SQLite(), dbname="mental_health14.sqlite")
mental_health <- read.csv("../mental_health2014.csv")

dbWriteTable(conn = db, name = "mental_health", value = mental_health, row.names = FALSE)
dbListTables(db)
dbListFields(db, "mental_health")
mental_health = dbReadTable(db,"mental_health")

dbDisconnect(db)
