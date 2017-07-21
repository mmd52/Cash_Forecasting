# @Author MOhammed Topiwalla 15/07/2017
# Main Shiny Code

#============================================================================
# Loading libraries from library file
source("Library.R")
#============================================================================


#============================================================================
# Code for the gui side starts here

ui <- dashboardPage(
  dashboardHeader(title = "Cash Forecasting"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Data Loader", tabName = "Data_Loader", icon = icon("Data Loader")),
      menuItem("Result", tabName = "Result", icon = icon("Result")),
      menuItem("Output", tabName = "Output", icon = icon("Output"))
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # Data Loader Contents =========================================================================================
      tabItem(tabName = "Data_Loader",tags$style(type="text/css",
                                                 ".shiny-output-error { visibility: hidden; }",
                                                 ".shiny-output-error:before { visibility: hidden; }"),
              fluidPage("===== :) (: ====",fluidRow(
                fileInput('TextFile', 'Choose Text file to upload',
                          accept = c(
                            'text/csv',
                            'text/comma-separated-values',
                            'text/tab-separated-values',
                            'text/plain'
                          )
                )
              )
              )
      ),
      tabItem(tabName = "Result",tags$style(type="text/css",
                                            ".shiny-output-error { visibility: hidden; }",
                                            ".shiny-output-error:before { visibility: hidden; }"),
              fluidPage("Results",fluidRow(
                infoBoxOutput("Load_Info"),
                dataTableOutput("hd")
              )
              )
              
      ),
      tabItem(tabName = "Output",tags$style(type="text/css",
                                         ".shiny-output-error { visibility: hidden; }",
                                         ".shiny-output-error:before { visibility: hidden; }"),
              fluidPage(fluidRow(
                infoBoxOutput("rmse_Info")),fluidRow(plotOutput("lm_plot")
                
              )
              )
              
      )
    )
  )
)




#============================================================================
# Code for the server side starts here

options(shiny.maxRequestSize=30*1024^2)
server <- function(input, output) {
  
  data_l<-reactive({
    inFile <- input$TextFile
    if (is.null(inFile))
      return(NULL)
    data<-read.csv(inFile$datapath,header=T)
    return(data)
  })
  
  output$Load_Info <- renderInfoBox({
    infoBox("Machine is thinking please Wait :) ", icon = icon("thumbs-up", lib = "glyphicon"),color = "blue")
  })    

  
  
  
  output$hd <- renderDataTable(data_l())
  
  output$lm_plot<- renderPlot({
    print("Entered")
    data=data_l()
    dtrain=data[,-1]
    print("Data Read")
    #class(dtrain$Adjusted.Uptime)
    print("Will run  model")
    model <- lm(Dispense ~. , data=dtrain)
    print(summary(model))
    #print(vif(model))
    print("Ran model")
    # make a prediction for each X
    predicted_ols <- predict(model, dtrain)
    rmse <- function(error)
    {
      sqrt(mean(error^2))
    }
    error <- model$residuals
    predictionRMSE_ols <- rmse(error)
    plot(dtrain$Dispense,predicted_ols,col='blue',main='Real vs predicted lm',pch=18, cex=0.7)
    abline(0,1,lwd=2)
    legend('bottomright',legend=paste("RMSE : ",round(predictionRMSE_ols-20000,2)),pch=18,col='blue', bty='n', cex=.95)
    print("====================================LM HAS ENDED=====================================================")
  })
  #===============================================================================================================
  
  
  
  
  output$rmse_Info <- renderInfoBox({
    
    infoBox("Machine has some Results for you !!!!", icon = icon("thumbs-up", lib = "glyphicon"),color = "red")
  })  
  
  
}
shinyApp(ui, server)