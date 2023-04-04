#!/bin/bash

# Skript küsib kasutajalt, millist kausta kopeerida ja kuhu kopeerida
# Seejärel kopeerib skript esimeses kaustas olevad failid teise kausta

echo "Tere! See skript kopeerib ühe kausta koos failidega teise kausta."
echo ""

# Küsime, millist kausta kopeerida
read -p "Millist kausta soovid kopeerida? Sisesta kausta nimi: " source_folder

# Kontrollime, kas sisestatud kaust eksisteerib
if [ ! -d "$source_folder" ]; then
  echo "Viga: Kaust $source_folder ei eksisteeri. Palun sisesta kehtiv kausta nimi."
  exit 1
fi

# Küsime, kuhu kausta kopeerida
read -p "Kuhu soovid kausta kopeerida? Sisesta kausta nimi: " destination_folder

# Kontrollime, kas sisestatud kaust eksisteerib
if [ ! -d "$destination_folder" ]; then
  echo "Viga: Kaust $destination_folder ei eksisteeri. Palun sisesta kehtiv kausta nimi."
  exit 1
fi

# Kopeerime kausta koos failidega
cp -r "$source_folder"/* "$destination_folder"

# Väljastame teate
echo "Kausta $source_folder kopeerimine kausta $destination_folder on lõppenud."
