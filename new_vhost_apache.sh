#!/bin/bash

echo "Création du vhost $1.conf"

echo "<VirtualHost *:80>
        ServerName $1.fixe
        DocumentRoot /home/ldandoy/public_html/$1/public
        
        <Directory /home/ldandoy/public_html/$1/public>
                AllowOverride all
                Require all granted
        </Directory>

        LogLevel warn
        ErrorLog /var/log/apache2/$1.fixe-error.log
</VirtualHost>" | sudo tee --append /etc/apache2/sites-available/$1.conf
sudo ln -s /etc/apache2/sites-available/$1.conf /etc/apache2/sites-enabled/$1.conf

sudo service apache2 restart
