#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(RMySQL)
library(ggplot2)
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Popular Products"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
  
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        ui <- fluidPage(
          
          # App title ----
          titlePanel("Tabsets"),
          
          # Sidebar layout with input and output definitions ----
          sidebarLayout(
            
         
            
            # Main panel for displaying outputs ----
            mainPanel(
              
              # Output: Tabset w/ plot, summary, and table ----
              tabsetPanel(type = "tabs",
                          tabPanel("Plot", plotOutput("plot")),
                          tabPanel("Summary", verbatimTextOutput("summary")),
                          tabPanel("Table", tableOutput("table"))
              )
              
            )
          )
        )
      )
   )
)

# Define server logic required to draw a histogram

   
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
      H <- c(stuff$reordered)
      M <- c(stuff$product_name)
      barplot(H,names.arg=M,xlab="Product Names",ylab="How Many Times Re Ordered",col="blue",main="What Products were mostly reordered",border="red", space=1)
      
      
 
    })  
    
    # Generate a summary of the data ----
    output$summary <- renderPrint({
      summary(d())
    })
    
    # Generate an HTML table view of the data ----
    output$table <- renderTable({
      con <- dbConnect(RMySQL::MySQL(),dbname="586",host="35.232.0.97",port=3306,user="root",password="root")
      query <- dbSendQuery(con,"SELECT * FROM prod_analy  join items on prod_analy.product_id=items.product_id ORDER BY reordered DESC")
      summary(con)
      data <- fetch(query)
      stuff <- data.frame(data)
      H <- c(stuff$reordered)
      M <- c(stuff$product_name)
    
      data <- data.frame(H,M)
      data
    })
    
  }


# Run the application 
shinyApp(ui = ui, server = server)

