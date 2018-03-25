library(shiny)
library(flexdashboard)
library(dplyr)
library(ggplot2)

watched_vids <- read.csv("../videos_watched_manual.csv")
watched_vids$day <- weekdays(as.Date(as.character(watched_vids$Date), format = "%d/%m/%y"))

shinyServer <- function(input, output) {
  output$plt1 <- flexdashboard::renderGauge({
    n <- round(100*length(unique(watched_vids$Date))/length(unique(watched_vids$Name)),2)
    
    gauge(n, min = 0, max = 100, symbol = '%', label = paste("Videos watched"),gaugeSectors(
      success = c(100, 75), warning = c(75,25), danger = c(0, 25), colors = c("#CC6699")
    ))
})
  
  output$dayplot <- renderPlot({
    
    day_count <- watched_vids %>%
      group_by(day) %>%
      filter(!is.na(day)) %>%
      summarise(count = n())
    
    day_count$day <- factor(day_count$day, levels=c("Monday", "Tuesday", "Wednesday",
                                                    "Thursday", "Friday", "Saturday", "Sunday"))
    
    ggplot(day_count, aes(day, count)) +
      geom_bar(stat="identity")
    
  })
}
