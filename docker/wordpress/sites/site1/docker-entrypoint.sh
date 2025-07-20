#!/bin/bash

set -e

echo "Waiting for MySQL to be ready..."
until mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1"; do
  echo "Waiting for DB..."
  sleep 3
done

cd /var/www/html

if ! wp core is-installed --allow-root; then
  echo "Installing WordPress..."
  wp core download --allow-root
  wp config create \
    --dbname="$DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --skip-check --allow-root

  wp core install \
    --url="$WP_SITE_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email --allow-root
else
  echo "WordPress already installed. Skipping setup."
fi

exec apache2-foreground
