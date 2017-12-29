#!/bin/bash 
#
#light script
#
# $1 => id Digital Output number
# $2 => satus on or off  ==> desactivé pour telerupteur
       
if [ -n "$1" ]
 then 
  if [ -n "$2" ]
   then
		  # wget http://192.168.10.177/a?command=$1$2 tmp  	# cas interrupteur simlpe
		  wget http://192.168.10.177/a?command=$1on		# cas telerupteur
		  rm a?command=$1on
		  wget http://192.168.10.177/a?command=$1off 	# cas telerupteur
		  rm a?command=$1off
		  exit 
  fi
fi
