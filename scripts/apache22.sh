
# Setup apache2.2 server to run as user to avoid permission issues
if [[ $PACKER_BUILD_NAME == vagrant* ]]; then
	sed -i "s/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=vagrant/" /etc/apache2/envvars
	sed -i "s/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=vagrant/" /etc/apache2/envvars
else
	sed -i "s/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=dev/" /etc/apache2/envvars
	sed -i "s/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=dev/" /etc/apache2/envvars
fi

# Add phpinfo to root
echo "<?php phpinfo();"  > /var/www/index.php

#Quick fix of AllowOverride on /var/www
perl -pi -e 's/AllowOverride None/AllowOverride All/g' /etc/apache2/sites-enabled/000-default