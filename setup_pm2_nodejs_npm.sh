#!/bin/bash
#print date time on screen
echo "`date`"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Define your function here
InstallNvn () {
    sleep 2
    echo "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
}


#install nvm ( a version manager for node.js )
clear    
sleep 2

#check if curl installed
echo "Checking if curl installed"
curl -V > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Curl ready"
    InstallNvn
else
    echo "Curl is not installed"
    echo "Installing Curl"
    sudo apt update -y > /dev/null 2>&1
    sudo apt install curl -y
    curl -V > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        InstallNvn
    else
        echo "Can not install Curl trying with Wget"
        echo "Installing Wget"
        sudo apt update -y > /dev/null 2>&1
        ssudo apt install wget -y
        if [ $? -eq 0 ]; then
            echo "Installing nvm"
            wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
        else
            echo "Can not install Curl or Wget"
            echo "Exit"
            exit 1
        fi
    fi
fi

#install Node v10
clear
if [ $? -eq 0 ]; then
    sleep 2
    clear
    echo "List version: \n NOTE: you can type any version u want, this list is a suggetsion \n 16.10.0 \n 12.18.4 \n 10.10.0 \n ....etc"
    echo "Input the version you want install "
    read ver
    echo "Installing nodejs $ver"
    sleep 2
    nvm install $ver
    echo "Change nodejs version to $ver"
    nvm use $ver
else
    sleep 2
    echo "Can not install Nodejs $ver"
    echo "Exit"
    exit 1
fi

#install PM2
clear
npm -v > /dev/null 2>&1
if [ $? -eq 0 ]; then
    sleep 2
    clear
    echo "Installing PM2 "
    npm install pm2@latest -g
else
    sleep 2
    echo "Can not install pm2"
    echo "Exit"
    exit 1
fi

