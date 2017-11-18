library(RSQLite)

db <- dbConnect(SQLite(), dbname="mental_health.sqlite")
setwd("C:/Users/ChingPau/Desktop/")
mental_health <- read.csv("mental_health2014.csv")

dbWriteTable(conn = db, name = "mental_health", value = mental_health, row.names = FALSE)
dbListTables(db)
dbListFields(db, "mental_health")
mental_health = dbReadTable(db,"mental_health")

dbDisconnect(db)
