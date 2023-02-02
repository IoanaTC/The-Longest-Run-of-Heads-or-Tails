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
      bootswatch = "minty"
    ),
    
    tags$head(tags$link(rel = "icon", type = "image/x-icon", 
                        href = "https://o.remove.bg/downloads/ff8780c1-3a97-4150-9093-822aa4576925/pngtree-vector-coins-icon-dollar-gold-coin-png-image_2462733-removebg-preview.png")),
    
    tags$title(class="text-center bg-succes text-muted", "Longest run of heads or tails"),
    br(),
    
    # Application title
    titlePanel("The Longest Run of Heads or Tails"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          mainPanel(
            tabsetPanel(
              tabPanel("Plot", plotOutput("plot")), 
              tabPanel("Summary", verbatimTextOutput("summary")), 
              tabPanel("Table", tableOutput("table"))
            )
          )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
