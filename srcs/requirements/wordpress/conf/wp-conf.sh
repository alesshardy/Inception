#!/bin/bash

#-----------wordpress installation-----------#

# wp-cli installation and perm (needed to download wp-core after)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress

chmod -R 755 /var/www/wordpress

chown -R www-data:www-data /var/www/wordpress

# wp core installation
wp core download --allow-root

wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser=="$MYSQL_USER" \
                --dbpass="$MYSQL_PASSWORD" --allow-root

wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" \
                --admin_passeword="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

#-----------php config-----------#

php-fpm7.4 -F