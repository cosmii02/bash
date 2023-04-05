#!/bin/bash

# Skript küsib kasutajalt, kas ta soovib kausta kopeerida või liigutada
echo "Kas soovite kausta kopeerida (cp) või liigutada (mv)?"
read command

# Kasutaja valiku kontroll
case "$command" in
  "cp")
    # Küsime, millist kausta kopeerida
    echo "Millist kausta soovite kopeerida?"
    read source

    # Küsime, kuhu kausta kopeerida
    echo "Kuhu soovite kausta $source kopeerida?"
    read destination

    # Teostame kausta kopeerimise
    cp -r "$source" "$destination"

    # Väljastame teate kasutajale
    echo "Kausta $source kopeerimine kausta $destination on lõppenud."
    ;;
  "mv")
    # Küsime, millist kausta liigutada
    echo "Millist kausta soovite liigutada?"
    read source

    # Küsime, kuhu kausta liigutada
    echo "Kuhu soovite kausta $source liigutada?"
    read destination

    # Teostame kausta liigutamise
    mv "$source" "$destination"

    # Väljastame teate kasutajale
    echo "Kausta $source liigutamine kausta $destination on lõppenud."
    ;;
  *)
    # Tundmatu valiku korral väljastame veateate
    echo "Tundmatu valik! Skript lõpetab oma töö."
    ;;
esac

exit 0 
