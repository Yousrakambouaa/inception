FROM alpine:3.22

RUN apk update && \
    apk add --no-cache mariadb mariadb-client && \
    mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/init-db.sh /usr/local/bin/init-db.sh

RUN chmod +x /usr/local/bin/init-db.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init-db.sh"]