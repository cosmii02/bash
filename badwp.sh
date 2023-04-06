#!/bin/bash

# Update packages and install necessary dependencies
sudo apt update
sudo apt install -y apache2 mariadb-server php8.1 libapache2-mod-php8.1 php8.1-mysql

# Enable and start Apache and MariaDB services
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Create the WordPress database and user
db_name=$(whiptail --inputbox "Enter the WordPress database name:" 8 40 3>&1 1>&2 2>&3)
db_user=$(whiptail --inputbox "Enter the WordPress database user:" 8 40 3>&1 1>&2 2>&3)
db_pass=$(whiptail --passwordbox "Enter the WordPress database user's password:" 8 40 3>&1 1>&2 2>&3)

sudo mysql -e "CREATE DATABASE ${db_name};"
sudo mysql -e "CREATE USER '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Download and extract WordPress
wordpress_folder=$(whiptail --inputbox "Enter the folder name for WordPress installation (e.g., myblog):" 8 40 3>&1 1>&2 2>&3)
wget https://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz
sudo cp -R wordpress /var/www/html/${wordpress_folder}

# Set up Apache configuration
domain_name=$(whiptail --inputbox "Enter your domain name (e.g., example.com):" 8 60 3>&1 1>&2 2>&3)

sudo tee /etc/apache2/sites-available/wordpress.conf <<EOL
<VirtualHost *:80>
    ServerName ${domain_name}
    DocumentRoot /var/www/html/${wordpress_folder}

    <Directory /var/www/html/${wordpress_folder}>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Enable the Apache site configuration
sudo a2ensite wordpress.conf
sudo systemctl reload apache2

# Set up WordPress configuration
sudo chown -R www-data:www-data /var/www/html/${wordpress_folder}
sudo cp /var/www/html/${wordpress_folder}/wp-config-sample.php /var/www/html/${wordpress_folder}/wp-config.php
sudo sed -i "s/database_name_here/${db_name}/g" /var/www/html/${wordpress_folder}/wp-config.php
sudo sed -i "s/username_here/${db_user}/g" /var/www/html/${wordpress_folder}/wp-config.php
sudo sed -i "s/password_here/${db_pass}/g" /var/www/html/${wordpress_folder}/wp-config.php

whiptail --msgbox "WordPress installation complete. Please visit http://${domain_name}/${wordpress_folder}/wp-admin to complete the setup." 8 60
