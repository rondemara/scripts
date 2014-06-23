#!/bin/bash

if [ -t 0 ] ; then  
   read -s -p "Enter Password: " password
else
   password=`zenity --password --title "Enter Password:"`
fi

7z e -p$password $1

