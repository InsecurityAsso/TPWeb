FROM php:5.6-apache

COPY ./public_html /var/www/html

RUN apt-get update && apt-get install -y python3

COPY ./unqlite /tmp/unqlite
RUN gcc -W -Wall -O6 /tmp/unqlite/unqlite_jx9_interp.c /tmp/unqlite/unqlite.c -o /tmp/unqlite/unqlite_jx9
RUN mv /tmp/unqlite/unqlite_jx9 /usr/local/bin/unqlite_jx9
RUN rm -rf /tmp/unqlite

RUN docker-php-ext-install mysql
