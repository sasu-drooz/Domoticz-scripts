#!/bin/bash 
#
#Radiateur script
#
#utilisation de 2 pin pour envoyer 4ordres
#
# $1 => id Digital Output number 1 
# $2 => id Digital Output number 2
# $3 => satus stop , eco , gel , confort
       
if [ -n "$1" ]
 then 
  if [ -n "$2" ]
   then
	if [ "$3" = "stop" ]
	 then
		  wget http://192.168.10.177/a?command=$2off 
		  rm a?command=$2off
		  wget http://192.168.10.177/a?command=$1on 
		  rm a?command=$1on
		  exit 
	fi
	if [ "$3" = "confort" ]
	 then
		  wget http://192.168.10.177/a?command=$1on 
		  rm a?command=$1on
		  wget http://192.168.10.177/a?command=$2on 
		  rm a?command=$2on
		  exit 
	fi
	if [ "$3" = "gel" ]
	 then
		  wget http://192.168.10.177/a?command=$1off 
		  rm a?command=$1off
		  wget http://192.168.10.177/a?command=$2on 
		  rm a?command=$2on
		  exit 
	fi
	if [ "$3" = "eco" ]
	 then
		  wget http://192.168.10.177/a?command=$1off 
		  rm a?command=$1off
		  wget http://192.168.10.177/a?command=$2off 
		  rm a?command=$2off
		  exit 
	fi
  fi
fi

