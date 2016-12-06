#!/bin/bash	

cd ~
#git pull --recurse-submodules
cd ~/sp
mvn -U clean install
cd ~
cp ~/sp/target/shinyproxy-0.7.5.jar ~/shinyproxy-local/shinyproxy-0.7.5.jar.sp
cd ~/shinyproxy-local
java -jar shinyproxy-0.7.5.jar.sp
