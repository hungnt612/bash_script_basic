#!/bin/bash

OS_DISTRO="unknown"
OS_DISTRO_VER="unknown"


# Check OS Distro and Version
if [ -f /etc/redhat-release ];then
    OS_DISTRO="Centos"
    OS_DISTRO_VER=$(grep -oE '[0-9]+\.[0-9]+' /etc/redhat-release)

elif [ -f /etc/lsb-release ]; then
    OS_DISTRO="Ubuntu"
    OS_DISTRO_VER="$(grep "DISTRIB_RELEASE" /etc/lsb-release | awk -F'=' '{print $2}' | sed 's/[[:blank:]]//g')"

elif [ -f /etc/debian_version ]; then
    OS_DISTRO="Debian"
    OS_DISTRO_VER="$(cat /etc/debian_version | sed 's/[[:blank:]]//g')"
fi

echo $OS_DISTRO
echo $OS_DISTRO_VER

#Install by system

#UBUNTU
if [ $OS_DISTRO=="Ubuntu" ]; then
    clear
    echo "Checking Nginx............."
    nginx -v
    if [ $? -eq 0 ]; then
        sleep 2
        echo "Nginx is installed"
    else
        sleep 2
        clear
        echo "Installing Nginx "
        sudo apt update -y && sudo apt upgrade -y
        sudo apt install nginx
        if [ $? -eq 0 ]; then
            echo "Enable Nginx to auto start when Ubuntu is booted"
            sudo systemctl enable nginx
            echo " Start Nginx"
            sudo systemctl start nginx
        else
            sleep 2
            echo "Can not install Nginx"
            echo "Exit"
            exit 1
        fi
    fi
    #Setup mariadb

    clear
    sleep 2
    echo "Installing Mariadb..."
    sudo apt install mariadb-server mariadb-client
    sudo systemctl start mariadb && sudo systemctl enable mariadb

fi


