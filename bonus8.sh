#!/bin/bash

# Define the path to the laptops file
LAPTOPS_FILE="/home/student/laptops.txt"

# Prompt user for laptop information
read -p "Sisestage sülearvuti mark: " MARK
read -p "Sisestage sülearvuti mudel: " MODEL
read -p "Sisestage sülearvuti seerianumber: " SERIAL
read -p "Sisestage sülearvuti IP-aadress: " IP
read -p "Sisestage sülearvuti hostname: " HOSTNAME

# Check if serial number or IP address is already in the file
if grep -qE "^$SERIAL |^$IP$" "$LAPTOPS_FILE"; then
  echo "Sisestatud seerianumber või IP-aadress on juba failis olemas."
  exit 1
fi

# Check if hostname is already in the file and prompt user to add or delete information
if grep -qE "^$HOSTNAME " "$LAPTOPS_FILE"; then
  read -p "Sisestatud hostname on juba failis olemas. Kas soovite andmeid lisada (l) või kustutada (k)? " CHOICE
  case $CHOICE in
    l|L) ;;
    k|K)
      # Delete line with hostname from the file
      sed -i "/^$HOSTNAME /d" "$LAPTOPS_FILE"
      echo "Andmed on kustutatud."
      exit ;;
    *) echo "Vale valik. Skript lõpetab töö." ; exit ;;
  esac
fi

# Append laptop information to the file
echo "$MARK, $MODEL, $SERIAL, $IP, $HOSTNAME" >> "$LAPTOPS_FILE"

# Check if information was added to the file
if grep -qE "^$HOSTNAME " "$LAPTOPS_FILE"; then
  echo "Andmete lisamine faili õnnestus."
else
  echo "Andmete lisamine faili ebaõnnestus."
fi
