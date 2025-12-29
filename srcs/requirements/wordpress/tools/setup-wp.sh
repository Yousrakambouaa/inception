#!/bin/sh

echo "Waiting for MariaDB..."
until mariadb -h mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE -e "SELECT 1;" > /dev/null 2>&1; do
    sleep 2
done
echo "MariaDB connected!"
cd /var/www/html

if [ ! -f wp-config.php ]; then
    echo "Downloading and installing WordPress..."
    wget -q https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz

    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
    sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
    sed -i "s/localhost/mariadb/g" wp-config.php

    # curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php
fi

echo "WordPress files ready! Starting PHP-FPM..."
exec php-fpm83 -F -R 
