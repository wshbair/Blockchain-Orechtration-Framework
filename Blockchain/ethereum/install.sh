#!/bin/bash
# installing ethereum and docker
sudo apt-get update
sudo apt-get -y install python-software-properties
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install -y ethereum
sudo apt-get install -y git
sudo apt-get install -y python-numpy
sudo apt-get install -y nano
sudo apt-get install -y npm
npm install web3@0.19
npm install poisson-process
npm install solc
npm install file-system --save
sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
curl -s https://packagecloud.io/install/repositories/mrtazz/restclient-cpp/script.deb.sh | sudo bash
sudo apt-get install -y restclient-cpp
sudo apt-get install -y libcurl4-openssl-dev
