#!/bin/bash

# Wait for a bit to ensure any previous startup attempts are finished
sleep 10

echo "Starting MariaDB server..."

# Ensure no existing mysqld processes are running
pkill mysqld || true

# Remove old socket and PID files if they exist
rm -f /var/run/mysqld/mysqld.sock
rm -f /var/run/mysqld/mysqld.pid

# Start MariaDB server
mysqld_safe --datadir=/var/lib/mysql &
sleep 10

# Check if MariaDB started properly
if ! mysqladmin ping -u root --silent; then
    echo "MariaDB failed to start."
    exit 1
fi

# Set up the database and user
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
mysql -u root -p${MARIADB_ROOT_PASSWORD} <<EOF
CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${WORDPRESS_DB_USER}\`@'%' IDENTIFIED BY '${WORDPRESS_DB_PWD}';
GRANT ALL PRIVILEGES ON \`${WORDPRESS_DATABASE}\`.* TO \`${WORDPRESS_DB_USER}\`@'%' IDENTIFIED BY '${WORDPRESS_DB_PWD}';
FLUSH PRIVILEGES;
EOF

# Keep MariaDB server running
exec mysqld_safe --datadir=/var/lib/mysql
