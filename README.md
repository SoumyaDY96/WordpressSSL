# WordpressSSL
Secure wordpress website hosting using LEMP stack and SSL running on Docker containers.

Download all the files in a single directory.

Make sure to change execute permission for **"main_script.sh"** using: 
```
sudo chmod +x main_script.sh
```

The current project is done using **Docker Compose** and **LEMP (Linux, NGINX, MySQL and PHP)** stack and **Certbot** on an ```EC2``` instance using ```Ubuntu22.04 AMI```.

**"install-docker.sh"** file is used to install newer version of docker and docker compose along with their corresponding plugins.

**"docker-compose-pre.yaml"** is the prerequisite compose file to create the respective Certbot and Nginx containers to generate **SSL certificates** for the domain.
Once the job is done the ```containers will be removed.```

Run it with:
```
sudo docker compose -f docker-compose-pre.yaml **commands
```

```nginx``` folder holds the **nginx-pre** and **nginx-ssl** configuration files.

```letsencrypt``` folder holds **www** and **cert** folders to be used for ssl certificates inside main ```nginx container``` under **/etc/nginx/ssl**.

**"docker-compose.yaml"** is the main compose file to create the respective NGINX, MySQL and PHP containers for **Wordpress** website.

**"phpdockerfile"** is used to install more extensions on the base image of ```php:7.4-fpm-alpine```.

It is possible that ```"wp-config.php"``` may not appear after first setup; for that, copy the php from browser and put into "wp-config.php" inside wordpress folder and save it.

**Kindly look into the main script before installation !!**
