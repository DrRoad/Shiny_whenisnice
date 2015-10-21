library(shiny)
library(shinythemes)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(theme = shinytheme("cosmo"),
  
  # Application title
  headerPanel("When is it nice?"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("years_back", 
                "How many years back to show", 
                min = 1,
                max = 14, 
                value = 4)
  ),
  sidebarPanel(
    sliderInput("temp_threshold", 
                "Minimum temperature (centigrade)", 
                min = 1,
                max = 40, 
                value = 15)
  ),
  sidebarPanel(
    sliderInput("rain_threshold", 
                "Maximum rain (mm)", 
                min = 1,
                max = 2000, 
                value = 1)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    # css tag to colour words
    tags$style(type='text/css',
               '#text_set_temp {background-color: rgba(255,255,0,0.40); color: green;}'),
    tags$style(type='text/css',
               '#text_set_rain {background-color: rgba(255,255,0,0.40); color: green;}'),
    h5("Green=nice, Grey=not nice"),
    h3("For it to be a nice day:"),
    h3("The high must have been at least ",
       textOutput("text_set_temp", inline=T)," degrees and it could rain a maximum of ",
       textOutput("text_set_rain", inline=T),"mm."),
    h5("Use the sliders to adjust the definition of nice."),
    plotOutput("plot")
  )
))