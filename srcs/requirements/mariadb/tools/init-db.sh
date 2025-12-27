#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    mysqld --user=mysql --bind-address=0.0.0.0 &
    pid="$!"

    while ! mysqladmin ping --silent; do sleep 1; done

    mysql <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
        GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'%' WITH GRANT OPTION;
        FLUSH PRIVILEGES;
EOSQL

    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
    wait "$pid"
fi

exec mysqld --user=mysql --bind-address=0.0.0.0

# #!/bin/sh

# # export MYSQL_ROOT_PASSWORD;

# # echo "hello world"
# # echo "root passwprd: " 
# # echo ${MYSQL_ROOT_PASSWORD}

# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     mysql_install_db --user=mysql --datadir=/var/lib/mysql

#     mysqld --user=mysql --bind-address=0.0.0.0 &
#     pid="$!"

#     while ! mysqladmin ping --silent; do sleep 1; done

#     # # Load secrets properly
#     # export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
#     # export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
#     # export MYSQL_ADMIN_PASSWORD=$(cat /run/secrets/db_admin_password)

#     # echo "root passwprd: " 
#     # echo '${MYSQL_ROOT_PASSWORD}'

#     mysql <<EOSQL
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
# CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
# CREATE USER IF NOT EXISTS '$$ {MYSQL_USER}'@'%' IDENTIFIED BY ' $${MYSQL_PASSWORD}';
# GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
# CREATE USER IF NOT EXISTS '$$ {MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY ' $${MYSQL_ADMIN_PASSWORD}';
# GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'%' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# EOSQL
# mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
# wait "$pid"
# fi
# exec mysqld --user=mysql --bind-address=0.0.0.0



# #!/bin/sh

# # If database not initialized
# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     # Initialize data directory
#     mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

#     # Start MariaDB in background
#     mysqld --user=mysql --skip-networking=0 --bind-address=0.0.0.0 &

#     # Wait until MariaDB is ready
#     while ! mysqladmin ping --silent; do
#         sleep 1
#     done

#     # Load passwords from Docker secrets
#     MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
#     MYSQL_PASSWORD=$(cat /run/secrets/db_password)
#     MYSQL_ADMIN_PASSWORD=$(cat /run/secrets/db_admin_password)

#     # Run setup SQL
#     mysql << EOF
# ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
# DELETE FROM mysql.user WHERE User='';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# DROP DATABASE IF EXISTS test;
# CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
# CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
# GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
# CREATE USER IF NOT EXISTS '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';
# GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ADMIN_USER'@'%' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# EOF

#     # Shutdown temporary server
#     mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

#     # Wait for shutdown
#     while mysqladmin ping --silent; do
#         sleep 1
#     done
# fi

# # Start MariaDB normally (foreground, PID1 correct)
# exec mysqld --user=mysql --bind-address=0.0.0.0