FROM php:7-apache

RUN apt-get update && apt-get install -y unzip

RUN mkdir -p /var/www/html/lwt && \
    curl -L http://sourceforge.net/projects/lwt/files/latest/download >/tmp/lwt.zip && \
    cd /var/www/html/lwt && \
    unzip /tmp/lwt.zip && \
    rm /tmp/lwt.zip

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install mbstring

#CMD sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
COPY htaccess /var/www/html/.htaccess
COPY connect.inc.php /var/www/html/lwt
COPY config /tmp/config
RUN echo "htpasswd -b -c /etc/apache2/.htpasswd \$LWT_USERNAME \$LWT_PASSWORD" > /tmp/gen-password
RUN chmod +x /tmp/gen-password
RUN env $(cat /tmp/config | xargs) /tmp/gen-password
COPY php.ini /usr/local/etc/php/
ARG timezone=America/New_York
RUN echo "date.timezone = ${timezone}" >> /usr/local/etc/php/php.ini
RUN cat /usr/local/etc/php/php.ini
RUN apachectl configtest
CMD sed -i "s/80/8080/g" /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf && docker-php-entrypoint apache2-foreground
