#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(RMySQL)

server <- function(input, output) {
  
  # Reactive expression to generate the requested distribution ----
  # This is called whenever the inputs change. The output functions
  # defined below then use the value computed from this expression
  
  
  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  output$plot <- renderPlot({
    con <- dbConnect(RMySQL::MySQL(),dbname="586",host="35.232.0.97",port=3306,user="root",password="root")
    query <- dbSendQuery(con,"SELECT * FROM prod_analy  join items on prod_analy.product_id=items.product_id")
    summary(con)
    data <- fetch(query)
    stuff <- data.frame(data)
    re_ordered <- c(stuff$reordered)
    prod_name <- c(stuff$product_name)
    barplot(re_ordered,names.arg=prod_name,xlab="Product Names",ylab="How Many Times Re Ordered",col="blue",main="What Products were mostly reordered",border="red", space=1)
    
    
    
  })  
  

  # Generate an HTML table view of the data ----
  output$table <- renderTable({
    con <- dbConnect(RMySQL::MySQL(),dbname="586",host="35.232.0.97",port=3306,user="root",password="root")
    query <- dbSendQuery(con,"SELECT * FROM prod_analy  join items on prod_analy.product_id=items.product_id ORDER BY reordered DESC")
    summary(con)
    data <- fetch(query)
    stuff <- data.frame(data)
    reordered <- c(stuff$reordered)
    product_name <- c(stuff$product_name)
    
    data <- data.frame(product_name,reordered)
    data
  })
  
}
