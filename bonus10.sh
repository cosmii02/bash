#!/bin/bash

# Küsime kasutajanime
read -p "Sisesta kasutajanimi: " username

# Kontrollime, kas kasutajanimi on juba olemas
while grep -q "^$username:" /etc/passwd; do
    read -p "Kasutajanimi on juba olemas, sisesta uus kasutajanimi: " username
done

# Küsime, kas luua kasutajale kodukaust
read -p "Kas luua kodukaust kasutajale $username? (y/n): " create_home

# Luuakse kodukaust ainult siis, kui kasutaja soovib
if [ "$create_home" == "y" ]; then
    home_option="-m"
else
    home_option=""
fi

# Küsime, kas luua kasutajale vastav grupp
read -p "Kas luua kasutajale $username vastav grupp? (y/n): " create_group

# Luuakse kasutajale vastav grupp ainult siis, kui kasutaja soovib
if [ "$create_group" == "y" ]; then
    group_option="-U"
else
    group_option=""
fi

# Küsime, kas lisada kasutajale kirjeldus
read -p "Kas lisada kasutajale $username kirjeldus? (y/n): " create_description

# Lisatakse kirjeldus ainult siis, kui kasutaja soovib
if [ "$create_description" == "y" ]; then
    read -p "Sisesta kasutaja kirjeldus: " description
    description_option="-c \"$description\""
else
    description_option=""
fi

# Küsime, kas määrata kasutajale parool
read -p "Kas määrata kasutajale $username parool? (y/n): " create_password

# Kui kasutaja soovib parooli, siis küsitakse see sisestada
if [ "$create_password" == "y" ]; then
    read -s -p "Sisesta parool: " password
    echo "$username:$password" | chpasswd
fi

# Kasutaja luuakse useradd käsuga, mis sisaldab kõiki valikuid
useradd "$home_option" "$group_option" "$description_option" "$username"

echo "Kasutaja $username on loodud."
