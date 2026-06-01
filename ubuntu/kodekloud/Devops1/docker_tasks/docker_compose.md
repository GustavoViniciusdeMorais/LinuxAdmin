# composes
#### Deply Container PHP
```yml
services:
    web:
        image: php:apache
        ports:
            - 8088:80
        volumes:
            - /var/www/html:/var/www/html
        container_name: php_web
        depends_on:
            - db
    db:
        image: mariadb:latest
        ports:
            - 3306:3306
        volumes:
            - /var/lib/mysql:/var/lib/mysql
        container_name: mysql_web
        environment:
            MYSQL_DATABASE: database_web
            MYSQL_USER: app_user
            MYSQL_ROOT_PASSWORD: R00tP@ss!
```
