# Docker Ocsinventory Server Container
# Docker Compose
Deploy ocs, glpi, mysql and reverse-proxy with nginx.
First create a file called docker-compose.yml with following content:
```
version: '3'

services:
  ocs:
    image: cmotta2016/ocsinventory:2.5
    environment:
      OCS_DBNAME: ocsdatabase
      OCS_DBSERVER_READ: database
      OCS_DBSERVER_WRITE: database
      OCS_DBUSER: ocsuser
      OCS_DBPASS: ocspasswd
    volumes:
      - ocsserver:/usr/share/ocsinventory-reports/
      - ocsserver:/etc/ocsinventory-reports/
      - ocsserver:/var/lib/ocsinventory-reports/
    ports:
      - "80"
      - "443"
    container_name: ocsinventory-server
        
  db:
    image: mysql:5.7.25
    environment:
      MYSQL_ROOT_PASSWORD: 123qwe.
      MYSQL_USER: ocsuser
      MYSQL_PASSWORD: ocspasswd
      MYSQL_DATABASE: ocsdatabase
    volumes:
      - database:/var/lib/mysql
    container_name: database

  glpi:
    image: cmotta2016/glpi
    ports:
      - "80"
    volumes:
      - glpiserver:/var/www/glpi
    container_name: glpi-server

  proxy:
    image: cmotta2016/reverse-proxy
    ports:
      - 80:80
    environment:
      SYSTEM: glpi-server
      SYSTEM1: ocsinventory-server
    container_name: reverse-proxy

volumes:
  database:
  ocsserver:
  glpiserver:
```
And them;
```
# docker-compose up -d
```
This will deploy four containers.
To access applications, add a dns record to glpi-server and ocsinventory-server. This was defined on environment of proxy container. So this container will forward access to apropriated containers.
After that, access http://glpi-server and http://ocsinventory-server/ocsreports/install.php to configure each of services.

On Ocs configuration page, put asked informations from ocs environment of docker-compose file.
