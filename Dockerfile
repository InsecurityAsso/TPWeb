FROM php:5.6-apache

RUN apt-get update

COPY ./public_html /var/www/html
RUN mkdir /var/www/html/work
RUN chmod -R 777 /var/www/html

RUN apt-get install -y libbsd-dev
COPY ./src /tmp/src
RUN gcc -W -Wall -O3 /tmp/src/check_CB.c -lbsd -o /var/www/html/system/check_CB
RUN rm -rf /tmp/src

RUN apt-get install -y python3

COPY ./unqlite /tmp/unqlite
RUN gcc -W -Wall -O6 /tmp/unqlite/unqlite_jx9_interp.c /tmp/unqlite/unqlite.c -o /usr/local/bin/unqlite_jx9
RUN rm -rf /tmp/unqlite

RUN docker-php-ext-install mysql
