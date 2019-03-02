# Docker Ocsinventory Server Container
# Docker Compose
Deploy OCS Inventory (latest version is 2.5).
First create a file called docker-compose.yml with following content:
```
version: '3'

services:
  ocs:
    image: cmotta2016/ocsinventory
    environment:
      OCS_DBNAME: ocsdatabase
      OCS_DBSERVER_READ: database
      OCS_DBSERVER_WRITE: database
      OCS_DBUSER: ocsuser
      OCS_DBPASS: <your_custom_password>
    volumes:
      - ocsdata:/usr/share/ocsinventory-reports/
    ports:
      - "80:80"
      - "443:443"
    container_name: ocsinventory-server
        
  db:
    image: mysql:5.7.25
    environment:
      MYSQL_ROOT_PASSWORD: <your_custom_password>
      MYSQL_USER: ocsuser
      MYSQL_PASSWORD: <your_custom_password>
      MYSQL_DATABASE: ocsdatabase
    volumes:
      - database:/var/lib/mysql
    container_name: database

volumes:
  database:
  ocsdata:
```
And them;
```
# docker-compose up -d
```
This will deploy four containers.
Access http://localhost/ocsreports/install.php.

On Ocs configuration page, put asked informations from ocs environment of docker-compose file.
