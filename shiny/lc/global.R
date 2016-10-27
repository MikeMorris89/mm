# install.packages('shiny', dep=T, repos="https://cran.rstudio.com/")
# install.packages('rmarkdown', dep=T, repos='https://cran.rstudio.com/')
# install.packages('shinyjs', dep=T, repos='https://cran.rstudio.com/')
# install.packages('shinydashboard', dep=T, repos='https://cran.rstudio.com/')
# install.packages('data.table', dep=T, repos='https://cran.rstudio.com/')
# install.packages('plotly', dep=T, repos='https://cran.rstudio.com/')



library(shiny)
library(shinyjs)
library(shinydashboard)
library(plotly)

loadinglogo<-function(href,src,loadingsrc,height=NULL,width=NULL,alt=NULL){
  tagList(
    tags$head(
      tags$script(
        "setInterval(function(){
            if($('html').attr('class')=='shiny-busy'){
            $('div.busy').show();
            $('div.notbusy').hide();
            } else {
            $('div.busy').hide();
            $('div.notbusy').show();
            }
        },100)")
      ),
    tags$a(href=href,
           div(class="busy"
               ,img(src=loadingsrc,height=height,width=width,alt=alt)),
           div(class="notbusy"
               ,img(src=src,height=height,width=width,alt=alt))
               
    )
  )
}