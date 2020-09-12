VAR1=$(awk -F "=" '$1=="ID_LIKE" {print$2}' /etc/os-release)
VAR2='"rhel fedora"'
VAR3="debian"
if [ "$VAR1" = "$VAR2" ]; then
    echo "RHEL PLATFORM"
    echo " "
    echo "Installing packages"
    echo " "
    sudo yum install httpd mod_ssl openssl mysql-server mysql php php-mysql php-gd php-mbstring
    a=1
    until [ $a -eq 0 ]
    do
    echo "1 - start service 2 - stop service 3 - status 4 - version 0 - exit"
    read a
    if [ $a == 1 ]; then
      sudo service httpd start
      sudo service mysqld start
   elif [ $a == 2 ]; then
     sudo service httpd stop
     sudo service mysqld stop
   elif [ $a == 3 ]; then
    sudo service httpd status
    sudo service mysqld status
   elif [ $a == 4 ]; then
     httpd -v
     mysql -V
     php -v
  else
    echo "bye bye"
  fi
  done
  sudo service httpd restart
  sudo service mysqld restart
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
    a=1
    until [ $a -eq 0 ]
    do
    echo "1 - start service 2 - stop service 3 - status 4 - version 0 - exit"
    read a
    if [ $a == 1 ]; then
     sudo service apache2 start
     sudo service mysql start
   elif [ $a == 2 ]; then
     sudo service apache2 stop
     sudo service mysql stop
   elif [ $a == 3 ]; then
     sudo service apache2 status
     sudo service mysql status
   elif [ $a == 4 ]; then
      apache2 -v
      mysql -V
      php -v
   else
     echo "bye bye"
   fi
   done
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
