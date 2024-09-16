#!/bin/sh

echo "Generating nginx configuration..."
export NGINX_ROOT=${NGINX_ROOT:-/var/www/html}
export NGINX_PHP_HOST=${NGINX_PHP_HOST:-php}
export NGINX_PHP_PORT=${NGINX_PHP_PORT:-9000}
envsubst '$NGINX_SERVER_NAME,$NGINX_SERVER_PORT,$NGINX_ROOT,$NGINX_PHP_HOST,$NGINX_PHP_PORT' < /app/nginx.conf > /etc/nginx/nginx.conf

# Generate SSL certificate if it doesn't exist
if [ ! -f /app/nginx.crt ] || [ ! -f /app/nginx.key ]; then
	echo "Generating SSL certificate..."
	# Generate a new private key
	openssl req -x509 -newkey rsa:4096 -keyout /app/nginx.key -out /app/nginx.crt -sha256 -days 365 -nodes -subj "/CN=${NGINX_SERVER_NAME}" > /dev/null 2>&1
fi

echo "Starting nginx..."
exec "$@"