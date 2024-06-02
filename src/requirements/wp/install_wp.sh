#!/bin/bash

# Ensure the script ends if any command fails
set -e

cd /var/www/html

# Check if WordPress is already installed
if [ ! -f wp-config.php ]; then
  echo "Downloading WordPress..."
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  echo "Configuring WordPress..."
  ./wp-cli.phar core download --allow-root
  echo "Connecting wp to the database..."
  ./wp-cli.phar config create --dbname=${WP_DB_NAME} --dbuser=${WP_DB_USER} --dbpass=${WP_DB_USER_PSWD} --dbhost=${WP_DB_HOST} --allow-root
  echo "Installing WordPress..."
  ./wp-cli.phar core install --url=localhost --title=inception --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PSWD} --admin_email=${WP_ADMIN_MAIL} --allow-root
  echo "Creating a new user '${WP_USER}'..."
  ./wp-cli.phar user create ${WP_USER} ${WP_USER_MAIL} --role=author --user_pass=${WP_USER_PSWD} --allow-root
else
  echo "WordPress is already installed."
fi

# Start php-fpm in the foreground
exec php-fpm7.4 -F