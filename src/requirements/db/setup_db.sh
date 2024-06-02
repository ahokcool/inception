#!/bin/bash

if [ -d "/var/lib/mysql/$DB_NAME" ]; then
	echo "Database already exists. Skipping initialization..."
else
	echo "Initializing MariaDB database..."
	service mariadb start
	echo "MariaDB started..."
	service mariadb status
	
	# Create the database for wordpress
	echo "Creating database $DB_NAME..."
	mariadb -uroot --host=localhost -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
	
	# Create a db user for wordpress
	echo "Creating user $DB_USER..."
	mariadb -uroot --host=localhost -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PSWD';"

	# Grant all privileges to the new user
	echo "Granting privileges to $DB_USER..."
	mariadb -uroot --host=localhost -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
	
	# Apply the changes
	echo "Applying changes..."
	mariadb -uroot --host=localhost -e "FLUSH PRIVILEGES;"

	# Stop MariaDB
	echo "Stopping MariaDB..."
	sleep 2
	su root service mariadb stop
fi

# Start MariaDB in safe mode
echo "Starting MariaDB in safe mode..."
exec mysqld_safe --socket=/run/mysqld/mysqld.sock --bind-address=0.0.0.0