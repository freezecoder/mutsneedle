
#Example Shiny App

library(shiny)
library(mutsneedle)
library(data.table)

ui=fluidPage(
  fluidRow(
  sliderInput("as","Sli1",min = 10,max=20,value = 12),
  mutsneedleOutput("abc",width=800,height=500)
  )
)

server=function(input,output,session){

  output$abc<-renderMutsneedle({
    input$as
    mutsneedle(title=sprintf("Mutation Needle Plot: %s",input$as),
              mutdata=exampleMutationData(),
              domains=exampleRegionData()
               )
  })

}

shinyApp(ui,server)
