library(shiny)
library(ggplot2)
library(dplyr)
install.packages("reticulate") 
library(reticulate)
library(httr)
library(jsonlite)


ui <- fluidPage(
  titlePanel("Draw Digits"),
  titlePanel("Classify Them with the Domino-Deployed CNN"),
  br(),
  br(),
  sidebarLayout(
    sidebarPanel(
      h4("Click on plot to start drawing. Click again to pause."),
      hr(),
      sliderInput("mywidth", "width of the pencil", min=1, max=30, step=1, value=15),
      hr(),
      actionButton("reset", "reset drawing"),
      br(), 
      br(), 
      actionButton("predict", "predict image"),
      hr(),
      htmlOutput("prediction")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(title="Draw!",
                 plotOutput("plot", width = "500px", height = "500px",
                            hover=hoverOpts(id = "hover", delay = 100, delayType = "throttle", 
                                            clip = TRUE, nullOutside = TRUE), click="click"),
                 plotOutput("plot2828",width = "28px", height = "28px")
                 ),
        tabPanel(title="Behind the Scenes",
                 fluidRow(
                   h4("Training Details"),
                   column(4,
                     imageOutput("NVIDIA", height=35, width=310),
                     br(),
                     h6("Tesla V100-SXM2: 16152 MB Memory"),
                     h6("Cuda compilation tools, release 9.0, V9.0.176"),
                     h6("NVIDIA-SMI 384.111")
                     ),
                   column(3,
                     imageOutput("model", height=500, width=300)
                   )
                 ),
                 tags$hr(style="border-color: black;"),
                 h4("Web App Details"),
                 imageOutput("aws", height=35, width=300),
                 br(),
                 br(),
                 imageOutput("webapp", height=300, width=300),
                 tags$hr(style="border-color: black;"),
                 h4("Model API Endpoint Details"),
                 imageOutput("aws2", height=35, width=300),
                 br(),
                 br(),
                 imageOutput("apie", height=200, width=300)
                 )
                 )
          ))
        )
 

