#!/usr/bin/env bash
set -e

# Configure apache
cat <<'EOF' > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/html

  <Directory /var/www/html>
    AllowOverride All
    Require all granted
  </Directory>

  ErrorLog /dev/stdout
  CustomLog /dev/stdout combined
</VirtualHost>
EOF

# Configure php
PHP_ERROR_REPORTING=${PHP_ERROR_REPORTING:-"E_ALL"}
sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php/7.0/apache2/php.ini
sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php/7.0/cli/php.ini
sed -ri "s/^error_reporting\s*=.*$//g" /etc/php/7.0/apache2/php.ini
sed -ri "s/^error_reporting\s*=.*$//g" /etc/php/7.0/cli/php.ini
echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php/7.0/apache2/php.ini
echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php/7.0/cli/php.ini

source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND
