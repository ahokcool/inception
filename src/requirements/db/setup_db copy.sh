#!/bin/bash

# The script should stop on the first error
# set -e

# Change the bind adress
sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf

echo "Installing mariadb database..."
mariadb-install-db
#--skip-test-db --basedir=/usr --datadir=/var/lib/mysql
#echo "Starting MariaDB..."
#service mariadb start
#service mariadb status
#sleep 10
##
##echo "Change root password..."
##mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"
##
#echo "Create new user '$MYSQL_USER' and grant privileges..."
#mysql -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
#mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
#mysql -u root -e "FLUSH PRIVILEGES;"
##
##echo "Create database..."
##mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
##
##echo "Creating database..."
##service mariadb status
##
#echo "Stopping MariaDB..."
#sleep 5
#service mariadb stop
#sleep 5
#
echo "Starting MariaDB in foreground..."
exec mysqld_safe