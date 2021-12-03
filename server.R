#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(stringr)
library(corrplot)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  archivo_cargado<-reactive({
    contenido_archivo<-input$cargar_archivo
    if  (is.null(contenido_archivo)){
      return(NULL)
    }else  if (str_detect(contenido_archivo$name,'.csv'))
    {
      out<-readr::read_csv(contenido_archivo$datapath)  
      return (out)  
      
    } else if (str_detect(contenido_archivo$name,'.tsv'))
    {
      out<-readr::read_tsv(contenido_archivo$datapath)
      return(out)
    }else {
      out<- data_frame( nombre_archivo = contenido_archivo$name, 
                        error= "Extencion de archivo no soportado")
      return (out)
    }
    
  })
  
  
  out_dataset <- reactive({
    if (is.null(archivo_cargado()))
    {return(NULL)}
    
    out<-
      archivo_cargado() %>%
      filter (Precio >= input$precio[1],
              Precio <= input$precio[2],
              
              Calificacion >= input$Calificacion[1],
              Calificacion <= input$Calificacion[2],
              
              longitud >= input$longitud[1],
              longitud <= input$longitud[2],
              
              Habitaciones >= input$Habitaciones[1],
              Habitaciones <= input$Habitaciones[2],
              
              anio >= input$anio[1],
              anio <= input$anio[2],
              
              Distancia >= input$distancia[1],
              Distancia <= input$distancia[2]
      )
 
    return(out)
    
  })
  
  
  general <- reactive({
    if (is.null(archivo_cargado()))
    {return(NULL)}
    salida<-archivo_cargado()
    res<-summary(salida)
    return(res)
    
  })
  
  
  
  output$contenido_archivo <-DT::renderDataTable({
    out_dataset() %>% DT::datatable()
    
  })  
  
  
  output$resumen<-renderPrint({
    
    if (is.null(general()))
    {return(NULL)}
    else 
      return(general())
    
  })
  
  output$Correlacion <- renderPlot({
    
    data<-archivo_cargado()
     corrplot(cor(data), type="upper",
              order="hclust", tl.col="black", tl.srt=45 ) 
    
    
    
  })
  
  
  
  
  
})
