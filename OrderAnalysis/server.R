#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    con <- dbConnect(RMySQL::MySQL(),dbname="586",host="35.232.0.97",port=3306,user="root",password="root")
    
    summary(con)
    
    query <-dbSendQuery(con,"SELECT order_number, (order_hour_of_day) FROM orders where eval_set='test'")
    data <- fetch(query)
    stuff <- data.frame(data)
    clus <- kmeans(stuff, centers=3)
    plotcluster(stuff, clus$cluster,main="Anaylsis using K Means")

    
  })
  
  output$distPlot2 <- renderPlot({
    con <- dbConnect(RMySQL::MySQL(),dbname="586",host="35.232.0.97",port=3306,user="root",password="root")
    
    summary(con)
    
    query <-dbSendQuery(con,"SELECT order_number, (order_hour_of_day) FROM orders where eval_set='test'")
    data <- fetch(query)
    stuff <- data.frame(data)
    
  
    hist(stuff$order_hour_of_day,
         main="Frequency of Orders Throughout the Day", 
         xlab="Hours", 
         border="blue", 
         col="green",freq=FALSE)
    #curve(dnorm(foo), add=TRUE)
    lines(density(stuff$order_hour_of_day))
  })
  
  output$distPlot3 <- renderPlot({
    
    con <- dbConnect(RMySQL::MySQL(),dbname="586",host="35.232.0.97",port=3306,user="root",password="root")
    
    summary(con)
    
    query <-dbSendQuery(con,"SELECT order_number, (order_hour_of_day) FROM orders where eval_set='test'")
    data <- fetch(query)
    stuff <- data.frame(data)
    plot(x=stuff$order_hour_of_day, y=stuff$order_number,xlab='Hour',ylab='Order Number', main="Frequency of orders through out the day")
    
  })
  
  output$distPlot4 <- renderPlot({
    con <- dbConnect(RMySQL::MySQL(),dbname="586",host="35.232.0.97",port=3306,user="root",password="root")
    
    summary(con)
    
    query <-dbSendQuery(con,"SELECT order_dow FROM orders where eval_set='test'")
    data <- fetch(query)
    stuff <- data.frame(data)
    
    
    hist(stuff$order_dow,
         main="What Day of the Week Do Most Orders Occur", 
         xlab="Days of Week", 
         border="blue", 
         col="green",freq=FALSE)
    #curve(dnorm(foo), add=TRUE)
    lines(density(stuff$order_dow))
    legend("bottomright", c("0=Sunday","1=Monday","2=Tuesday","3=Wednesday","4=Thursday","5=Friday","6=Saturday"))
  })
  
})
