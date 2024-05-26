#!/bin/bash

# Print environment variables for DEBUG purposes
echo "MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}"
echo "MYSQL_USER: ${MYSQL_USER}"
echo "MYSQL_PASSWORD: ${MYSQL_PASSWORD}"
echo "MYSQL_DATABASE: ${MYSQL_DATABASE}"

# Replace placeholders in init.sql with environment variable values
#sed -i "s/root_password_placeholder/${MYSQL_ROOT_PASSWORD}/" /etc/mysql/init.sql
#sed -i "s/user_placeholder/${MYSQL_USER}/" /etc/mysql/init.sql
#sed -i "s/user_password_placeholder/${MYSQL_PASSWORD}/" /etc/mysql/init.sql
#sed -i "s/database_placeholder/${MYSQL_DATABASE}/" /etc/mysql/init.sql

# Echo the changed init.sql file for DEBUG purposes
#cat /etc/mysql/init.sql

# Initialize the MySQL data directory
mysql_install_db --user=root

# Start the MySQL server
echo "Starting MySQL server...!!!!!!!!!"
mysqld
#--init-file=/etc/mysql/init.sql
