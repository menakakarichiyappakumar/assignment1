VAR1=$(awk -F "=" '$1=="ID_LIKE" {print$2}' /etc/os-release)
VAR2='"rhel fedora"'
VAR3="debian"
if [ "$VAR1" = "$VAR2" ]; then
    echo "RHEL PLATFORM"
    echo " "
    echo "Installing packages"
    echo " "
    sudo yum install httpd mod_ssl openssl mysql-server mysql php php-mysql php-gd php-mbstring
    echo "starting services"
    echo " "
    sudo service httpd start
    sudo service mysqld start
    echo "Checking status"
    echo " "
    sudo service httpd status
    sudo service mysqld status
    echo "Checking versions"
    echo " "
    httpd -v
    mysql -V
    php -v
    mkdir git
    echo "Cloning Git"
    echo " "
    git clone https://github.com/menakakarichiyappakumar/ass1.git git
    cp /home/ec2-user/git/info.php /var/www/html/
    rm -rf git
    echo "backing up"
    echo " "
    sudo  mysqldump -proot --databases sample > /opt/backups/backup.sql

elif [ "$VAR1" = "$VAR3" ]; then
   echo "Debian Platform"
    echo " "
    echo "Installing packages"
    sudo apt-get install apache2 php libapache2-mod-php php-mysql mysql-server
    echo "starting services"
    echo " "
    sudo service  apache2 start
    sudo service mysql start
    echo "Checking status"
    echo " "
     sudo service apache2 status
    sudo service mysql status
    echo "Checking versions"
    echo " "
    apache2 -v
    mysql -V
    php -v
    echo "Cloning Git"
    echo " "
    mkdir git
    git clone https://github.com/menakakarichiyappakumar/ass1.git git
    cp /home/ubuntu/git/info.php /var/www/html/
    rm -rf git
     echo "backing up"
     echo " "
    sudo  mysqldump -proot --databases sample > /opt/backups/backup.sql
  else
   echo "No match"

fi
crontab -l

