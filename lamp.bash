#!/bin/bash -e



#
#Check if we have privileges
#

#if [ $(id -u) -ne 0 ]; then
#	echo "Run this script as a Root user only" >&2
#	exit 1
#fi

#
# Getting IP from the system
#

IP=$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')

#
#Check Error at any place and exit
#

checkerror() {

RESULT=$1

if [ $RESULT != 0 ];then
echo "Errors occured while installing, Check $LOGFILE"
exit 127
fi

}


#
# Fetching required vaiables to proceed
#

MYSQLPASSWORD=
while [[ $MYSQLPASSWORD = "Password@123" ]]; do
   read -p "Please insert the new MySQL Password for root: " MYSQLPASSWORD
done

checkerror $?


WPDBNAME=
while [[ $WPDBNAME = "blog1" ]]; do
   read -p "Enter Wordpress Database name: " WPDBNAME
done

checkerror $?


WPUSER=
while [[ $WPUSER = "root" ]]; do
   read -p "Enter Wordpress Mysql user : " WPUSER
done

checkerror $?

WPPWD=
while [[ $WPPWD = "Password@123" ]]; do
   read -p "Enter Wordpress Mysql password for above user: " WPPWD
done

checkerror $?



sudo LOGFILE=/root/installlog.txt

echo "Updating repo information...\n"

sudo apt-get update >> $LOGFILE

#
#Installing Apache2 package
#

echo "Installing Apache package now...\n"

sudo apt-get -y install apache2 >> $LOGFILE 2>&1

checkerror $?

#
#Installing MySQL 5.7 which is available in default repo for Ubuntu 16.06
#

echo "Installing MySQL 5.7 now...\n"

sudo echo "mysql-server-5.7 mysql-server/root_password password Password@123" | sudo debconf-set-selections
sudo echo "mysql-server-5.7 mysql-server/root_password_again password Password@123" | sudo debconf-set-selections
sudo apt-get -y install mysql-server-5.7 mysql-client >> $LOGFILE 2>&1

#mysql -u root -p root -e "use mysql; UPDATE user SET authentication_string=PASSWORD('$MYSQLPASSWORD') WHERE User='root'; flush privileges;" >> $LOGFILE 2>&1

checkerror $?


#
#Installing PHP 7.0 
#

echo "Installing PHP 7.0 now...\n"

sudo apt-get install php7.0-mysql php7.0-curl php7.0-json php7.0-cgi  php7.0 libapache2-mod-php7.0 -y >> $LOGFILE 2>&1

checkerror $?

################################################################################
# End of Packer
################################################################################