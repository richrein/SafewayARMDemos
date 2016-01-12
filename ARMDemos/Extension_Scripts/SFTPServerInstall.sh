#!/bin/bash

add-apt-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get install -y openjdk-8-jdk
update-alternatives --config java
update-alternatives --config javac

apt-get install -y unzip

wget https://downloads.typesafe.com/typesafe-activator/1.3.6/typesafe-activator-1.3.6.zip
unzip typesafe-activator-1.3.6.zip -d /mnt/typesafe-activator

#add activator location to path
export PATH=/mnt/typesafe-activator/activator-dist-1.3.6:$PATH
cd /mnt/typesafe-activator/activator-dist-1.3.6
activator new my-first-app play-java
cd my-first-app
activator run
