#!/bin/sh

echo "Generating php configuration..."
export WORDPRESS_PHP_LISTEN_PORT=${WORDPRESS_PHP_LISTEN_PORT:-9000}
envsubst '$WORDPRESS_PHP_LISTEN_PORT' < /app/php-fpm.conf > /etc/php82/php-fpm.conf

# Copy the wordpress files to the root directory if they don't exist
if [ -z "$(ls -A /var/www/html)" ]; then
	echo "Downloading wordpress... & setting up wordpress"
	
	wp core download --path=/var/www/html --allow-root
	wp config create --path=/var/www/html --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root
	wp core install --path=/var/www/html --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root --user
	wp user create  --path=/var/www/html $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
fi 

echo "Starting wordpress"

exec "$@"