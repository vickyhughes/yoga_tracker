library(shiny)
library(flexdashboard)
shinyUI(fluidPage(
  
  titlePanel("YOGA TRACKER"), 
  
  sidebarLayout(
    sidebarPanel(
      # Later I'll use this so user can input their own video names and say when they watched them
      fileInput("video_names", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv"))
    ),
    
    mainPanel(
      gaugeOutput("plt1"),
      plotOutput("dayplot")
    )
  )
))
