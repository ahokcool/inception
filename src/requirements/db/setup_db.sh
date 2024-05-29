#!/bin/bash

#if [ ! -d "/var/lib/mysql/wordpress" ]; then
#
#echo "Initializing MariaDB database..."
#
#cat << EOF > /tmp/create_db.sql
#ALTER USER 'root'@'localhost' IDENTIFIED BY '123qwe321qwe';
#FLUSH PRIVILEGES;
#EOF
#
#    # run init.sql
#    mysqld --bootstrap < /tmp/create_db.sql
#    rm -f /tmp/create_db.sql
#fi
