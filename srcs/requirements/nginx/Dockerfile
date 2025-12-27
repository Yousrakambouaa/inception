FROM alpine:3.22

RUN apk update && apk add --no-cache nginx openssl

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

COPY tools/setup-ssl.sh /usr/local/bin/setup-ssl.sh

RUN chmod +x /usr/local/bin/setup-ssl.sh && mkdir -p /etc/nginx/ssl

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/setup-ssl.sh"]