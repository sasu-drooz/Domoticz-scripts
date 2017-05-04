#!/bin/bash

#prerequis : yum install smartmontools
#pour executer automatiquement le script ajouter a crontab (crontab -e) en tant que root la ligne suivante :
# */5 * * * * /chemin-du-script/SupDisk.sh
# le script seras jouer toutes les 5 minutes
#
#verifier la valeur a surveiller en executant la commande sensors dans une fenetre de commandes 
#et remplacer temp1 par le debut de la ligne correspondant a votre cpu (souvant cpu0)


IDX=73
DomoticzIP=192.168.10.37
DomoticzPORT=8080
lecteur=/dev/sda

TEMPERATURE=$(smartctl -x $lecteur | grep "Current Temperature:" | cut -d ":" -f 2 | cut -d "C" -f1)

curl "http://192.168.10.37:8080/json.htm?type=command&param=udevice&idx=$IDX&nvalue=0&svalue=$TEMPERATURE"
