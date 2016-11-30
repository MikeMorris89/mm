FROM rocker/r-base

MAINTAINER mike morris "mike.morris89@github.com"

# system libraries of general use
RUN apt-get update  -qq \
 && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends --allow-downgrades \
	apt-utils \
	default-jdk \
	libssl-dev \
	libxml2-dev \
	libcurl3=7.50.1-1 \
	libcurl4-openssl-dev \
	&& rm -rf /var/lib/apt/lists/*

# basic shiny functionality
RUN R -e "install.packages(c('shiny','rmarkdown' ,'pscl','googleVis','WDI'),dep=T)" 

# copy the app to the image
RUN mkdir /root/gvis
COPY  /root/gvis

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e shiny::runApp('/root/gvis/WorldBank')"]

