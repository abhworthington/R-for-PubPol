install.packages("shiny")
library(shiny)
install.packages("readr")
library(readr)

GuateData <- read_csv("GuateData.csv")

# Define UI ----
ui <- fluidPage(
  titlePanel("Departments of Guatemala"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Departmental Statistics"),
      br(),
      p("Please select a measure"),
      br(),
      selectInput("DataType", label = NULL,
                  choices = c("World Bank Aid", "GDP", "Population Density", "Population")),
      br(),
      img(src = "rstudio.png",  align = "center", height = 150, width = 150)
    ),
      
    mainPanel(
      h4(textOutput("DataName")),
      br(),
      plotOutput(outputId = "distPlot")
    )
  )
)


# Define server logic ----
server <- function(input, output) {

  output$DataName <- renderText({
    paste("Histogram of", input$DataType)
  })
  

  output$distPlot <- renderPlot({
    x <- switch(input$DataType, 
                   "World Bank Aid" = GuateData$World_Bank_Aid,
                   "GDP" = GuateData$GDP,
                   "Population Density" = GuateData$Pop_Density,
                   "Population" = GuateData$Population)
    hist(x, col = "#75AADB", border = "white",
         xlab = "Values",
         ylab = "Count",
         main = "")
                   })
}

# Run the app ----
shinyApp(ui = ui, server = server)