FROM php:7.3.4-apache
COPY src/ /var/www/html
EXPOSE 80