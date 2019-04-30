#!/bin/bash -e

MYSQLPASSWORD="Password@123"
WPDBNAME="blog"
WPUSER="root" 
WPPWD="Password@123"


echo "Updating repo information...\n"

sudo apt-get -y update 
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
#
#Installing Apache2 package
#

echo "Installing Apache package now...\n"

sudo apt-get -y install apache2


#
#Installing MySQL 5.7 which is available in default repo for Ubuntu 16.06
#

echo "Installing MySQL 5.7 now...\n"

sudo echo "mysql-server-5.7 mysql-server/root_password password Password@123" | sudo debconf-set-selections
sudo echo "mysql-server-5.7 mysql-server/root_password_again password Password@123" | sudo debconf-set-selections
sudo apt-get -y install mysql-server-5.7 mysql-client

#mysql -u root -p root -e "use mysql; UPDATE user SET authentication_string=PASSWORD('$MYSQLPASSWORD') WHERE User='root'; flush privileges;" >> $LOGFILE 2>&1



#
#Installing PHP 7.0 
#

echo "Installing PHP 7.0 now...\n"

sudo apt-get install php7.0-mysql php7.0-curl php7.0-json php7.0-cgi  php7.0 libapache2-mod-php7.0 -y


################################################################################
# End of Packer
################################################################################
