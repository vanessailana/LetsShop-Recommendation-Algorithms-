#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(cluster)
library(shiny)
library(RMySQL)
library(fpc)
library(DBI)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Analysis among Orders and Time of Day Made"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(tags$div(class="header", checked=NA,
                          tags$p("The purpose of these statistics is to help you determine when to shop at LetsShop, so no need to wait for your food")
     
    )),
    
    # Show a plot of the generated distribution
    mainPanel(
     plotOutput(outputId="distPlot"),    plotOutput(outputId="distPlot2"),
     plotOutput(outputId="distPlot3"), plotOutput(outputId="distPlot4"))
  )
))
