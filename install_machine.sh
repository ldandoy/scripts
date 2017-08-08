sudo apt-get update
sudo apt-get upgrade

sudo apt-get install vim git apache2 mysql-server libapache2-mod-php php php-mysql php-mbstring thunderbird curl 

sudo a2enmod rewrite userdir

wget -nv http://download.opensuse.org/repositories/isv:ownCloud:desktop/Ubuntu_16.10/Release.key -O Release.key
sudo apt-key add - < Release.key
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_16.04/ /' > /etc/apt/sources.list.d/owncloud-client.list"
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list'

sudo apt-get update
sudo apt-get install owncloud-client language-babel cpu-checker dkms virtualbox-5.1 yarn


