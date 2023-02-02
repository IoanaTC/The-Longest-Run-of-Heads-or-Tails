#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # stabilirea unei teme pentru ui
    theme = bs_theme(
      version = 4, 
      bootswatch = "sketchy"
    ),
    
    tags$head(tags$link(rel = "icon", type = "image/x-icon", 
                        href = "https://o.remove.bg/downloads/ff8780c1-3a97-4150-9093-822aa4576925/pngtree-vector-coins-icon-dollar-gold-coin-png-image_2462733-removebg-preview.png")),
    
    tags$title(class="text-center bg-succes text-muted", "Longest run of heads"),
    
    
    # Application title
    titlePanel("The Longest Run of Heads"),
    br(),
    
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
      
        sidebarPanel(
            br(),
            sliderInput("trials",
                        label = h5("Numarul de aruncari cu banul:"),
                        min = 10,
                        max = 200,
                        step = 10,
                        value = 200), br(),
            
            div("Selectati numarul de aruncari total pe care il preferati pentru experimentul curent",
                style = "font-size: 11pt;color:teal",align="right"), br(),
            
            sliderInput("minlength",
                        label = h5("O succesiune valida are lungimea:"),
                        min = 2,
                        max = 15,
                        step = 1,
                        value = 5), br(),
        
    
            div("In chenarul din dreapta vor fi marcate succesiunile care contin exact numarul selectat de rezultate identice la aruncarea cu banul",
            style = "font-size: 11pt;color:teal",align="right"), br(),
        
        br(), br(),
        div("Moneda considerata in acest experiment este una echilibrata <=> nu este utilizat un ban trucat => probabilitatea ca dupa o aruncare sa rezulte fie cap, fie pajura, este de 50%",
            style = "font-size: 13pt;color:#fcc780",align="center"), br(),
        
        br(),
        div(actionButton("start", label="Start", class = "btn-success"), align="center"), br(), br(),
        div("Actioneaza", tags$b("Start")," pentru a vedea rezultatele experimentului curent, date fiind constrangerile introduse", style = "font-size: 13pt;color:#fcc780", align="center"),br(),
        
        
        ),
        # Show a plot of the generated distribution
        mainPanel(
          
          tabsetPanel(type = "tab",
                      tabPanel("Experiment", plotOutput("experiment"),
                      p("The two sequences shown below each purportedly represent the results of 200 tosses
        of a fair coin. One of these is an actual sequence obtained from coin tossing, while 
        the other sequence is artificial. Can you decide, in sixty seconds or less, which of 
        the sequences is more likely to have arisen from actual coin tossing and which one is
        the imposter?" ,style="margin-top:-10px"),
                               p("Sequence #1", style = "text-align: center;text-decoration: underline"),
                               p("T HHH HT T T T HHH HT H HHHHHH HT T THHT T HHHH HT T T T T T HHT HHT HHH T T T HT T HH HHT HT T T HT T T HHT T T T HHHH HHT T T HHT T HHHT HHHHHT T T T T HT T T HHT T HT T HHT T T HHT T T HH THHT HHT T T T T HHT HH HH HHT HT HT T HT HT T H HHT T HHT HT HH HH HH HHT THT T HHHT H HT T HT T T T T T HHHT HHH"),
                               p("Sequence #2", style = "text-align: center;text-decoration: underline;"),
                               p("T HT HT T T HT T T T T HT HT T T HT T HHHT HHT HT HT HT T T T HHT T HHT T HHH T HHHT T H HHT T T HHHT HHH HT T T HT HT HH HHT HT T T HHHT HHT HT T T HHT H HHT HHH HT T HT HHT H HHT T T HT HHHT HHT T T HHHT T T T HHHT HT H HHHT H TT HHT T T T HT HT HT T HT HHT T HT T THT T T T H HH HT HT HHHT T HH HH HT HH"),
                               p("Schilling, M. 'The Longest Run of Heads' - The College Mathematics Journal; 21(3), 196--207")),
                      
                      tabPanel("Documentatie", htmlOutput("documentatie")),
                      tabPanel("Table", tableOutput("table"))
          )
        )
    )
)


source("main.R")

options(shiny.error = browser)

server <- function(input, output) {
    
    dataInput <- reactive({
      tosses.gen(input$trials*(input$start>-1), 0.5)
    })
    
    output$experiment <- renderPlot({
      plot.gen(input$minlength, dataInput())
    })
    
    output$documentatie <- renderPrint({
        div("portocale")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
