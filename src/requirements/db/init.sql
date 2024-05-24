/* Change the root pswd for localhost */
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

/* Create a db user for wordpress */
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

/* Create the database for wordpress */
CREATE DATABASE ${MYSQL_DATABASE};

/* Grant all privileges to the user */
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;

/* Flush privileges = apply the changes */
FLUSH PRIVILEGES;