#!/bin/sh

if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=$DOMAIN_NAME/UID=ykamboua"
fi

exec nginx -g 'daemon off;'