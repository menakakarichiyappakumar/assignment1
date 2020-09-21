user=$(whoami)
if [ $user = "root" ]; then
    VAR1=$(awk -F "=" '$1=="ID_LIKE" {print$2}' /etc/os-release)
    VAR2='"rhel fedora"'
    VAR3="debian"
    if [ "$VAR1" = "$VAR2" ]; then
        echo "RHEL PLATFORM"
        echo " "

        install(){
            echo "Installing packages"
            echo " "
            yum install httpd mysql-server mysql php php-mysql
        }

         command(){
             echo "0 - install 1 - start service 2 - stop service 3 - status 4 - version 5 - exit"
            read a
             until [ $a -eq 5 ]
              do
                echo "Enter the Service "
                read ser
                if [ $a == 0 ]; then
                   yum install $ser
                elif [ $a == 1 ]; then
                    if [ -f "/etc/init.d/$ser" ]; then
                        service $ser start
                    else
                        yum install $ser
                        service $ser start
                    fi
                elif [ $a == 2 ]; then
                    service $ser stop
                elif [ $a == 3 ]; then
                    service $ser status
                elif [ $a == 4 ]; then
                $ser -v
                else
                    echo "bye bye"
                fi
                echo "0 - install 1 - start service 2 - stop service 3 - status 4 - version 5 - exit"
                read a
                
              done
         }

        clone(){
            service httpd restart
            service mysqld restart
            mkdir git
            echo "Cloning Git"
            echo " "
            git clone https://github.com/menakakarichiyappakumar/ass1.git git
            cp /home/ec2-user/git/info.php /var/www/html/
            rm -rf git
        }

        backup(){
            echo "backing up"
            echo ""
            bash backup.sh
            crontab -l
        }
    elif [ "$VAR1" = "$VAR3" ]; then
        echo "Debian Platform"
        echo " " 

        install(){
            echo "Installing packages"
            apt-get install apache2 php libapache2-mod-php php-mysql mysql-server
        }

        command(){
            echo "0 - install 1 - start service 2 - stop service 3 - status 4 - version 5 - exit"
            read a
            until [ $a -eq 5 ]
            do
                echo "Enter the service name  "
                read ser
                if [ $a == 0 ]; then
                   apt-get install $ser
                elif [ $a == 1 ]; then
                   if [ -f "/etc/init.d/$ser" ]; then
                        service $ser start
                    else
                        apt-get install $ser
                        service $ser start
                    fi
                elif [ $a == 2 ]; then
                    service $ser stop
                elif [ $a == 3 ]; then
                    service $ser status
                elif [ $a == 4 ]; then
                    $ser -v
                else
                    echo "bye bye"
                fi
            echo "0 - install 1 - start service 2 - stop service 3 - status 4 - version 5 - exit"
            read a
            done
         }

         clone(){
            service apache2 start
            service mysqld start
            mkdir git
            git clone https://github.com/menakakarichiyappakumar/ass1.git git
            cp /home/ubuntu/git/info.php /var/www/html/
            rm -rf git
        }

        backup(){
            echo "backing up"
            echo " "
            bash backup.sh
            crontab -l
        }
    else
        echo "No match"
    fi

    lamp(){
        install
        command
        clone
        backup
    }
else
    echo "only root user is allowed"
fi
"$@"
