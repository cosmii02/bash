#!/bin/bash

# Skript teostab ühe kausta varundamise teise kausta tar käsuga ja lisab varundusfaili nimesse tänase kuupäeva ja kellaaja ning lisab failinimele logsbu eesliite
# Varundatava kausta teekond
source_folder="/var/log"

# Varunduse kausta sihtkaust
destination_folder="/varundus"

# Loome varundusfaili nime
backup_name="$(date +"%y.%m.%d_%H.%M.%S")"
backup_name="logsbu_$backup_name.tar.gz"

# Teostame varunduse tar käsuga ja peidame väljundi
tar -czf "$destination_folder/$backup_name" -C "$source_folder" . >/dev/null 2>&1

# Skript ei väljasta käivitamisel teadet

# Väljastame teate ja failinime
echo "Varundus $source_folder kaustast $destination_folder kausta on lõppenud."
echo "Varundusfail: $backup_name"
