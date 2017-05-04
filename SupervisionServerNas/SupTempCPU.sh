#!/bin/bash

#prerequis : yum install lm_sensors
#pour executer automatiquement le script ajouter a crontab (crontab -e) la ligne suivante :
# */5 * * * * /chemin-du-script/SupTempCPU.sh
# le script seras jouer toutes les 5 minutes
#
#verifier la valeur a surveiller en executant la commande sensors dans une fenetre de commandes 
#et remplacer temp1 par le debut de la ligne correspondant a votre cpu (souvant cpu0)


IDX=72
DomoticzIP=192.168.10.37
DomoticzPORT=8080

TEMPERATURE=$(sensors | grep "temp1" | cut -d + -f 2 | cut -d "°" -f1)

curl "http://192.168.10.37:8080/json.htm?type=command&param=udevice&idx=$IDX&nvalue=0&svalue=$TEMPERATURE"
