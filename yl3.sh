#!/bin/bash

# Skript küsib kasutajalt, millist kausta varundada ja kuhu varundada
# Seejärel teostab skript varunduse tar käsuga ja lisab varundusfaili nimesse tänase kuupäeva ja kellaaja

echo "Tere! See skript varundab ühe kausta failid sama arvuti teise kausta."
echo ""

# Küsime, millist kausta varundada
read -p "Millist kausta soovid varundada? Sisesta kausta nimi: " source_folder

# Kontrollime, kas sisestatud kaust eksisteerib
if [ ! -d "$source_folder" ]; then
  echo "Viga: Kaust $source_folder ei eksisteeri. Palun sisesta kehtiv kausta nimi."
  exit 1
fi

# Küsime, kuhu kausta varundada
read -p "Kuhu soovid kausta varundada? Sisesta kausta nimi: " destination_folder

# Kontrollime, kas sisestatud kaust eksisteerib
if [ ! -d "$destination_folder" ]; then
  echo "Viga: Kaust $destination_folder ei eksisteeri. Palun sisesta kehtiv kausta nimi."
  exit 1
fi

# Loome varundusfaili nime
backup_name="$(date +"%y%m%d_%H%M%S")"
backup_name="${backup_name}_logbu.tar.gz"

# Teostame varunduse tar käsuga
tar -czf "$destination_folder/$backup_name" -C "$source_folder" .

# Väljastame teate ja failinime
echo "Kausta $source_folder varundamine kausta $destination_folder on lõppenud."
echo "Varundusfail: $backup_name"
