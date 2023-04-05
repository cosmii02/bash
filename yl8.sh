#!/bin/bash

# Küsime kasutajalt, millist kausta ta soovib varundada
read -p "Millist kausta soovite varundada? " SOURCE_DIR

# Kontrollime, kas allikakaust eksisteerib
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Varundatavat kausta ei leitud, skript lõpetab töö."
  exit 1
fi

# Küsime kasutajalt, millist kausta ta soovib varundada
read -p "Kuhu kausta soovite varundada? " TARGET_DIR

# Loo sihtkaust, kui seda ei eksisteeri
if [ ! -d "$TARGET_DIR" ]; then
  mkdir "$TARGET_DIR"
fi

# Varundame failid allikakaustast varukoopiakausta
TIMESTAMP=$(date +"%Y.%m.%d_%H.%M.%S")
tar -czf "${TARGET_DIR}/${SOURCE_DIR##*/}_${TIMESTAMP}.tar.gz" "$SOURCE_DIR"

# Kontrollime, kas varundusfail on loodud
BACKUP_FILE="${TARGET_DIR}/${SOURCE_DIR##*/}_${TIMESTAMP}.tar.gz"
if [ ! -f "$BACKUP_FILE" ]; then
  echo "Varundamine ebaõnnestus, skript lõpetab töö."
  exit 1
fi

# Kuvame teate, et varundamine on lõppenud
echo "$SOURCE_DIR kausta varundamine $TARGET_DIR kausta on edukalt lõppenud."
