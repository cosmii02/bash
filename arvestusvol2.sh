#!/bin/bash

# See skript loob varukoopia failidest kaustas /var/www/wordpress
# ja WordPressi veebisaidi andmebaasist. Seejärel arhiveerib varufailid ja
# teisaldab need kaugserverisse.

# Kontrolli, kas WP-CLI on installitud, ja paigalda see, kui pole
# Kontrollitakse, kas WP-CLI on installitud ja installitakse see, kui seda pole.
if ! command -v wp &> /dev/null
then
    echo "WP-CLI pole installitud. Paigaldamine..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
fi

# Määratle varufaili kaust ja failinimi koos praeguse kuupäeva ja kellaajaga
# Määratakse varufaili kaust ja failinimi, mis sisaldab praegust kuupäeva ja kellaaega.
BACKUP_DIR="/var/wpbu"
BACKUP_FILE_NAME="wordpress_backup_$(date '+%Y-%m-%d_%H-%M-%S').tar.gz"

# Varunda failid kaustast /var/www/wordpress varufaili kausta
# Varundatakse failid kaustast /var/www/wordpress varufaili kausta.
# Kasutatakse tar käsku, et kaust kokku pakkida ning tõrgete korral teavitust ignoreerida.
tar -czf "$BACKUP_DIR/$BACKUP_FILE_NAME" --exclude "$BACKUP_DIR" /var/www/wordpress

# Varunda WordPressi veebisaidi andmebaas kasutades WP-CLI-d
# Varundatakse WordPressi veebisaidi andmebaas, kasutades WP-CLI-d.
wp db export "$BACKUP_DIR/wordpress_database_$(date '+%Y-%m-%d_%H-%M-%S').sql" --path=/var/www/wordpress

# Arhiveeri varufailide kaust ja failid
# Arhiveeritakse varufailide kaust ja failid.
tar -czf "$BACKUP_DIR/$BACKUP_FILE_NAME" "$BACKUP_DIR"

# Teisalda arhiivifail kaugserverisse
# Arhiivifail liigutatakse kaugserverisse kasutades rsync käsku.
rsync -avz "$BACKUP_DIR/$BACKUP_FILE_NAME" kasutaja@varukoopia-server:/var/varundus/

# Väljasta teade, et skript on edukalt lõpule jõudnud
# Kuvatakse teade, et skript on edukalt lõpule jõudnud.
echo "WordPressi varundus lõpetatud edukalt!"
