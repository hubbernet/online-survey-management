library(shiny)
library(ggplot2)

liste <- data()
liste <- as.vector(liste$results[,"Item"])

shinyUI(fluidPage(
  titlePanel(title = "Dashboard"),
    
    mainPanel(
      tabsetPanel(
        type = "tab",
        tabPanel("Donnees", 
                 dataTableOutput("out"),
                 actionButton("actiondata", "Rafraichir")),
        tabPanel("Dashboard", 
                 plotOutput("dash"),
                 actionButton("actiongraph", "Rafraichir"))
      )
    )
  )
)
