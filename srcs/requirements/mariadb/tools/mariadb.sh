#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
else
    echo "MariaDB data directory already exists!"
fi

# Start MariaDB in the background
mysqld_safe --datadir=/var/lib/mysql &

# Wait for MariaDB to be ready
until mysqladmin ping >/dev/null 2>&1; do
    echo -n "."; sleep 1
done
mariadbd --user=mysql --bootstrap <<EOF
USE mysql;
FLUSH PRIVILEGES;

DROP USER IF EXISTS ''@'localhost';
DROP DATABASE IF EXISTS test;

CREATE DATABASE IF NOT EXISTS $WORDPRESS_DATABASE;
CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PWD';
GRANT ALL PRIVILEGES ON $WORDPRESS_DATABASE.* TO '$WORDPRESS_DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

exec mysqld_safe --datadir=/var/lib/mysql