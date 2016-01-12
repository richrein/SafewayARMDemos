#!/bin/bash

sudo timedatectl set-timezone MST

sudo apt-get update
sudo apt-get install python-software-properties
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update

echo debconf shared/accepted-oracle-license-v1-1 select true | \
sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
sudo debconf-set-selections

sudo apt-get install -y oracle-java8-installer

sudo apt-get install -y unzip

sudo wget https://downloads.typesafe.com/typesafe-activator/1.3.6/typesafe-activator-1.3.6.zip
sudo unzip typesafe-activator-1.3.6.zip -d /mnt/typesafe-activator

export PATH=/mnt/typesafe-activator/activator-dist-1.3.6:$PATH
echo 'PATH=/mnt/typesafe-activator/activator-dist-1.3.6:$PATH' >> /home/safewayadmin/.bash_profile

cd /mnt/typesafe-activator/activator-dist-1.3.6
sudo chmod 777 activator

#install the binary
#start activator in forever mode