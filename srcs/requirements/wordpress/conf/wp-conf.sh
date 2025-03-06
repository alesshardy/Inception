#!/bin/bash

#-----------wordpress installation-----------#

# wp-cli installation and perm (needed to download wp-core after)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress

chmod -R 755 /var/www/wordpress

chown -R www-data:www-data /var/www/wordpress

# Wait for MariaDB to be ready
until mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" > /dev/null 2>&1; do
    echo "Waiting for MariaDB to be ready..."
    sleep 5
done

# Remove existing WordPress files
rm -rf /var/www/wordpress/*

# Check if wp-config.php exists
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    # wp core installation
    wp core download --allow-root

    wp config create --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" \
                     --dbpass="$MYSQL_PASSWORD" --dbhost="mariadb:3306" --allow-root

    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" \
                    --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
else
    echo "WordPress is already installed."
fi

#-----------php config-----------#

# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# create a directory for php-fpm
mkdir -p /run/php
# start php-fpm service in the foreground to keep the container running
/usr/sbin/php-fpm7.4 -F