sleep 5

cd /var/www/html

if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
fi

./wp-cli.phar core download --allow-root
./wp-cli.phar config create --dbname=$WORDPRESS_DATABASE --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PWD --dbhost=mariadb --allow-root
./wp-cli.phar core install --url=$WORDPRESS_URL --title=$TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PWD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root
./wp-cli.phar user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=subscriber --user_pass=$WORDPRESS_PASSWORD --allow-root

chmod -R 775 wp-content

php-fpm7.4 -F