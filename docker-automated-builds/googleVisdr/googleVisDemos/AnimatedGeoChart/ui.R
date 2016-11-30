
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  HTML(htmlHead),
  tags$script(paste('type="text/javascript"',animation)),
  #need to unlist
  tags$script(paste('type="text/javascript"',as.character(unlist(gvisData))),
  tags$script(paste('type="text/javascript"',gvisChart)),
  HTML(htmlFoot)
  
))
