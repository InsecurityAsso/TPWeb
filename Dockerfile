FROM php:5.6-apache

COPY ./public_html /var/www/html

RUN apt update && apt install -y python3
RUN docker-php-ext-install mysql
