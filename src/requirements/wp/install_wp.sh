#!/bin/bash

# Ensure the script ends if any command fails
set -e

cd /var/www/html

# Debug: Print environment variables
echo "MYSQL_DATABASE: ${MYSQL_DATABASE}"
echo "MYSQL_USER: ${MYSQL_USER}"
echo "MYSQL_PASSWORD: ${MYSQL_PASSWORD}"
echo "MYSQL_HOST: ${MYSQL_HOST}"

# Check if WordPress is already installed
if [ ! -f wp-config.php ]; then
  echo "Downloading and configuring WordPress..."
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  ./wp-cli.phar core download --allow-root
  ./wp-cli.phar config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --allow-root
  ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
else
  echo "WordPress is already installed."
fi

# Start php-fpm in the foreground
php-fpm7.4 -F
