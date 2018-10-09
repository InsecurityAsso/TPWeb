FROM php:5.6-apache

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils mariadb-server mariadb-client python3

COPY ./src /tmp/src
COPY ./public_html /var/www/html

RUN mkdir /var/www/html/work && \
    mkdir /var/www/html/forum/msg && \
    mkdir /var/www/html/forum/img && \
    chmod -R 777 /var/www/html

RUN apt-get install -y libbsd-dev && \
    gcc -O3 /tmp/src/check_CB.c -lbsd -o /var/www/html/system/check_CB && \
    rm -rf /tmp/src

COPY ./unqlite /tmp/unqlite
RUN gcc -O3 /tmp/unqlite/unqlite_jx9_interp.c /tmp/unqlite/unqlite.c -o /usr/local/bin/unqlite_jx9 && \
    rm -rf /tmp/unqlite && \
    docker-php-ext-install mysql
