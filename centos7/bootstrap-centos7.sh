#!/usr/bin/env bash

sudo yum -y install vim httpd.x86_64

if ! [ -L /var/www/html ]; then
	sudo chown -Rf root:root /home/vagrant/sync
	sudo chcon -R system_u:object_r:usr_t:s0 /home/vagrant/sync
	sudo mkdir /usr/share/vagrant
	sudo ln -fs /home/vagrant/sync /usr/share/vagrant
	sudo chmod 0705 /home/vagrant
	sudo printf '<Directory /usr/share/vagrant>\n    Options FollowSymlinks\n    AllowOverride None\n    Require all granted\n</Directory>\n\nAlias / /usr/share/vagrant/sync/\n' > /etc/httpd/conf.d/vagrant.conf
fi

sudo systemctl enable httpd
sudo systemctl start httpd

sudo yum -y install mariadb.x86_64 mariadb-server.x86_64

sudo systemctl enable mariadb
sudo systemctl start mariadb

sudo yum -y install php.x86_64 php-bcmath.x86_64 php-gd.x86_64 php-mbstring.x86_64 php-mysql.x86_64 php-pdo.x86_64 php-soap.x86_64 php-xml.x86_64

sudo systemctl restart httpd