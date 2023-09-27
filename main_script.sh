#!/bin/bash

#Download wordpress php binaries
wget  https://wordpress.org/wordpress-6.2.2.tar.gz  -O  wordpress-6.2.2.tar.gz
tar -xzvf  wordpress-6.2.2.tar.gz
chmod -R 1777 ./wordpress
echo -e "\033[1;34mThe wordpress binaries will be unzipped to wordpress folder\033[0m"
ls -l
sleep 10
echo -e "\033[1;34mCreate folders for ssl certificates and nginx\033[0m"
mkdir ./letsencrypt
mkdir ./letsencrypt/www
mkdir ./letsencrypt/cert
mkdir ./nginx

echo -e "\033[1;31mcopy nginx-pre and nginx-ssl config file to nginx folder\033[0m"
cp nginx-pre.conf nginx-ssl.conf ./nginx

echo -e "\033[1;34mInstall docker engine and compose plugin\033[0m"
chmod +x install-docker.sh
./install-docker.sh

echo -e "\033[1;34mStart the nginx and certbot containers to generate ssl certificates\033[0m"
docker compose -f docker-compose-pre.yaml up -d
echo -e "\033[1;34m Generate certificate for the domain\033[0m"
docker compose -f docker-compose-pre.yaml run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ --force-renewal -d example.com
docker compose -f docker-compose-pre.yaml down
echo -e "\033[1;34mnginx and certbot containers will be removed after the task\033[0m"

echo -e "---------------------------------------------------------------------------------"

cat <<EOF > .env
MYSQL_ROOT_PASSWORD=demo_root_password
MYSQL_USER=demo_user
MYSQL_PASSWORD=demo_password
EOF

echo -e "---------------------------------------------------------------------------------"
echo -e "\033[1;34m Now the main compose file will run to create nginx, php and mysql containers\033[0m"
docker compose up -d --build

while [[ $confirm != 'Y' ]];
do
    echo -e "\033[1;34mOpen website at **domain name with https\033[0m"
    echo -e "Press \033[4;34mLet's Go \033[0mon the website\n"
    read -p "type Y to confirm: " confirm
done

while [[ $fill != 'Y' ]];
do
  echo -e "\033[1;30mDatabase Name\033[0m: wordpress\n \033[1;30mUsername\033[0m: demo_user\n \033[1;30mPassword\033[0m: demo_password\n \033[1;30mDatabase Host\033[0m: mysql"
  read -p "Have you clicked \"Submit\"? type Y to continue: " fill
done

while [[ $create != 'Y' ]];
do
  echo -e "\033[1;31mA new wordpress config file will be created in \"wordpress\" folder named as \"wp-config.php\" or \n simply copy paste the php cofiguration into the file and save it in wordpress folder\033[0m" 
  echo -e "\033[4;34mRun the installation\033[0m" 
read -p "Have you done it?(Y/N): " create

echo -e "\033[1;34mGive the necessary information and complete the installation process\033[0m"

echo -e "\*\* IT WILL OPEN UP THE WORDPRESS WEBSITE \*\*"
