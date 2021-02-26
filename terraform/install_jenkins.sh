

#!/bin/bash
sudo yum -y update

echo "Install Java JDK 8"
yum remove -y java
yum install -y java-1.8.0-openjdk

echo "Install Maven"
yum install -y maven 

echo "Install git"
yum install -y git

echo "Install Docker engine"
yum update -y
yum install docker -y
sudo usermod -a -G docker jenkins
sudo service docker start
sudo chkconfig docker on
sudo systemctl daemon-reload


echo "Install Jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo useradd jenkins
sudo usermod -a -G docker jenkins
sudo systemctl daemon-reload

sudo systemctl start jenkins
sudo systemctl status jenkins


##compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose


# add docker to sudo group
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 
# sudo chkconfig jenkins on
# sudo service docker start
# sudo service jenkins start

