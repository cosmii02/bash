#!/bin/bash

# defineeri muutujad sisendkaustale ja väljundkaustale
SOURCE_DIR="/var/log"
TARGET_DIR_PREFIX="/varundus"
FIRST_TARGET_DIR="${TARGET_DIR_PREFIX}/esimene"
SECOND_TARGET_DIR="${TARGET_DIR_PREFIX}/teine"
THIRD_TARGET_DIR="${TARGET_DIR_PREFIX}/kolmas"

# Defineeri funktsioon, mis kontrollib, kas kaust eksisteerib ja kui ei, siis loob selle
create_target_dir() {
  if [ ! -d "$1" ]; then
    mkdir "$1"
  fi
}

# Loome kaustad, kui neid pole olemas
create_target_dir "$FIRST_TARGET_DIR"
create_target_dir "$SECOND_TARGET_DIR"
create_target_dir "$THIRD_TARGET_DIR"

# Defineeri funktsioon, mis varundab kausta sisu teise kausta
backup_files() {
  SOURCE="$1"
  TARGET="$2"
  TIMESTAMP=$(date +"%Y.%m.%d_%H.%M.%S")
  tar -czf "${TARGET}/logs_${TIMESTAMP}.tar.gz" "$SOURCE"
}

# Varundame failid vastavalt nädalapäevale
DAY_OF_WEEK=$(date +%u)
case $DAY_OF_WEEK in
  1|3|5) backup_files "$SOURCE_DIR" "$FIRST_TARGET_DIR" ;;
  2|4|6) backup_files "$SOURCE_DIR" "$SECOND_TARGET_DIR" ;;
  7) backup_files "$SOURCE_DIR" "$THIRD_TARGET_DIR" ;;
esac
