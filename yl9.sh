#!/bin/bash

# Define colors for output
GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

# Generate a random number between 1 and 20
TARGET_NUMBER=$(( $RANDOM % 20 + 1 ))

# Function to output a number line
function print_number_line {
  printf "${GREEN}%-2d ${RESET}" $1
}

# Function to print a horizontal line
function print_line {
  printf "+"
  for i in {1..39}; do
    printf "-"
  done
  printf "+\n"
}

# Print game header
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

# Prompt user to guess the number
read -p "Sisesta number: " GUESS

# Initialize guess count to 1
GUESS_COUNT=1

# Loop until the guess is correct
while [ "$GUESS" -ne "$TARGET_NUMBER" ]; do
  # Tell user if guess is too high or too low
  if [ "$GUESS" -gt "$TARGET_NUMBER" ]; then
    printf "${RED}Number on liiga suur!${RESET}\n"
  else
    printf "${RED}Number on liiga väike!${RESET}\n"
  fi
  
  # Prompt user for another guess
  read -p "Proovi uuesti: " GUESS
  
  # Increment guess count
  GUESS_COUNT=$(( GUESS_COUNT + 1 ))
done

# Output success message
printf "${GREEN}Õige number! Arvasid ära numbri $TARGET_NUMBER $GUESS_COUNT katsega.${RESET}\n"
