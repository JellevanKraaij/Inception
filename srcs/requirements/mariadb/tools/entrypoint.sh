#!/bin/sh

envsubst '$MARIADB_DATABASE,$MARIADB_USER,$MARIADB_PASSWORD' < /app/setup.sql > /app/setup-temp.sql

echo "Initializing mariadb"
mariadb-install-db --user=root --datadir=/var/lib/mysql 2>&1 > /dev/null

cp /app/my.cnf /etc/my.cnf
mkdir -p /run/mysqld

mariadbd --user=root --datadir=/var/lib/mysql &

while ! mysqladmin ping --silent; do
	sleep 1
done

echo "Creating database"

mysql < /app/setup-temp.sql

mysqladmin shutdown

echo "Starting mariadb"	

exec "$@"