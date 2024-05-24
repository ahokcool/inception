#!/bin/bash

# Ensure the script ends if any command fails
set -e

cd /var/www/html

# Check if WordPress is already installed
if [ ! -f wp-config.php ]; then
  echo "Downloading and configuring WordPress..."
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  ./wp-cli.phar core download --allow-root
  ./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=db --allow-root
  ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
else
  echo "WordPress is already installed."
fi

# Start php-fpm in the foreground
php-fpm7.4 -F
