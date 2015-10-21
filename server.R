# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #
output$plot <- renderPlot({
    
  # years we want
  years <- 13:(13-input$years_back+1) # vector of years
  years <- paste("Cam2", formatC(years, width=3, flag="0"), sep="") # with cam in front

    
  # Calculate nice
  for(i in years){
    i_yearnice <- paste0(i,"_isitnice") # Cam2_year_isitnice
    assign(i_yearnice, ifelse(
      eval(parse(text=paste0(i,"$HighDegC"))) > input$temp_threshold & 
      eval(parse(text=paste0(i,"$RainMM"))) < input$rain_threshold,
      1,0))
  }
  
  # Plot it    
    par(mfrow = c(input$years_back,1), oma=c(0, 0, 0, 0), mar=c(0, 0, 0, 0))
    for(i in years){
      i_time <- paste0(i,"$Time")
      i_nice <- paste0(i,"_isitnice")
      plotCalendar(eval(parse(text=i_time)),
                   eval(parse(text=i_nice)))
    }
  })

output$text_set_rain <- renderText({
  # text output saying number of days
  input$rain_threshold
  })

output$text_set_temp <- renderText({
  # text output saying number of days
  input$temp_threshold
})


})