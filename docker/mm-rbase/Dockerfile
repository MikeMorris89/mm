FROM debian:testing

MAINTAINER "Mike Morris" mike.morris89@gmail.com
##############################################################
RUN useradd docker \
	&& mkdir /home/docker \ 
	&& chown docker:docker /home/docker \
	&& addgroup docker \ 
	&& addgroup staff
##############################################################
RUN apt-get update
RUN apt-get install -y aptitude
RUN aptitude install -y ed
RUN aptitude install -y less
RUN aptitude install -y locales
RUN aptitude install -y vim-tiny
RUN aptitude install -y wget
RUN aptitude install -y ca-certificates
RUN aptitude install -y fonts-texgyre
RUN aptitude install -y build-essential
RUN aptitude install -y git-all
RUN aptitude install -y libv8-3.14-dev
RUN aptitude install -y libcurl14-gnutls-dev
RUN aptitude install -y libssl-dev
RUN aptitude install -y libxml2-dev
##############################################################
RUN apitude clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list 
RUN echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/default
##############################################################
ENV R_BASE_VERSION 3.3.1

RUN aptitude install -y littler
RUN aptitude install -y r-cran-littler
RUN aptitude install -y r-base=$(R_BASE_VERSION)
RUN aptitude install -y r-base-dev=$(R_BASE_VERSION)
RUN aptitude install -y r-recommended=$(R_BASE_VERSION)
##############################################################
RUN echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site
RUN echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r
RUN ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r
RUN ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r
RUN ln -s /usr/share/doc/littler/examples/installGithub.r /usr/local/bin/installGithub.r
RUN ln -s /usr/share/doc/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r
RUN install.r docopt
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds
RUN rm -rf /var/lib/apt/lists/*
##############################################################
CMD ["R"] 
