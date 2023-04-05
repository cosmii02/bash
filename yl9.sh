#!/bin/bash

# Defineeri värvid väljundi jaoks
GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

# Genereeri suvaline number vahemikus 1 kuni 20
TARGET_NUMBER=$(( $RANDOM % 20 + 1 ))

# Funktsioon numbrite joone väljastamiseks
function print_number_line {
  printf "${GREEN}%-2d ${RESET}" $1
}

# Funktsioon horisontaalse joone väljastamiseks
function print_line {
  printf "+"
  for i in {1..39}; do
    printf "-"
  done
  printf "+\n"
}

# Väljasta mängu päis
print_line
printf "|${GREEN} ARVA NUMBRIT 1-20 ${RESET}|\n"
print_line
printf "|"
for i in {1..20}; do
  print_number_line $i
  if [ $i -eq 10 ]; then
    printf "|\n|"
  fi
done
printf "|\n"
print_line

# Palu kasutajal ära arvata number
read -p "Sisesta number: " GUESS

# Initsialiseeri katsete arv 1-ga
GUESS_COUNT=1

# Tsükkel, kuni number on õigesti ära arvatud
while [ "$GUESS" -ne "$TARGET_NUMBER" ]; do
  # Ütle kasutajale, kas pakkumine on liiga suur või väike
  if [ "$GUESS" -gt "$TARGET_NUMBER" ]; then
    printf "${RED}Number on liiga suur!${RESET}\n"
  else
    printf "${RED}Number on liiga väike!${RESET}\n"
  fi
  
  # Palu kasutajal uut pakkumist teha
  read -p "Proovi uuesti: " GUESS
  
  # Suurenda katsete arvu
  GUESS_COUNT=$(( GUESS_COUNT + 1 ))
done

# Väljasta edukas sõnum
printf "${GREEN}Õige number! Arvasid ära numbri $TARGET_NUMBER $GUESS_COUNT katsega.${RESET}\n"
