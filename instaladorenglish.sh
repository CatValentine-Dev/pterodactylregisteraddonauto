#!/bin/bash

if (( $EUID != 0 )); then
    echo -e "${CYAN}Run this script using root"
    exit
fi

clear

instalaraddon(){
    echo -e "${CYAN}Installing addon..."
    cd /var/www/pterodactyl
    rm -r pterodactylregisteraddonauto
    rm -rf /var/www/pterodactyl/app/Providers/RouteServiceProvider.php
    rm -rf /var/www/pterodactyl/app/Http/Controllers/Auth/RegisterController.php
    rm -rf /var/www/resources/scripts/components/auth/LoginContainer.tsx
    rm -rf /var/www/pterodactyl/resources/views/templates/auth/register.blade.php
    rm -rf /var/www/pterodactyl/routes/register_module.php
    rm -rf /var/www/pterodactyl/public/modules
    rm -rf /var/www/pterodactyl/public/modules/register.css
    mkdir /var/www/pterodactyl/public/modules
    mkdir /var/www/pterodactyl/public/modules/register/
    mkdir /var/www/pterodactyl/public/modules/register/css
    git clone https://github.com/CatValentine-Dev/pterodactylregisteraddonauto.git
    cd pterodactylregisteraddonauto
    mv RouteServiceProvider.php /var/www/pterodactyl/app/Providers/
    mv RegisterController.php /var/www/pterodactyl/app/Http/Controllers/Auth/
    mv LoginContainer.tsx /var/www/pterodactyl/app/Http/Controllers/Auth/
    mv register.blade.php /var/www/pterodactyl/resources/views/templates/auth/
    mv register_module.php /var/www/pterodactyl/routes/
    mv register.css /var/www/pterodactyl/public/modules/register/css/
    cd /var/www/pterodactyl

    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    apt update
    apt install -y nodejs

    npm i -g yarn
    yarn

    cd /var/www/pterodactyl
    yarn build:production
    sudo php artisan optimize:clear
    chown -R www-data:www-data /var/www/pterodactyl/*


}

instaladordetemas(){
    while true; do
        read -p "Are you sure you want to install the addon [y/n]? " yn
        case $yn in
            [Yy]* ) instalaraddon; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

    CYAN='\033[0;36m'
    echo -e "${CYAN}Copyright (c) 2022 TemuxOS"
    echo -e "${CYAN}This progama and free software, you can modify and distribute without problems"
    echo -e "${CYAN}Registry Implementation in Pterodactyl"
    echo -e "${CYAN}Discord: https://discord.gg/WkVVtTaBRh/"
    echo -e ""
    echo -e "${CYAN}[1] Install Addon Register"
    echo -e "${CYAN}[2] Exit"
read -p "Enter a number: " choice
if [ $choice == "1" ]
    then
    instaladordetemas
fi
if [ $choice == "2" ]
    then
    exit