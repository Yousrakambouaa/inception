FROM alpine:3.22

RUN apk update && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-curl \
    php83-dom \
    php83-exif \
    php83-fileinfo \
    php83-mbstring \
    php83-openssl \
    php83-xml \
    php83-zip \
    php83-gd \
    wget \
    mariadb-client

RUN mkdir -p /run/php-fpm83 /var/www/html && \
    chown -R nobody:nobody /run/php-fpm83 /var/www/html

COPY tools/setup-wp.sh /usr/local/bin/setup-wp.sh

RUN chmod +x /usr/local/bin/setup-wp.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup-wp.sh"]