/* Change the root pswd for localhost */
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root_password_placeholder';

/* Create root user for '%' if it doesn't exist, then alter its password */
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'root_password_placeholder';
ALTER USER 'root'@'%' IDENTIFIED BY 'root_password_placeholder';

/* Create a db user for wordpress */
CREATE USER 'user_placeholder'@'%' IDENTIFIED BY 'user_password_placeholder';

/* Create the database for wordpress */
CREATE DATABASE database_placeholder;

/* Grant all privileges to the user */
GRANT ALL PRIVILEGES ON *.* TO 'user_placeholder'@'%' WITH GRANT OPTION;

/* Flush privileges = apply the changes */
FLUSH PRIVILEGES;
