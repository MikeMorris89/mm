
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#



dashboardPage(
  dashboardHeader(title = loadinglogo('https://www.kaggle.com/wendykan/lending-club-loan-data',
                                      'peertopeer.png',
                                      'loading.gif',
                                      height=50
                                      )
                    ),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250)),
      
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50)
      )
    )
  )
)

