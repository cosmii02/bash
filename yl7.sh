#!/bin/bash

# Defineerime muutujad allikakausta ja sihtkausta jaoks
SOURCE_DIR="/var/vanadfailid"
BACKUP_DIR="/var/backups"

# Kontrollime, kas allikakaust eksisteerib
if [ -d "$SOURCE_DIR" ]; then
  # Küsime kasutajalt, kas ta soovib kausta varundada või kustutada
  read -p "Kas soovite kausta varundada (v) või kustutada (k)? " CHOICE

  case $CHOICE in
    v|V)
      # Varundame failid allikakaustast varukoopiakausta
      TIMESTAMP=$(date +"%Y.%m.%d")
      tar -czf "${BACKUP_DIR}/varundus_${TIMESTAMP}.tar.gz" "$SOURCE_DIR"
      echo "Kaust on varundatud kausta ${BACKUP_DIR} varukoopiafailina." ;;
    k|K)
      # Kustutame allikakausta kõik failid
      rm -rf "${SOURCE_DIR:?}/"*
      echo "Kaust on tühjendatud." ;;
    *)
      echo "Vale valik. Skript lõpetab töö." ;;
  esac
else
  echo "Kausta ei leitud, skript seiskub."
fi
