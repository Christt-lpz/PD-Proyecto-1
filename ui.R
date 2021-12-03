#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  
  tags$head(
    tags$style(HTML("
                    @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
                    body {
                    background-color: #FFFFFF;
                    color: white;
            FONT SIZE
                    }
                    /* Change font of header text */
                    h2 {
                    
                    color: #0B708D;

                    
                    }

                    h5 {
                    
                    color: #0B708D;

                    
                    }

                    /* Make text visible on inputs */
                    .shiny-input-container {
                    color: #474747;
                    }"))
  ),
  
  
  
  
  titlePanel("Precio Casas"),
  sidebarLayout
  (
    
    sidebarPanel( style = "font-size:12px, color: color:#D04F4F",
      fileInput("cargar_archivo","Carga de archivo", 
                buttonLabel = 'Buscar',
                placeholder = "archivo"),
      
      sliderInput('precio', 'Precio de la vivienca:',
                  min=34900,           
                  max=755000,
                  value = c(34900,755000)
      ),
      
      sliderInput('Calificacion', 'Calificacion:',
                  min=1,           
                  max=10,
                  value = c(1,10)
      ),
      
      
      
      sliderInput('longitud', 'Tamaño:',
                  min=334,           
                  max=4692,
                  value = c(334,4692)
      ),
      
      
      
      sliderInput('Habitaciones', 'Numero de habitaciones:',
                  min=2,           
                  max=14,
                  value = c(2,14)
      ),
      
      
      sliderInput('anio', 'Año de consutrucción:',
                  min=1872,           
                  max=2010,
                  value = c(1872,2010)
      ),
      
      sliderInput('distancia', 'Distancia a la ciudad:',
                  min=21,           
                  max=313,
                  value = c(21,313)
      )
      
      
      
    ), 
    
    
    mainPanel(
      tabsetPanel(
        tabPanel("Datos", style = "font-size:9px",
                 hr(),
                 h5("Valor de vivienda segun parametros:", style = "font-size:12px"),
                 hr(),
                 DT::dataTableOutput ("contenido_archivo"),
                 hr(),
                 h5("Resumen general valores:", style = "font-size:12px"),
                 hr(),
                 verbatimTextOutput("resumen") 
                 ),
        tabPanel("Graficas", 
                 
                 
                 plotOutput('Correlacion')
                 
                 
                 
                 ),
        tabPanel("Table", tableOutput("table"))
      )
    )
    
  )
  
 

))
