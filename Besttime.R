library("RMySQL")
con <- dbConnect(RMySQL::MySQL(),dbname="586",host="35.232.0.97",port=3306,user="root",password="root")

summary(con)

query <-dbSendQuery(con,"SELECT order_number, (order_hour_of_day) FROM orders where eval_set='test'")
