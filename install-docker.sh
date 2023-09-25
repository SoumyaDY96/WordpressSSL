#!/bin/bash
#"$(dpkg -s docker.io)" > /dev/null
echo " ---- ---- ---- " 
#docker version 1&>2 /dev/null

  for i in docker docker.io docker-doc docker-compose podman-docker containerd runc;
  do
    dpkg -s $i > /dev/null
    if [ $? -eq 0 ];
    then
       echo -e "$i has an \033[1;31mold version installed.\033[0m"
   #for i in docker.io docker-doc docker-compose podman-docker containerd runc;
       sudo apt-get -y autoremove $i
       sudo apt-get -y update
    else
       echo -e "$i \033[1;34mis not installed. Nothing to do.\033[0m"
    fi
  done


  sudo apt-get install -y ca-certificates curl gnupg
  sudo install -m 0755 -b -d /etc/apt/keyrings
  sudo rm -f /etc/apt/keyrings/docker.gpg
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg --force-yes

  echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get -y update

  for i in docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;
  do
    dpkg -s $i > /dev/null
    if [ $? -eq 0 ];
    then
       echo -e "$i is \033[1;32malready installed\033[0m"
    else
       echo -e "$i is \033[1;31mneeded to be installed\033[0m"
       sudo apt-get -y update
       sudo apt-get -y install $i
    fi
  done

  sudo docker run hello-world
  sudo docker ps -a