#!/bin/bash
if [ $# != 1 ]
then
	echo "Command Syntax:"
	echo "./vhostCreator.sh domainname"
else  

DOMAIN=$1

if [ -e /etc/redhat-release ]; then
	export distro="RHEL"
elif [ "$(lsb_release -d | awk '{print $2}')" == "Ubuntu" ]; then
	export distro="Ubuntu"
fi  

if [ $distro == "RHEL" ]; then
	cat > /etc/httpd/vhost.d/${DOMAIN}.conf << EOF
<VirtualHost *:80>
	ServerName $DOMAIN
	ServerAlias www.${DOMAIN}
	DocumentRoot /var/www/vhosts/${DOMAIN}/public_html
	<Directory /var/www/vhosts/${DOMAIN}/public_html>
		AllowOverride All
	</Directory>
	ErrorLog /var/log/httpd/${DOMAIN}-error.log
	CustomLog /var/log/httpd/${DOMAIN}-access.log combined
</VirtualHost>
EOF
    service httpd reload
elif [ $distro == "Ubuntu" ]; then
	cat > /etc/apache2/sites-available/${DOMAIN} << EOF
<VirtualHost *:80>
	ServerName $DOMAIN
	ServerAlias www.${DOMAIN}
	DocumentRoot /var/www/vhosts/${DOMAIN}/public_html
	<Directory /var/www/vhosts/${DOMAIN}/public_html>
		AllowOverride All
</Directory>
ErrorLog /var/log/apache2/${DOMAIN}-error.log
CustomLog /var/log/apache2/${DOMAIN}-access.log combined
</VirtualHost>
EOF
    ln -s /etc/apache2/sites-available/${DOMAIN} /etc/apache2/sites-enabled/${DOMAIN}
    service apache2 reload
else 
    echo "Could not determine OS"
fi

mkdir -p /var/www/vhosts/${DOMAIN}/public_html
fi
