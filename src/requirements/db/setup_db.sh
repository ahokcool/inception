#!/bin/bash

if [ -d "/var/lib/mysql/$DB_NAME" ]; then
	echo "Database already exists. Skipping initialization..."
else
	echo "Initializing MariaDB database..."
	service mariadb start
	service mariadb status
	mariadb -uroot --host=localhost -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
	mariadb -uroot --host=localhost -e "FLUSH PRIVILEGES;"

/* Create the database for wordpress */
CREATE DATABASE test123;

/* Change the root pswd for localhost */
ALTER USER 'root'@'localhost' IDENTIFIED BY '123';

/* Create root user for '%' if it doesn't exist, then alter its password */
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '123';
ALTER USER 'root'@'%' IDENTIFIED BY '123';

/* Create a db user for wordpress */
CREATE USER 'user'@'%' IDENTIFIED BY '321';

/* Grant all privileges to the user */
GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' WITH GRANT OPTION;

/* Flush privileges = apply the changes */
FLUSH PRIVILEGES;




	sleep 2
	service mariadb stop
fi

# Start MariaDB in safe mode
exec mysqld_safe --socket=/run/mysqld/mysqld.sock --bind-address=0.0.0.0