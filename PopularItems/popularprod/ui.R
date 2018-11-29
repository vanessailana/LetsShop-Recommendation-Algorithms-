#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Analysis among Orders and Time of Day Made"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(tags$div(class="header", checked=NA,
                          tags$p("What do People Mostly Keep Buying?")
                          
    )),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("How Popular Are They?", tableOutput("table"))
      )
    )
  )
))
