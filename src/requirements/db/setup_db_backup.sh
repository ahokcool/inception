#!/bin/bash

# The script should stop on the first error
#set -e

# Print environment variables for DEBUG purposes
# echo "MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}"
# echo "MYSQL_USER: ${MYSQL_USER}"
# echo "MYSQL_PASSWORD: ${MYSQL_PASSWORD}"
# echo "MYSQL_DATABASE: ${MYSQL_DATABASE}"

# 0. Go to the directory where the setup_db.sql file is located
#cd /etc/mysql

## 0. Check the version of MariaDB
echo "MariaDB version:"
mariadb --version
echo "Msyql version:"
mysql -V
#
## 0. Replace the placeholders in the setup_db.sql file with the actual values
#echo Preparing setup_db.sql file...
#sed -i "s/root_password_placeholder/${MYSQL_ROOT_PASSWORD}/" setup_db.sql
#sed -i "s/user_placeholder/${MYSQL_USER}/" setup_db.sql
#sed -i "s/user_password_placeholder/${MYSQL_PASSWORD}/" setup_db.sql
#sed -i "s/database_placeholder/${MYSQL_DATABASE}/" setup_db.sql
#
#echo "Changed setup_db.sql file:"
#echo "---------------------------------------------------"
#cat setup_db.sql
#echo -e "---------------------------------------------------\n"

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mariadb-install-db --skip-test-db
    echo "Initializing MariaDB database... DONE"
else
    echo "MariaDB database already initialized"
fi

echo Starting MariaDB...\ 
exec mysqld_safe


#mysqld --user=mysql --bootstrap <

#	--user=mysql
#	--datadir=/var/lib/mysql
#	--pid-file=/run/mysqld/mysqld.pid
#	--basedir=/usr
#	--socket=/run/mysqld/mysqld.sock
#	--tmpdir=/tmp
#	--log-error=/var/log/mysql/error.log
#	--bind-address=db

# cat /var/log/mysql/error.log
# 1. Initialize the MariaDB using the setup_db.sql file
# 	mysql_install_db handles initialization tasks that must be performed before
#	the MySQL server, mysqld, is ready to use
#	https://dev.mysql.com/doc/refman/5.7/en/mysql-install-db.html
# echo "Initializing MariaDB via 'mysql_install_db' ..."
# mysql_install_db --extra-sql-file=setup_db.sql
# echo "Initializing MariaDB via 'mysql_install_db' ... DONE"
# 
# echo "Status of mariadb: (should be stopped)"
# service --status-all
#
## Starting MariaDB
#echo "Starting mariadb..."
#service mariadb start
#
#
#
#mysql -u root < setup_db.sql
#
#sleep 5
#
#echo "status of mariadb:"
#service --status-all
## # Run the setup_db.sql script to create the database and user
## echo "Setting up MySQL database and user..."
## mysql -u root < setup_db.sql
## 
#sleep 2
#echo "Stopping mariadb..."
#service mariadb stop
#sleep 2
#
## Run the main MariaDB process
#echo "Starting mariadb..."
#exec /usr/sbin/mysqld --user=root --console
#
