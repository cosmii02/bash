#!/bin/bash

# Skript küsib kasutajalt, millist faili kopeerida ja kuhu kopeerida ning lisab kopeerimiseks uue failinime, lisades kuupäeva ja kellaaja failinimele
# Küsime kasutajalt failinime
read -p "Sisesta failinimi, mida soovid kopeerida: " source_file

# Kontrollime, kas fail eksisteerib
if [ ! -f "$source_file" ]; then
  echo "Viga: Faili $sourcefile ei eksisteeri. Palun sisesta kehtiv failinimi."
  exit 1
fi

# Loome kopeerimiseks uue failinime, lisades kuupäeva ja kellaaja
timestamp=$(date +"%d-%m-%y%H-%M-%S")
new_file=$(echo "${sourcefile%.*}""$timestamp"."${source_file##*.}")

# Teostame kopeerimise
cp "$source_file" "$new_file"

# Kontrollime, kas kopeerimine õnnestus
if [ $? -ne 0 ]; then
  echo "Viga: Faili $source_file kopeerimine failiks $new_file ebaõnnestus."
  exit 1
fi

# Väljastame teate ja uue failinime
echo "Faili $source_file kopeerimine failiks $new_file on lõppenud."