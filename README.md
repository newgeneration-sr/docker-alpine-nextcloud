![docker build automated](https://img.shields.io/docker/cloud/automated/dotriver/nextcloud)
![docker build status](https://img.shields.io/docker/cloud/build/dotriver/nextcloud)
![docker build status](https://img.shields.io/docker/pulls/dotriver/nextcloud)

# Nextcloud on Alpine Linux + S6 Overlay

Nextcloud documentation [here](https://docs.nextcloud.com/).

# Auto configuration parameters :

- DATABASE_HOST=localhost ( Name of the mariadb service  )
- DATABASE_PORT=3306 ( Port of the mariadb server )
- DATABASE_PASSWORD=password ( Password of the mariadb server )
- DATABASE_USERNAME=username ( Username of the mariadb server )
- DATABASE_NAME=nextcloud ( Name of the database on the mariadb server )
- ADMIN_USERNAME=admin ( Nextcloud admin username )
- ADMIN_PASSWORD=password ( Nextcloud admin password  )
- TRUSTED_DOMAIN_0=localhost  ( Nextcloud trusted domain )
- TRUSTED_DOMAIN_1=box.example.org  ( You can add many trusted domains by adding TRUSTED_DOMAIN_X = domain )

# Compose file example

```
version: '3'

services:

  nextcloud:
    image: dotriver/nextcloud
    environment:
        - DATABASE_HOST=mariadb
        - DATABASE_PORT=3306
        - DATABASE_NAME=nextcloud
        - DATABASE_USERNAME=nextcloud
        - DATABASE_PASSWORD=password
        - ADMIN_USERNAME=admin
        - ADMIN_PASSWORD=password
        - TRUSTED_DOMAIN_0=127.0.0.1:8080
    ports:
      - 8080:80
    volumes:
      - nextcloud-data:/var/www/nextcloud/
    networks:
      default:
  
  mariadb:
    image: dotriver/mariadb
    environment:
      - ROOT_PASSWORD=password
      - DB_0_NAME=nextcloud
      - DB_0_PASS=password
    ports:
      - 3306:3306
      - 8081:80
    volumes:
      - mariadb-data:/var/lib/mysql/
      - mariadb-config:/etc/mysql/
    networks:
      default:
    
volumes:
    nextcloud-data:
    mariadb-data:
    mariadb-config:

```
