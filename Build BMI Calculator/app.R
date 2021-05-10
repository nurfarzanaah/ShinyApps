#Body Mass Index (BMI) Calculator 
library(shiny)
library(shinythemes)

ui<-fluidPage(
  theme = shinytheme("cerulean"),
  navbarPage("BMI Calculator:",
             tabPanel("Home",
                      #Input values
                      sidebarPanel(
                        HTML("<h3>Input parameters<h4>"),
                        sliderInput("height",
                                    label = "Height",
                                    value = 100,
                                    min = 40,
                                    max = 200),
                        sliderInput("weight",
                                    label = "Weight",
                                    value = 80,
                                    min = 0,
                                    max = 150),
                        actionButton("submitButton",
                                     label = "Submit",
                                     class = "btn btn-primary")
                      ),
                      mainPanel(
                        tags$label(h3('Status/Output')),
                        verbatimTextOutput('contents'),
                        tableOutput('tabledata')
                      )))
)

server<- function(input, output, session) {
  datasetInput <- reactive({
    bmi <- input$weight / ((input$height/100)*(input$height/100))
    bmi <- data.frame(bmi)
    names(bmi) <- "BMI"
    print(bmi)
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if(input$submitButton > 0) {
      isolate("Calculation complete.")
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if(input$submitButton > 0) {
      isolate(datasetInput())
    }
  })
}

shinyApp(ui = ui, server = server)