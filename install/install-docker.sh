#!/bin/bash	

sudo apt-get remove docker docker-engine
sudo apt-get update
sudo apt-get install \\n    apt-transport-https \\n    ca-certificates \\n    curl \\n    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \\n   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \\n   $(lsb_release -cs) \\n   stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > dc
sudo mv dc /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
docker run hello-world
docker run --name zillow -e POSTGRES_DB=zillow -e POSTGRES_PASSWORD=docker -e POSTGRES_USER=docker -v /home/mike/workspace/dbeaver/zillow/pgdata:/var/lib/postgresql/data -p 5432:5432 -d postgres

